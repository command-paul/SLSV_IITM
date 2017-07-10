// See LICENSE for license details.
#include "var_track.h"
#include "processor.h"
#include "mmu.h"
#include "sim.h"
#include <cassert>
#include "csr_disass.h"

static void commit_log_stash_privilege(state_t* state)
{
#ifdef RISCV_ENABLE_COMMITLOG
  state->last_inst_priv = state->prv;
#endif
}

static void commit_log_print_insn(state_t* state, reg_t pc, insn_t insn)
{
#ifdef RISCV_ENABLE_COMMITLOG
  extern var_track Single_Core_Track;
  int32_t priv = state->last_inst_priv;
  uint64_t mask = (insn.length() == 8 ? uint64_t(0) : (uint64_t(1) << (insn.length() * 8))) - 1;
  //Change in Register || I'm keeping them seperate because a format has not been defined for verification 
  bool xf =state->log_reg_write.addr & 1 ;
  unsigned int reg_addr  = state->log_reg_write.addr>>1;  
  if ((state->log_reg_write.addr != 0) && ((Single_Core_Track.careX(reg_addr)&&(xf==0)) || (Single_Core_Track.careF(reg_addr)&& (xf==1)))) {
    fprintf(stderr, "%1d 0x%016" PRIx64 " (0x%08" PRIx64 ") %c%2" PRIu64 " 0x%016" PRIx64 "::::%d,%u\n",
            priv,
            pc,
            insn.bits() & mask,
            state->log_reg_write.addr & 1 ? 'f' : 'x', // original inplememtation reg update print
            state->log_reg_write.addr >> 1,
            state->log_reg_write.data,xf,reg_addr);
    //if(state->log_reg_write.addr & 1)fprintf(stderr ,">> FCSR %016" PRIx64 "\n",((state->fflags << FSR_AEXC_SHIFT) | (state->frm << FSR_RD_SHIFT)));
    // ^ one line mod to print FCSR when any floating point reg is updated.
  } 
  //change in memory
  else if ((state->store_addr)&&(Single_Core_Track.careM(state->store_addr))) {
    fprintf(stderr, "%1d 0x%016" PRIx64 " (0x%08" PRIx64 ") STORE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>- MEM:: 0x%016" PRIx64 " 0x%016" PRIx64 "\n",
            priv,
            pc,
            insn.bits() & mask,
            state->store_addr,
            state->store_val);
  }
  // Change in CSR triggered by SetCSR function -- need to expand to support changes affected otherwise
  else if ((state->csr_addr > 0)&&(Single_Core_Track.careC(state->csr_addr))){
    fprintf(stderr, "%1d 0x%016" PRIx64 " (0x%08" PRIx64 ") %s %d 0x%016" PRIx64 "\n",
            priv,
            pc,
            insn.bits() & mask,
            csr_disass(state->csr_addr).c_str(),
            state->csr_addr,
            state->csr_val);
  }
  else {
    if (Single_Core_Track.careP(0)) fprintf(stderr, "%1d 0x%016" PRIx64 " (0x%016" PRIx64 ")\n", priv, pc, insn.bits() /*& mask*/);
  }
  state->csr_addr = -1;
  state->store_addr = 0;
  state->log_reg_write.addr = 0;
#endif
}

inline void processor_t::update_histogram(reg_t pc)
{
#ifdef RISCV_ENABLE_HISTOGRAM
  pc_histogram[pc]++;
#endif
}

// This is expected to be inlined by the compiler so each use of execute_insn
// includes a duplicated body of the function to get separate fetch.func
// function calls.
static reg_t execute_insn(processor_t* p, reg_t pc, insn_fetch_t fetch)
{
  commit_log_stash_privilege(p->get_state());
  reg_t npc = fetch.func(p, fetch.insn, pc);
  if (!invalid_pc(npc)) {
    commit_log_print_insn(p->get_state(), pc, fetch.insn);
    p->update_histogram(pc);
  }
  return npc;
}

bool processor_t::slow_path()
{
  return debug || state.single_step != state.STEP_NONE || state.dcsr.cause;
}

