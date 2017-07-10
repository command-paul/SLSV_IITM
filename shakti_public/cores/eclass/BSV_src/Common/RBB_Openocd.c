#include <stdio.h>

#include "decode.h"
#include "jtag_dtm.h"
#include "debug_module.h"
#include "debug_defines.h"

#if 0
#  define D(x) x
#else
#  define D(x)
#endif

enum {
  IR_IDCODE=1,
  IR_DTMCONTROL=0x10,
  IR_DBUS=0x11
};

#define DTMCONTROL_VERSION      0xf
#define DTMCONTROL_ABITS        (0x3f << 4)
#define DTMCONTROL_DBUSSTAT     (3<<10)
#define DTMCONTROL_IDLE         (7<<12)
#define DTMCONTROL_DBUSRESET    (1<<16)

#define DMI_OP                 3
#define DMI_DATA               (0xffffffffL<<2)
#define DMI_ADDRESS            ((1L<<(abits+34)) - (1L<<34))

#define DMI_OP_STATUS_SUCCESS 0
#define DMI_OP_STATUS_RESERVED  1
#define DMI_OP_STATUS_FAILED  2
#define DMI_OP_STATUS_BUSY  3

#define DMI_OP_NOP          0
#define DMI_OP_READ         1
#define DMI_OP_WRITE          2
#define DMI_OP_RESERVED         3
//----------------------------------------------------------------------------





#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <algorithm>
#include <cassert>
#include <cstdio>

#include "remote_bitbang.h"

#if 1
#  define D(x) x
#else
#  define D(x)
#endif

/////////// remote_bitbang_t

// constructor  
remote_bitbang_t(uint16_t port, jtag_dtm_t *tap) :
  tap(tap),
  socket_fd(0),
  client_fd(0),
  recv_start(0),
  recv_end(0)
{
  socket_fd = socket(AF_INET, SOCK_STREAM, 0);
  if (socket_fd == -1) {
    fprintf(stderr, "remote_bitbang failed to make socket: %s (%d)\n",
        strerror(errno), errno);
    abort();
  }

  fcntl(socket_fd, F_SETFL, O_NONBLOCK);
  int reuseaddr = 1;
  if (setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &reuseaddr,
        sizeof(int)) == -1) {
    fprintf(stderr, "remote_bitbang failed setsockopt: %s (%d)\n",
        strerror(errno), errno);
    abort();
  }

  struct sockaddr_in addr;
  memset(&addr, 0, sizeof(addr));
  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = INADDR_ANY;
  addr.sin_port = htons(port);

  if (bind(socket_fd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
    fprintf(stderr, "remote_bitbang failed to bind socket: %s (%d)\n",
        strerror(errno), errno);
    abort();
  }

  if (listen(socket_fd, 1) == -1) {
    fprintf(stderr, "remote_bitbang failed to listen on socket: %s (%d)\n",
        strerror(errno), errno);
    abort();
  }

  socklen_t addrlen = sizeof(addr);
  if (getsockname(socket_fd, (struct sockaddr *) &addr, &addrlen) == -1) {
    fprintf(stderr, "remote_bitbang getsockname failed: %s (%d)\n",
        strerror(errno), errno);
    abort();
  }

  printf("Listening for remote bitbang connection on port %d.\n",
      ntohs(addr.sin_port));
  fflush(stdout);
}

void accept()
{
  client_fd = ::accept(socket_fd, NULL, NULL);
  if (client_fd == -1) {
    if (errno == EAGAIN) {
      // No client waiting to connect right now.
    } else {
      fprintf(stderr, "failed to accept on socket: %s (%d)\n", strerror(errno),
          errno);
      abort();
    }
  } else {
    fcntl(client_fd, F_SETFL, O_NONBLOCK);
  }
}

void tick()
{
  if (client_fd > 0) {
    execute_commands();
  } else {
    this->accept();
  }
}

