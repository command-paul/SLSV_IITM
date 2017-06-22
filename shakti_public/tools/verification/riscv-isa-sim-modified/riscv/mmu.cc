// See LICENSE for license details.

#include "mmu.h"
#include "sim.h"
#include "processor.h"
#include <string> // nandu
#include <iomanip> // nandu

mmu_t::mmu_t(sim_t* sim, processor_t* proc)
 : sim(sim), proc(proc),
  check_triggers_fetch(false),
  check_triggers_load(false),
  check_triggers_store(false),
  matched_trigger(NULL)
{
  flush_tlb();
}

mmu_t::~mmu_t()
{
}

void mmu_t::flush_icache()
{
  for (size_t i = 0; i < ICACHE_ENTRIES; i++)
    icache[i].tag = -1;
}

void mmu_t::flush_tlb()
{
  memset(tlb_insn_tag, -1, sizeof(tlb_insn_tag));
  memset(tlb_load_tag, -1, sizeof(tlb_load_tag));
  memset(tlb_store_tag, -1, sizeof(tlb_store_tag));

  flush_icache();
}

reg_t mmu_t::translate(reg_t addr, access_type type)
{
  if (!proc)
    return addr;

  reg_t mode = proc->state.prv;
  if (type != FETCH) {
    if (!proc->state.dcsr.cause && get_field(proc->state.mstatus, MSTATUS_MPRV))
      mode = get_field(proc->state.mstatus, MSTATUS_MPP);
  }
  if (get_field(proc->state.mstatus, MSTATUS_VM) == VM_MBARE)
    mode = PRV_M;

  if (mode == PRV_M) {
    reg_t msb_mask = (reg_t(2) << (proc->xlen-1))-1; // zero-extend from xlen
    return addr & msb_mask;
  }
  return walk(addr, type, mode) | (addr & (PGSIZE-1));
}

const uint16_t* mmu_t::fetch_slow_path(reg_t vaddr)
{
  reg_t paddr = translate(vaddr, FETCH);

  // mmu_t::walk() returns -1 if it can't find a match. Of course -1 could also
  // be a valid address.
  if (paddr == ~(reg_t) 0 && vaddr != ~(reg_t) 0) {
    throw trap_instruction_access_fault(vaddr);
  }

  if (sim->addr_is_mem(paddr)) {
    refill_tlb(vaddr, paddr, FETCH);
    return (const uint16_t*)sim->addr_to_mem(paddr);
  } else {
    if (!sim->mmio_load(paddr, sizeof fetch_temp, (uint8_t*)&fetch_temp))
      throw trap_instruction_access_fault(vaddr);
    return &fetch_temp;
  }
}

reg_t reg_from_bytes(size_t len, const uint8_t* bytes)
{
  switch (len) {
    case 1:
      return bytes[0];
    case 2:
      return bytes[0] |
        (((reg_t) bytes[1]) << 8);
    case 4:
      return bytes[0] |
        (((reg_t) bytes[1]) << 8) |
        (((reg_t) bytes[2]) << 16) |
        (((reg_t) bytes[3]) << 24);
    case 8:
      return bytes[0] |
        (((reg_t) bytes[1]) << 8) |
        (((reg_t) bytes[2]) << 16) |
        (((reg_t) bytes[3]) << 24) |
        (((reg_t) bytes[4]) << 32) |
        (((reg_t) bytes[5]) << 40) |
        (((reg_t) bytes[6]) << 48) |
        (((reg_t) bytes[7]) << 56);
  }
  abort();
}

void mmu_t::load_slow_path(reg_t addr, reg_t len, uint8_t* bytes)
{
  reg_t paddr = translate(addr, LOAD);

  if (sim->addr_is_mem(paddr)) {
    memcpy(bytes, sim->addr_to_mem(paddr), len);
    if (tracer.interested_in_range(paddr, paddr + PGSIZE, LOAD))
      tracer.trace(paddr, len, LOAD);
    else
      refill_tlb(addr, paddr, LOAD);
  } else if (!sim->mmio_load(paddr, len, bytes)) {
    throw trap_load_access_fault(addr);
  }

  if (!matched_trigger) {
    reg_t data = reg_from_bytes(len, bytes);
    matched_trigger = trigger_exception(OPERATION_LOAD, addr, data);
    if (matched_trigger)
      throw *matched_trigger;
  }
}

void mmu_t::store_slow_path(reg_t addr, reg_t len, const uint8_t* bytes)
{
  reg_t paddr = translate(addr, STORE);

  if (!matched_trigger) {
    reg_t data = reg_from_bytes(len, bytes);
    matched_trigger = trigger_exception(OPERATION_STORE, addr, data);
    if (matched_trigger)
      throw *matched_trigger;
  }

  if (sim->addr_is_mem(paddr)) {
    memcpy(sim->addr_to_mem(paddr), bytes, len);
    if (tracer.interested_in_range(paddr, paddr + PGSIZE, STORE))
      tracer.trace(paddr, len, STORE);
    else
      refill_tlb(addr, paddr, STORE);
  } else if (!sim->mmio_store(paddr, len, bytes)) {
    throw trap_store_access_fault(addr);
  }
}

