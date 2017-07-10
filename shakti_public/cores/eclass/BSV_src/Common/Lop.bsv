// ================================================================
// Copyright (c) 2013-2014 Bluespec, Inc. All Rights Reserved.
// ================================================================

package Lop;

// ================================================================

// import BDPI declarations for C functions used in BSV modeling of memory

// ================================================================
		 
import Vector       :: *;

import "BDPI" function Action initInterface();
import "BDPI" function Action getCommand(); //  this return a 64 bit command vector
import "BDPI" function Action sendResponse() ; // This sends a 64 bit response to a dmi read request

// ================================================================

endpackage: Lop 