void execute_commands()
{
  static char send_buf[buf_size];
  unsigned total_processed = 0;
  bool quit = false;
  bool in_rti = tap->state() == RUN_TEST_IDLE;
  bool entered_rti = false;
  while (1) {
    if (recv_start < recv_end) {
      unsigned send_offset = 0;
      while (recv_start < recv_end) {
        uint8_t command = recv_buf[recv_start];

        switch (command) {
          case 'B': /* fprintf(stderr, "*BLINK*\n"); */ break;
          case 'b': /* fprintf(stderr, "_______\n"); */ break;
          case 'r': tap->reset(); break;
          case '0': tap->set_pins(0, 0, 0); break;
          case '1': tap->set_pins(0, 0, 1); break;
          case '2': tap->set_pins(0, 1, 0); break;
          case '3': tap->set_pins(0, 1, 1); break;
          case '4': tap->set_pins(1, 0, 0); break;
          case '5': tap->set_pins(1, 0, 1); break;
          case '6': tap->set_pins(1, 1, 0); break;
          case '7': tap->set_pins(1, 1, 1); break;
          case 'R': send_buf[send_offset++] = tap->tdo() ? '1' : '0'; break;
          case 'Q': quit = true; break;
          default:
                    fprintf(stderr, "remote_bitbang got unsupported command '%c'\n",
                        command);
        }
        recv_start++;
        total_processed++;
        if (!in_rti && tap->state() == RUN_TEST_IDLE) {
          entered_rti = true;
          break;
        }
        in_rti = false;
      }
      unsigned sent = 0;
      while (sent < send_offset) {
        ssize_t bytes = write(client_fd, send_buf + sent, send_offset);
        if (bytes == -1) {
          fprintf(stderr, "failed to write to socket: %s (%d)\n", strerror(errno), errno);
          abort();
        }
        sent += bytes;
      }
    }

    if (total_processed > buf_size || quit || entered_rti) {
      // Don't go forever, because that could starve the main simulation.
      break;
    }

    recv_start = 0;
    recv_end = read(client_fd, recv_buf, buf_size);

    if (recv_end == -1) {
      if (errno == EAGAIN) {
        break;
      } else {
        fprintf(stderr, "remote_bitbang failed to read on socket: %s (%d)\n",
            strerror(errno), errno);
        abort();
      }
    }

    if (quit) {
      fprintf(stderr, "Remote Bitbang received 'Q'\n");
    }

    if (recv_end == 0 || quit) {
      // The remote disconnected.
      fprintf(stderr, "Received nothing. Quitting.\n");
      close(client_fd);
      client_fd = 0;
      break;
    }
  }
}








//-----------------------------------------------------------------------------

//constructor
jtag_dtm_t::jtag_dtm_t(debug_module_t *dm) :
  dm(dm),
  _tck(false), _tms(false), _tdi(false), _tdo(false),
  dtmcontrol((abits << DTM_DTMCS_ABITS_OFFSET) | 1),
  dmi(DMI_OP_STATUS_FAILED << DTM_DMI_OP_OFFSET),
  _state(TEST_LOGIC_RESET)
{
}

void jtag_dtm_t::reset() {
  _state = TEST_LOGIC_RESET;
}