// fetch/decode/execute loop
void processor_t::step(size_t n)
{
  if (state.dcsr.cause == DCSR_CAUSE_NONE) {
    if (halt_request) {
      enter_debug_mode(DCSR_CAUSE_DEBUGINT);
    } // !!!The halt bit in DCSR is deprecated.
    else if (state.dcsr.halt) {
      enter_debug_mode(DCSR_CAUSE_HALT);
    }
  }

  while (n > 0) {
    size_t instret = 0;
    reg_t pc = state.pc;
    mmu_t* _mmu = mmu;

    #define advance_pc() \
     if (unlikely(invalid_pc(pc))) { \
       switch (pc) { \
         case PC_SERIALIZE_BEFORE: state.serialized = true; break; \
         case PC_SERIALIZE_AFTER: n = ++instret; break; \
         default: abort(); \
       } \
       pc = state.pc; \
       break; \
     } else { \
       state.pc = pc; \
       instret++; \
     }

    try
    {
      take_pending_interrupt();

      if (unlikely(slow_path()))
      {
        while (instret < n)
        {
          if (unlikely(state.single_step == state.STEP_STEPPING)) {
            state.single_step = state.STEP_STEPPED;
          }

          insn_fetch_t fetch = mmu->load_insn(pc);
          if (debug && !state.serialized)
            disasm(fetch.insn);
          pc = execute_insn(this, pc, fetch);
          bool serialize_before = (pc == PC_SERIALIZE_BEFORE);

          advance_pc();

          if (unlikely(state.single_step == state.STEP_STEPPED) && !serialize_before) {
            state.single_step = state.STEP_NONE;
            enter_debug_mode(DCSR_CAUSE_STEP);
            // enter_debug_mode changed state.pc, so we can't just continue.
            break;
          }

          if (unlikely(state.pc >= DEBUG_START &&
                       state.pc < DEBUG_END)) {
            // We're waiting for the debugger to tell us something.
            return;
          }

          
          
        }
      }
      else while (instret < n)
      {
        // This code uses a modified Duff's Device to improve the performance
        // of executing instructions. While typical Duff's Devices are used
        // for software pipelining, the switch statement below primarily
        // benefits from separate call points for the fetch.func function call
        // found in each execute_insn. This function call is an indirect jump
        // that depends on the current instruction. By having an indirect jump
        // dedicated for each icache entry, you improve the performance of the
        // host's next address predictor. Each case in the switch statement
        // allows for the program flow to contine to the next case if it
        // corresponds to the next instruction in the program and instret is
        // still less than n.
        //
        // According to Andrew Waterman's recollection, this optimization
        // resulted in approximately a 2x performance increase.
        //
        // If there is support for compressed instructions, the mmu and the
        // switch statement get more complicated. Each branch target is stored
        // in the index corresponding to mmu->icache_index(), but consecutive
        // non-branching instructions are stored in consecutive indices even if
        // mmu->icache_index() specifies a different index (which is the case
        // for 32-bit instructions in the presence of compressed instructions).

        // This figures out where to jump to in the switch statement
        size_t idx = _mmu->icache_index(pc);

        // This gets the cached decoded instruction form the MMU. If the MMU
        // does not have the current pc cached, it will refill the MMU and
        // return the correct entry. ic_entry->data.func is the C++ function
        // corresponding to the instruction.
        auto ic_entry = _mmu->access_icache(pc);

        // This macro is included in "icache.h" included within the switch
        // statement below. The indirect jump corresponding to the instruction
        // is located within the execute_insn() function call.
        #define ICACHE_ACCESS(i) { \
          insn_fetch_t fetch = ic_entry->data; \
          ic_entry++; \
          pc = execute_insn(this, pc, fetch); \
          if (i == mmu_t::ICACHE_ENTRIES-1) break; \
          if (unlikely(ic_entry->tag != pc)) goto miss; \
          if (unlikely(instret+1 == n)) break; \
          instret++; \
          state.pc = pc; \
        }

        // This switch statement implements the modified Duff's device as
        // explained above.
        switch (idx) {
          // "icache.h" is generated by the gen_icache script
          #include "icache.h"
        }

        advance_pc();
        continue;

miss:
        advance_pc();
        // refill I$ if it looks like there wasn't a taken branch
        if (pc > (ic_entry-1)->tag && pc <= (ic_entry-1)->tag + MAX_INSN_LENGTH)
          _mmu->refill_icache(pc, ic_entry);
      }
    }
    catch(trap_t& t)
    {
      take_trap(t, pc);
      n = instret;

      if (unlikely(state.single_step == state.STEP_STEPPED)) {
        state.single_step = state.STEP_NONE;
        enter_debug_mode(DCSR_CAUSE_STEP);
      }
    }
    catch (trigger_matched_t& t)
    {
      if (mmu->matched_trigger) {
        // This exception came from the MMU. That means the instruction hasn't
        // fully executed yet. We start it again, but this time it won't throw
        // an exception because matched_trigger is already set. (All memory
        // instructions are idempotent so restarting is safe.)

        insn_fetch_t fetch = mmu->load_insn(pc);
        pc = execute_insn(this, pc, fetch);
        advance_pc();

        delete mmu->matched_trigger;
        mmu->matched_trigger = NULL;
      }
      switch (state.mcontrol[t.index].action) {
        case ACTION_DEBUG_MODE:
          enter_debug_mode(DCSR_CAUSE_HWBP);
          break;
        case ACTION_DEBUG_EXCEPTION: {
          mem_trap_t trap(CAUSE_BREAKPOINT, t.address);
          take_trap(trap, pc);
          break;
        }
        default:
          abort();
      }
    }

    state.minstret += instret;
    n -= instret;
  }
}