void mmu_t::refill_tlb(reg_t vaddr, reg_t paddr, access_type type)
{
  reg_t idx = (vaddr >> PGSHIFT) % TLB_ENTRIES;
  reg_t expected_tag = vaddr >> PGSHIFT;

  if ((tlb_load_tag[idx] & ~TLB_CHECK_TRIGGERS) != expected_tag)
    tlb_load_tag[idx] = -1;
  if ((tlb_store_tag[idx] & ~TLB_CHECK_TRIGGERS) != expected_tag)
    tlb_store_tag[idx] = -1;
  if ((tlb_insn_tag[idx] & ~TLB_CHECK_TRIGGERS) != expected_tag)
    tlb_insn_tag[idx] = -1;

  if ((check_triggers_fetch && type == FETCH) ||
      (check_triggers_load && type == LOAD) ||
      (check_triggers_store && type == STORE))
    expected_tag |= TLB_CHECK_TRIGGERS;

  if (type == FETCH) tlb_insn_tag[idx] = expected_tag;
  else if (type == STORE) tlb_store_tag[idx] = expected_tag;
  else tlb_load_tag[idx] = expected_tag;

  tlb_data[idx] = sim->addr_to_mem(paddr) - vaddr;
}

reg_t mmu_t::walk(reg_t addr, access_type type, reg_t mode)
{
  int levels, ptidxbits, ptesize;
  switch (get_field(proc->get_state()->mstatus, MSTATUS_VM))
  {
    case VM_SV32: levels = 2; ptidxbits = 10; ptesize = 4; break;
    case VM_SV39: levels = 3; ptidxbits = 9; ptesize = 8; break;
    case VM_SV48: levels = 4; ptidxbits = 9; ptesize = 8; break;
    default: abort();
  }

  bool supervisor = mode == PRV_S;
  bool pum = get_field(proc->state.mstatus, MSTATUS_PUM);
  bool mxr = get_field(proc->state.mstatus, MSTATUS_MXR);

  // verify bits xlen-1:va_bits-1 are all equal
  int va_bits = PGSHIFT + levels * ptidxbits;
  reg_t mask = (reg_t(1) << (proc->xlen - (va_bits-1))) - 1;
  reg_t masked_msbs = (addr >> (va_bits-1)) & mask;
  if (masked_msbs != 0 && masked_msbs != mask)
    return -1;

  reg_t base = proc->get_state()->sptbr << PGSHIFT;
  int ptshift = (levels - 1) * ptidxbits;
  for (int i = 0; i < levels; i++, ptshift -= ptidxbits) {
    reg_t idx = (addr >> (PGSHIFT + ptshift)) & ((1 << ptidxbits) - 1);

    // check that physical address of PTE is legal
    reg_t pte_addr = base + idx * ptesize;
    if (!sim->addr_is_mem(pte_addr))
      break;

    void* ppte = sim->addr_to_mem(pte_addr);
    reg_t pte = ptesize == 4 ? *(uint32_t*)ppte : *(uint64_t*)ppte;
    reg_t ppn = pte >> PTE_PPN_SHIFT;

    if (PTE_TABLE(pte)) { // next level of page table
      base = ppn << PGSHIFT;
    } else if ((pte & PTE_U) ? supervisor && pum : !supervisor) {
      break;
    } else if (!(pte & PTE_V) || (!(pte & PTE_R) && (pte & PTE_W))) {
      break;
    } else if (type == FETCH ? !(pte & PTE_X) :
               type == LOAD ?  !(pte & PTE_R) && !(mxr && (pte & PTE_X)) :
                               !((pte & PTE_R) && (pte & PTE_W))) {
      break;
    } else {
      // set accessed and possibly dirty bits.
      *(uint32_t*)ppte |= PTE_A | ((type == STORE) * PTE_D);
      // for superpage mappings, make a fake leaf PTE for the TLB's benefit.
      reg_t vpn = addr >> PGSHIFT;
      reg_t value = (ppn | (vpn & ((reg_t(1) << ptshift) - 1))) << PGSHIFT;
      return value;
    }
  }

  return -1;
}

void mmu_t::register_memtracer(memtracer_t* t)
{
  flush_tlb();
  tracer.hook(t);
}
/* Entire function below is by nandu*/
void mmu_t::memory_dump( unsigned int start, unsigned int stop){
	std::ofstream memoryDumpFile, memoryDumpReadableFile;
	memoryDumpFile.open("memoryDump.txt");
	memoryDumpReadableFile.open("memoryDumpReadable.txt");

	reg_t sAddr = translate(start, LOAD);
	reg_t eAddr = translate(stop, LOAD);

	fprintf(stderr,"startaddr=%lu  stopaddr=%lu\n",sAddr,eAddr);
	while(sAddr < eAddr){
		memoryDumpFile<<std::setfill('0')<<std::setw(16)<<std::hex<<*((uint64_t*)(sim->addr_to_mem(sAddr)))<<"\n";
		for(int i=0;i<8;i++){
			memoryDumpReadableFile<<(char)(*((uint8_t*)(sim->addr_to_mem(sAddr))));
			sAddr++;
		}
	}
	memoryDumpFile.close();
	memoryDumpReadableFile.close();
}