void jtag_dtm_t::set_pins(bool tck, bool tms, bool tdi) {
  const jtag_state_t next[16][2] = {
    /* TEST_LOGIC_RESET */    { RUN_TEST_IDLE, TEST_LOGIC_RESET },
    /* RUN_TEST_IDLE */       { RUN_TEST_IDLE, SELECT_DR_SCAN },
    /* SELECT_DR_SCAN */      { CAPTURE_DR, SELECT_IR_SCAN },
    /* CAPTURE_DR */          { SHIFT_DR, EXIT1_DR },
    /* SHIFT_DR */            { SHIFT_DR, EXIT1_DR },
    /* EXIT1_DR */            { PAUSE_DR, UPDATE_DR },
    /* PAUSE_DR */            { PAUSE_DR, EXIT2_DR },
    /* EXIT2_DR */            { SHIFT_DR, UPDATE_DR },
    /* UPDATE_DR */           { RUN_TEST_IDLE, SELECT_DR_SCAN },
    /* SELECT_IR_SCAN */      { CAPTURE_IR, TEST_LOGIC_RESET },
    /* CAPTURE_IR */          { SHIFT_IR, EXIT1_IR },
    /* SHIFT_IR */            { SHIFT_IR, EXIT1_IR },
    /* EXIT1_IR */            { PAUSE_IR, UPDATE_IR },
    /* PAUSE_IR */            { PAUSE_IR, EXIT2_IR },
    /* EXIT2_IR */            { SHIFT_IR, UPDATE_IR },
    /* UPDATE_IR */           { RUN_TEST_IDLE, SELECT_DR_SCAN }
  };

  if (!_tck && tck) {
    // Positive clock edge.

    switch (_state) {
      case SHIFT_DR:
        dr >>= 1;
        dr |= (uint64_t) _tdi << (dr_length-1);
        break;
      case SHIFT_IR:
        ir >>= 1;
        ir |= _tdi << (ir_length-1);
        break;
      default:
        break;
    }
    _state = next[_state][_tms];
    switch (_state) {
      case TEST_LOGIC_RESET:
        ir = IR_IDCODE;
        break;
      case CAPTURE_DR:
        capture_dr();
        break;
      case SHIFT_DR:
        _tdo = dr & 1;
        break;
      case UPDATE_DR:
        update_dr();
        break;
      case CAPTURE_IR:
        break;
      case SHIFT_IR:
        _tdo = ir & 1;
        break;
      case UPDATE_IR:
        break;
      default:
        break;
    }
  }

  fprintf(stderr, "state=%2d, tdi=%d, tdo=%d, tms=%d, tck=%d, ir=0x%02x, "
        "dr=0x%lx\n",
        _state, _tdi, _tdo, _tms, _tck, ir, dr);

  _tck = tck;
  _tms = tms;
  _tdi = tdi;
}

void capture_dr()
{
  switch (ir) {
    case IR_IDCODE:
      dr = idcode;
      dr_length = 32;
      break;
    case IR_DTMCONTROL:
      dr = dtmcontrol;
      dr_length = 32;
      break;
    case IR_DBUS:
      dr = dmi;
      dr_length = abits + 34;
      break;
    default:
      D(fprintf(stderr, "Unsupported IR: 0x%x\n", ir));
      break;
  }
  D(fprintf(stderr, "Capture DR; IR=0x%x, DR=0x%lx (%d bits)\n",
        ir, dr, dr_length));
}
  
void update_dr()
{
  D(fprintf(stderr, "Update DR; IR=0x%x, DR=0x%lx (%d bits)\n",
        ir, dr, dr_length));
  switch (ir) {
    case IR_DBUS:
      {
        unsigned op = get_field(dr, DMI_OP);
        uint32_t data = get_field(dr, DMI_DATA);
        unsigned address = get_field(dr, DMI_ADDRESS);

        dmi = dr;

        bool success = true;
        if (op == DMI_OP_READ) {
          uint32_t value;
          if (dm->dmi_read(address, &value)) {
            dmi = set_field(dmi, DMI_DATA, value);
          } else {
            success = false;
          }
        } else if (op == DMI_OP_WRITE) {
          success = dm->dmi_write(address, data);
        }

        if (success) {
          dmi = set_field(dmi, DMI_OP, DMI_OP_STATUS_SUCCESS);
        } else {
          dmi = set_field(dmi, DMI_OP, DMI_OP_STATUS_FAILED);
        }
        D(fprintf(stderr, "dmi=0x%lx\n", dmi));
      }
      break;
  }
}

// class constructor
debug_module_t(sim_t *sim) : sim(sim)
{
  dmcontrol = {0};

  dmstatus = {0};
  dmstatus.authenticated = 1;
  dmstatus.versionlo = 2;

  abstractcs = {0};
  abstractcs.progsize = progsize;

  abstractauto = {0};

  memset(halted, 0, sizeof(halted));
  memset(debug_rom_flags, 0, sizeof(debug_rom_flags));
  memset(resumeack, 0, sizeof(resumeack));
  memset(program_buffer, 0, sizeof(program_buffer));
  memset(dmdata, 0, sizeof(dmdata));

  write32(debug_rom_whereto, 0,
          jal(ZERO, debug_abstract_start - DEBUG_ROM_WHERETO));

  memset(debug_abstract, 0, sizeof(debug_abstract));
 
}

