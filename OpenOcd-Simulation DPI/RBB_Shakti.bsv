// RBB_Shakti.bsv
package RBB_Shakti;

// ================================================================
// import BDPI declarations for C functions used in BSV modeling of memory
// ================================================================

// frame = {NA,NA,NA,reset,request_tdo,tck,tms,tdi}
import "BDPI" function ActionValue #(Bit #(1)) init(); // Callin this will make the simulator wait for openOCD					
import "BDPI" function ActionValue #(Bit #(8))get_frame();
import "BDPI" function Action send_tdo(Bit #(1) tdo);

// =================import "BDPI" function Action===============================================

endpackage: RBB_Shakti
