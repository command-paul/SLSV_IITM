package Leaky_Dmi;

// ================================================================
// import BDPI declarations for C functions used in BSV modeling of memory
// ================================================================
		 
import Vector       :: *;

import "BDPI" function Action initInterface();
import "BDPI" function ActionValue #(Bit #(40)) getCommand();
import "BDPI" function Action sendResponse(Bit #(32) data);
// =================import "BDPI" function Action===============================================

endpackage: Leaky_Dmi 