void reset()
{
  for (unsigned i = 0; i < sim->nprocs(); i++) {
    processor_t *proc = sim->get_core(i);
    if (proc)
      proc->halt_request = false;
  }

  dmcontrol = {0};

  dmstatus = {0};
  dmstatus.authenticated = 1;
  dmstatus.versionlo = 2;

  abstractcs = {0};
  abstractcs.datacount = sizeof(dmdata) / 4;
  abstractcs.progsize = progsize;

  abstractauto = {0};
}


bool load(reg_t addr, size_t len, uint8_t* bytes)
{
  addr = DEBUG_START + addr;

  if (addr >= DEBUG_ROM_ENTRY &&
      (addr + len) <= (DEBUG_ROM_ENTRY + debug_rom_raw_len)) {
    memcpy(bytes, debug_rom_raw + addr - DEBUG_ROM_ENTRY, len);
    return true;
  }

  if (addr >= DEBUG_ROM_WHERETO && (addr + len) <= (DEBUG_ROM_WHERETO + 4)) {
    memcpy(bytes, debug_rom_whereto + addr - DEBUG_ROM_WHERETO, len);
    return true;
  }

  if (addr >= DEBUG_ROM_FLAGS && ((addr + len) <= DEBUG_ROM_FLAGS + 1024)) {
    memcpy(bytes, debug_rom_flags + addr - DEBUG_ROM_FLAGS, len);
    return true;
  }

  if (addr >= debug_abstract_start && ((addr + len) <= (debug_abstract_start + sizeof(debug_abstract)))) {
    memcpy(bytes, debug_abstract + addr - debug_abstract_start, len);
    return true;
  }

  if (addr >= debug_data_start && (addr + len) <= (debug_data_start + sizeof(dmdata))) {
    memcpy(bytes, dmdata + addr - debug_data_start, len);
    return true;
  }
  
  if (addr >= debug_progbuf_start && ((addr + len) <= (debug_progbuf_start + sizeof(program_buffer)))) {
    memcpy(bytes, program_buffer + addr - debug_progbuf_start, len);
    return true;
  }

  fprintf(stderr, "ERROR: invalid load from debug module: %zd bytes at 0x%016"
          PRIx64 "\n", len, addr);

  return false;
}

bool store(reg_t addr, size_t len, const uint8_t* bytes)
{

  uint8_t id_bytes[4];
  uint32_t id = 0;
  if (len == 4) {
    memcpy(id_bytes, bytes, 4);
    id = read32(id_bytes, 0);
  }

  addr = DEBUG_START + addr;
  
  if (addr >= debug_data_start && (addr + len) <= (debug_data_start + sizeof(dmdata))) {
    memcpy(dmdata + addr - debug_data_start, bytes, len);
    return true;
  }
  
  if (addr >= debug_progbuf_start && ((addr + len) <= (debug_progbuf_start + sizeof(program_buffer)))) {
    fprintf(stderr, "Successful write to program buffer %d bytes at %x\n", (int) len, (int) addr);
    memcpy(program_buffer + addr - debug_progbuf_start, bytes, len);
    
    return true;
  }

  if (addr == DEBUG_ROM_HALTED) {
    assert (len == 4);
    halted[id] = true;
    if (dmcontrol.hartsel == id) {
        if (0 == (debug_rom_flags[id] & (1 << DEBUG_ROM_FLAG_GO))){
          if (dmcontrol.hartsel == id) {
              abstractcs.busy = false;
          }
        }
    }
    return true;
  }

  if (addr == DEBUG_ROM_GOING) {
    debug_rom_flags[dmcontrol.hartsel] &= ~(1 << DEBUG_ROM_FLAG_GO);
    return true;
  }

  if (addr == DEBUG_ROM_RESUMING) {
    assert (len == 4);
    halted[id] = false;
    resumeack[id] = true;
    debug_rom_flags[id] &= ~(1 << DEBUG_ROM_FLAG_RESUME);
    return true;
  }

  if (addr == DEBUG_ROM_EXCEPTION) {
    if (abstractcs.cmderr == CMDERR_NONE) {
      abstractcs.cmderr = CMDERR_EXCEPTION;
    }
    return true;
  }

  fprintf(stderr, "ERROR: invalid store to debug module: %zd bytes at 0x%016"
          PRIx64 "\n", len, addr);
  return false;
}

