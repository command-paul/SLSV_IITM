////---------------------------------------------------------------
//	S :: Shakti
//	L :: Log
//	S :: Step
//	V :: Verification
// 	Wrapper For Bluespec
//	2017 IIT Madras - IITM Licence
// 	Author :: Paul George [command.paul@gmail.com] & Niladri Dutta
////---------------------------------------------------------------

package SLSV_BSV_Wrapper ;

// Variable of Interest functions
// import "BDPI" function Bool initalise_SLSV ();
// Parse Sensitivity List function

// Checkpoint Function

// Restore Function
`define SLSV_MEM0 3'b000;
`define SLSV_CSR0 3'b001;
`define SLSV_FPR0 3'b010;
`define SLSV_GPR0 3'b011;
`define SLSV_PC0  3'b100; 
// definition scalable across cores ?


// SLSV Debug CLI
import "BDPI" function Bool init_CLI_stdio ();

import "BDPI" function Bool update()
// SLSV Init.
import "BDPI" function ActionValue #(Bit #(64)) initalise_SLSV ();
// SLSV Main
import "BDPI" function Bool init_SLSV_IF ();

endpackage: SLSV_BSV_Wrapper

// Old Code __ Base Template For Replacement


// // ================================================================

// // import BDPI declarations for C functions used in BSV modeling of memory

// // ================================================================
		 
// import Vector       :: *;

// // ================================================================

// import "BDPI" function ActionValue #(Bit #(64)) c_malloc_and_init (Bit #(64) n_bytes,
// 								   Bit #(64) init_from_file);

// import "BDPI" function ActionValue #(Bit #(32)) c_read  (Bit #(64) addr, Bit #(64) n_bytes);	

// 

// // Temporary: imported as a pure function because of bsc bug in importing as ActionValue
// import "BDPI" function Bit #(32) c_read_fn  (Bit #(64) addr, Bit #(64) n_bytes);	

// import "BDPI" function Action c_write (Bit #(64) addr, Bit #(32) x, Bit #(64) n_bytes);

// import "BDPI" function ActionValue #(Vector #(10, Bit #(32))) c_get_console_command ();

// // ================================================================