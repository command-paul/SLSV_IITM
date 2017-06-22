/*
 * Generated by Bluespec Compiler, version 2017.03.beta1 (build 35049, 2017-03-16)
 * 
 * On Tue Jun 20 18:40:33 IST 2017
 * 
 * To automatically register this VPI wrapper with a Verilog simulator use:
 *     #include "vpi_wrapper_c_get_start_pc.h"
 *     void (*vlog_startup_routines[])() = { c_get_start_pc_vpi_register, 0u };
 * 
 * For a Verilog simulator which requires a .tab file, use the following entry:
 * $imported_c_get_start_pc call=c_get_start_pc_calltf size=64 acc=rw:%TASK
 * 
 * For a Verilog simulator which requires a .sft file, use the following entry:
 * $imported_c_get_start_pc vpiSysFuncSized 64 unsigned
 */
#include <stdlib.h>
#include <vpi_user.h>
#include "bdpi.h"

/* the type of the wrapped function */
unsigned long long c_get_start_pc();

/* VPI wrapper function */
PLI_INT32 c_get_start_pc_calltf(PLI_BYTE8 *user_data)
{
  vpiHandle hCall;
  unsigned long long vpi_result;
  vpiHandle *handle_array;
  
  /* retrieve handle array */
  hCall = vpi_handle(vpiSysTfCall, 0);
  handle_array = vpi_get_userdata(hCall);
  if (handle_array == NULL)
  {
    vpiHandle hArgList;
    hArgList = vpi_iterate(vpiArgument, hCall);
    handle_array = malloc(sizeof(vpiHandle) * 1u);
    handle_array[0u] = hCall;
    vpi_put_userdata(hCall, handle_array);
    vpi_free_object(hArgList);
  }
  
  /* create return value */
  make_vpi_result(handle_array[0u], &vpi_result, DIRECT);
  
  /* call the imported C function */
  vpi_result = c_get_start_pc();
  
  /* copy out return value */
  put_vpi_result(handle_array[0u], &vpi_result, DIRECT);
  vpi_free_object(hCall);
  
  return 0;
}

/* sft: $imported_c_get_start_pc vpiSysFuncSized 64 unsigned */

/* tab: $imported_c_get_start_pc call=c_get_start_pc_calltf size=64 acc=rw:%TASK */

PLI_INT32 c_get_start_pc_sizetf(PLI_BYTE8 *user_data)
{
  return 64u;
}

/* VPI wrapper registration function */
void c_get_start_pc_vpi_register()
{
  s_vpi_systf_data tf_data;
  
  /* Fill in registration data */
  tf_data.type = vpiSysFunc;
  tf_data.sysfunctype = vpiSizedFunc;
  tf_data.tfname = "$imported_c_get_start_pc";
  tf_data.calltf = c_get_start_pc_calltf;
  tf_data.compiletf = 0u;
  tf_data.sizetf = c_get_start_pc_sizetf;
  tf_data.user_data = "$imported_c_get_start_pc";
  
  /* Register the function with VPI */
  vpi_register_systf(&tf_data);
}