void write32(uint8_t *memory, unsigned int index, uint32_t value)
{
  uint8_t* base = memory + index * 4;
  base[0] = value & 0xff;
  base[1] = (value >> 8) & 0xff;
  base[2] = (value >> 16) & 0xff;
  base[3] = (value >> 24) & 0xff;
}

uint32_t read32(uint8_t *memory, unsigned int index)
{
  uint8_t* base = memory + index * 4;
  uint32_t value = ((uint32_t) base[0]) |
    (((uint32_t) base[1]) << 8) |
    (((uint32_t) base[2]) << 16) |
    (((uint32_t) base[3]) << 24);
  return value;
}

int current_proc() const
{
  // FIND THE FUNCTION AND REPLACE WITH 0
  return 0;//proc;
}

bool dmi_read(unsigned address, uint32_t *value)
{
  uint32_t result = 0;
  D(fprintf(stderr, "dmi_read(0x%x) -> ", address));
  if (address >= DMI_DATA0 && address < DMI_DATA0 + abstractcs.datacount) {
    unsigned i = address - DMI_DATA0;
    result = read32(dmdata, i);
    if (abstractcs.busy) {
      result = -1;
      fprintf(stderr, "\ndmi_read(0x%02x (data[%d]) -> -1 because abstractcs.busy==true\n", address, i);
    }

    if (abstractcs.busy && abstractcs.cmderr == CMDERR_NONE) {
      abstractcs.cmderr = CMDERR_BUSY;
    }

    if (!abstractcs.busy && ((abstractauto.autoexecdata >> i) & 1)) {
      perform_abstract_command();
    }
  } else if (address >= DMI_PROGBUF0 && address < DMI_PROGBUF0 + progsize) {
    unsigned i = address - DMI_PROGBUF0;
    result = read32(program_buffer, i);
    if (abstractcs.busy) {
      result = -1;
      fprintf(stderr, "\ndmi_read(0x%02x (progbuf[%d]) -> -1 because abstractcs.busy==true\n", address, i);
    }
    if (!abstractcs.busy && ((abstractauto.autoexecprogbuf >> i) & 1)) {
      perform_abstract_command();
    }

  } else {
    switch (address) {
      case DMI_DMCONTROL:
        {
          processor_t *proc = current_proc();
          if (proc)
            dmcontrol.haltreq = proc->halt_request;

          result = set_field(result, DMI_DMCONTROL_HALTREQ, dmcontrol.haltreq);
          result = set_field(result, DMI_DMCONTROL_RESUMEREQ, dmcontrol.resumereq);
          result = set_field(result, DMI_DMCONTROL_HARTSEL, dmcontrol.hartsel);
          result = set_field(result, DMI_DMCONTROL_HARTRESET, dmcontrol.hartreset);
    result = set_field(result, DMI_DMCONTROL_NDMRESET, dmcontrol.ndmreset);
          result = set_field(result, DMI_DMCONTROL_DMACTIVE, dmcontrol.dmactive);
        }
        break;
      case DMI_DMSTATUS:
        {
          processor_t *proc = current_proc();

    dmstatus.allnonexistant = false;
    dmstatus.allunavail = false;
    dmstatus.allrunning = false;
    dmstatus.allhalted = false;
          dmstatus.allresumeack = false;
          if (proc) {
            if (halted[dmcontrol.hartsel]) {
              dmstatus.allhalted = true;
            } else {
              dmstatus.allrunning = true;
            }
          } else {
      dmstatus.allnonexistant = true;
          }
    dmstatus.anynonexistant = dmstatus.allnonexistant;
    dmstatus.anyunavail = dmstatus.allunavail;
    dmstatus.anyrunning = dmstatus.allrunning;
    dmstatus.anyhalted = dmstatus.allhalted;
          if (proc) {
            if (resumeack[dmcontrol.hartsel]) {
              dmstatus.allresumeack = true;
            } else {
              dmstatus.allresumeack = false;
            }
          } else {
            dmstatus.allresumeack = false;
          }
          
    result = set_field(result, DMI_DMSTATUS_ALLNONEXISTENT, dmstatus.allnonexistant);
    result = set_field(result, DMI_DMSTATUS_ALLUNAVAIL, dmstatus.allunavail);
    result = set_field(result, DMI_DMSTATUS_ALLRUNNING, dmstatus.allrunning);
    result = set_field(result, DMI_DMSTATUS_ALLHALTED, dmstatus.allhalted);
          result = set_field(result, DMI_DMSTATUS_ALLRESUMEACK, dmstatus.allresumeack);
    result = set_field(result, DMI_DMSTATUS_ANYNONEXISTENT, dmstatus.anynonexistant);
    result = set_field(result, DMI_DMSTATUS_ANYUNAVAIL, dmstatus.anyunavail);
    result = set_field(result, DMI_DMSTATUS_ANYRUNNING, dmstatus.anyrunning);
    result = set_field(result, DMI_DMSTATUS_ANYHALTED, dmstatus.anyhalted);
          result = set_field(result, DMI_DMSTATUS_ANYRESUMEACK, dmstatus.anyresumeack);
          result = set_field(result, DMI_DMSTATUS_AUTHENTICATED, dmstatus.authenticated);
          result = set_field(result, DMI_DMSTATUS_AUTHBUSY, dmstatus.authbusy);
          result = set_field(result, DMI_DMSTATUS_VERSIONHI, dmstatus.versionhi);
          result = set_field(result, DMI_DMSTATUS_VERSIONLO, dmstatus.versionlo);
        }
        break;
      case DMI_ABSTRACTCS:
        result = set_field(result, DMI_ABSTRACTCS_CMDERR, abstractcs.cmderr);
        result = set_field(result, DMI_ABSTRACTCS_BUSY, abstractcs.busy);
        result = set_field(result, DMI_ABSTRACTCS_DATACOUNT, abstractcs.datacount);
        result = set_field(result, DMI_ABSTRACTCS_PROGSIZE, abstractcs.progsize);
        break;
      case DMI_ABSTRACTAUTO:
        result = set_field(result, DMI_ABSTRACTAUTO_AUTOEXECPROGBUF, abstractauto.autoexecprogbuf);
        result = set_field(result, DMI_ABSTRACTAUTO_AUTOEXECDATA, abstractauto.autoexecdata);
        break;
      case DMI_COMMAND:
        result = 0;
        break;
      case DMI_HARTINFO:
        result = set_field(result, DMI_HARTINFO_NSCRATCH, 1);
        result = set_field(result, DMI_HARTINFO_DATAACCESS, 1);
        result = set_field(result, DMI_HARTINFO_DATASIZE, abstractcs.datacount);
        result = set_field(result, DMI_HARTINFO_DATAADDR, debug_data_start);
        break;
      default:
        result = 0;
        D(fprintf(stderr, "Unexpected. Returning Error."));
        return false;
    }
  }
  D(fprintf(stderr, "0x%x\n", result));
  *value = result;
  return true;
}

