// See LICENSE for license details.

#include "insn_template.h"

reg_t rv32_fcvt_s_wu(processor_t* p, insn_t insn, reg_t pc)
{
  int xlen = 32;
  reg_t npc = sext_xlen(pc + insn_length( MATCH_FCVT_S_WU));
  #include "insns/fcvt_s_wu.h"
  trace_opcode(p,  MATCH_FCVT_S_WU, insn);
  return npc;
}

reg_t rv64_fcvt_s_wu(processor_t* p, insn_t insn, reg_t pc)
{
  int xlen = 64;
  reg_t npc = sext_xlen(pc + insn_length( MATCH_FCVT_S_WU));
  #include "insns/fcvt_s_wu.h"
  trace_opcode(p,  MATCH_FCVT_S_WU, insn);
  return npc;
}
