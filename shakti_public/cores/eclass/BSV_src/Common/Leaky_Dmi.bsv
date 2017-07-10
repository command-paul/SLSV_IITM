package L_DMI;

// ================================================================
// import BDPI declarations for C functions used in BSV modeling of memory
// ================================================================
		 
import Vector       :: *;

import "BDPI" function Action initInterface();
import "BDPI" function ActionValue #(Bit #(40)) getCommand();
import "BDPI" function Action sendResponse(Bit #(64) data);
// =================import "BDPI" function Action===============================================

endpackage: L_DMI 