bool perform_abstract_command()
{
  if (abstractcs.cmderr != CMDERR_NONE)
    return true;
  if (abstractcs.busy) {
    abstractcs.cmderr = CMDERR_BUSY;
    return true;
  }

  if ((command >> 24) == 0) {
    // register access
    unsigned size = get_field(command, AC_ACCESS_REGISTER_SIZE);
    bool write = get_field(command, AC_ACCESS_REGISTER_WRITE);
    unsigned regno = get_field(command, AC_ACCESS_REGISTER_REGNO);

    if (!halted[dmcontrol.hartsel]) {
      abstractcs.cmderr = CMDERR_HALTRESUME;
      return true;
    }

    if (get_field(command, AC_ACCESS_REGISTER_TRANSFER)) {

      if (regno < 0x1000 || regno >= 0x1020) {
        abstractcs.cmderr = CMDERR_NOTSUP;
        return true;
      }

      unsigned regnum = regno - 0x1000;

      switch (size) {
      case 2:
        if (write)
          write32(debug_abstract, 0, lw(regnum, ZERO, debug_data_start));
        else
          write32(debug_abstract, 0, sw(regnum, ZERO, debug_data_start));
        break;
      case 3:
        if (write)
          write32(debug_abstract, 0, ld(regnum, ZERO, debug_data_start));
        else
          write32(debug_abstract, 0, sd(regnum, ZERO, debug_data_start));
        break;
        /*
          case 4:
          if (write)
          write32(debug_rom_code, 0, lq(regnum, ZERO, debug_data_start));
          else
          write32(debug_rom_code, 0, sq(regnum, ZERO, debug_data_start));
          break;
        */
      default:
        abstractcs.cmderr = CMDERR_NOTSUP;
        return true;
      }
    } else {
      //NOP
      write32(debug_abstract, 0, addi(ZERO, ZERO, 0));
    }
    
    if (get_field(command, AC_ACCESS_REGISTER_POSTEXEC)) {
      // Since the next instruction is what we will use, just use nother NOP
      // to get there.
      write32(debug_abstract, 1, addi(ZERO, ZERO, 0));
    } else {
      write32(debug_abstract, 1, ebreak());
    }

    debug_rom_flags[dmcontrol.hartsel] |= 1 << DEBUG_ROM_FLAG_GO;
    
    abstractcs.busy = true;
  } else {
    abstractcs.cmderr = CMDERR_NOTSUP;
  }
  return true;
}

