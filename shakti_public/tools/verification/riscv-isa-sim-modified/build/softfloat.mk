softfloat_subproject_deps =

softfloat_hdrs = \
  internals.h \
  primitives.h \
  primitiveTypes.h \
  softfloat.h \
  softfloat_types.h \
  specialize.h \

softfloat_c_srcs = \
  f32_add.c \
  f32_classify.c \
  f32_div.c \
  f32_eq.c \
  f32_eq_signaling.c \
  f32_isSignalingNaN.c \
  f32_le.c \
  f32_le_quiet.c \
  f32_lt.c \
  f32_lt_quiet.c \
  f32_mulAdd.c \
  f32_mul.c \
  f32_rem.c \
  f32_roundToInt.c \
  f32_sqrt.c \
  f32_sub.c \
  f32_to_f64.c \
  f32_to_i32.c \
  f32_to_i32_r_minMag.c \
  f32_to_i64.c \
  f32_to_i64_r_minMag.c \
  f32_to_ui32.c \
  f32_to_ui32_r_minMag.c \
  f32_to_ui64.c \
  f32_to_ui64_r_minMag.c \
  f64_add.c \
  f64_classify.c \
  f64_div.c \
  f64_eq.c \
  f64_eq_signaling.c \
  f64_isSignalingNaN.c \
  f64_le.c \
  f64_le_quiet.c \
  f64_lt.c \
  f64_lt_quiet.c \
  f64_mulAdd.c \
  f64_mul.c \
  f64_rem.c \
  f64_roundToInt.c \
  f64_sqrt.c \
  f64_sub.c \
  f64_to_f32.c \
  f64_to_i32.c \
  f64_to_i32_r_minMag.c \
  f64_to_i64.c \
  f64_to_i64_r_minMag.c \
  f64_to_ui32.c \
  f64_to_ui32_r_minMag.c \
  f64_to_ui64.c \
  f64_to_ui64_r_minMag.c \
  i32_to_f32.c \
  i32_to_f64.c \
  i64_to_f32.c \
  i64_to_f64.c \
  s_add128.c \
  s_addCarryM.c \
  s_addComplCarryM.c \
  s_addMagsF32.c \
  s_addMagsF64.c \
  s_addM.c \
  s_approxRecip32_1.c \
  s_approxRecipSqrt32_1.c \
  s_commonNaNToF32UI.c \
  s_commonNaNToF64UI.c \
  s_compare96M.c \
  s_countLeadingZeros32.c \
  s_countLeadingZeros64.c \
  s_countLeadingZeros8.c \
  s_f32UIToCommonNaN.c \
  s_f64UIToCommonNaN.c \
  s_mul64To128.c \
  s_mulAddF32.c \
  s_mulAddF64.c \
  s_negXM.c \
  s_normRoundPackToF32.c \
  s_normRoundPackToF64.c \
  s_normSubnormalF32Sig.c \
  s_normSubnormalF64Sig.c \
  softfloat_raiseFlags.c \
  softfloat_state.c \
  s_propagateNaNF32UI.c \
  s_propagateNaNF64UI.c \
  s_remStepMBy32.c \
  s_roundPackMToI64.c \
  s_roundPackMToUI64.c \
  s_roundPackToF32.c \
  s_roundPackToF64.c \
  s_roundPackToI32.c \
  s_roundPackToI64.c \
  s_roundPackToUI32.c \
  s_roundPackToUI64.c \
  s_shiftRightJam128.c \
  s_shiftRightJam32.c \
  s_shiftRightJam64.c \
  s_shiftRightJam64Extra.c \
  s_shortShiftLeft64To96M.c \
  s_shortShiftLeftM.c \
  s_shortShiftRightExtendM.c \
  s_shortShiftRightJam64.c \
  s_shortShiftRightJam64Extra.c \
  s_shortShiftRightJamM.c \
  s_shortShiftRightM.c \
  s_sub128.c \
  s_subMagsF32.c \
  s_subMagsF64.c \
  s_subM.c \
  ui32_to_f32.c \
  ui32_to_f64.c \
  ui64_to_f32.c \
  ui64_to_f64.c \

softfloat_test_srcs =

softfloat_install_prog_srcs =
