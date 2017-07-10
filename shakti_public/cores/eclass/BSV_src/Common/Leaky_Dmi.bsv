package L_DMI;

// ================================================================
// import BDPI declarations for C functions used in BSV modeling of memory
// ================================================================
		 
import Vector       :: *;

import "BDPI" function Action char initInterface();
import "BDPI" function Action unsigned long long int getCommand();
void sendResponse();
// ================================================================

endpackage: L_DMI 