bool dmi_write(unsigned address, uint32_t value)
{
  D(fprintf(stderr, "dmi_write(0x%x, 0x%x)\n", address, value));
  if (address >= DMI_DATA0 && address < DMI_DATA0 + abstractcs.datacount) {
    unsigned i = address - DMI_DATA0;
    if (!abstractcs.busy)
      write32(dmdata, address - DMI_DATA0, value);

    if (abstractcs.busy && abstractcs.cmderr == CMDERR_NONE) {
      abstractcs.cmderr = CMDERR_BUSY;
    }

    if (!abstractcs.busy && ((abstractauto.autoexecdata >> i) & 1)) {
      perform_abstract_command();
    }
    return true;

  } else if (address >= DMI_PROGBUF0 && address < DMI_PROGBUF0 + progsize) {
    unsigned i = address - DMI_PROGBUF0;
    
    if (!abstractcs.busy)
      write32(program_buffer, i, value);

    if (!abstractcs.busy && ((abstractauto.autoexecprogbuf >> i) & 1)) {
      perform_abstract_command();
    }
    return true;
    
  } else {
    switch (address) {
      case DMI_DMCONTROL:
        {
          dmcontrol.dmactive = get_field(value, DMI_DMCONTROL_DMACTIVE);
          if (dmcontrol.dmactive) {
            dmcontrol.haltreq = get_field(value, DMI_DMCONTROL_HALTREQ);
            dmcontrol.resumereq = get_field(value, DMI_DMCONTROL_RESUMEREQ);
            dmcontrol.ndmreset = get_field(value, DMI_DMCONTROL_NDMRESET);
            dmcontrol.hartsel = get_field(value, DMI_DMCONTROL_HARTSEL);
          } else {
            reset();
          }
          processor_t *proc = current_proc();
          if (proc) {
            proc->halt_request = dmcontrol.haltreq;
            if (dmcontrol.resumereq) {
              debug_rom_flags[dmcontrol.hartsel] |= (1 << DEBUG_ROM_FLAG_RESUME);
              resumeack[dmcontrol.hartsel] = false;
            }
      if (dmcontrol.ndmreset) {
        proc->reset();
      }
          }
        }
        return true;

      case DMI_COMMAND:
        command = value;
        return perform_abstract_command();

      case DMI_ABSTRACTCS:
        abstractcs.cmderr = (cmderr_t) (((uint32_t) (abstractcs.cmderr)) & (~(uint32_t)(get_field(value, DMI_ABSTRACTCS_CMDERR))));
        return true;

      case DMI_ABSTRACTAUTO:
        abstractauto.autoexecprogbuf = get_field(value, DMI_ABSTRACTAUTO_AUTOEXECPROGBUF);
        abstractauto.autoexecdata = get_field(value, DMI_ABSTRACTAUTO_AUTOEXECDATA);
        break;
    }
  }
  return false;
}
