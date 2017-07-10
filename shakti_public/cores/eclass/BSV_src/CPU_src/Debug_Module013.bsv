import Vector       :: *;
import FIFOF        :: *;
import GetPut       :: *;
import ClientServer :: *;
import Connectable  :: *;
import StmtFSM      :: *;

import TLM2					:: *;	// Using local copy.
import AHB					:: *;	// Using local copy. 
import Utils				:: *;
import Req_Rsp				:: *;
import Sys_Configs		:: *;
import C_import_decls	:: *;
import Lop 				:: *;

import ISA_Defs			:: *;
import CPU					:: *;
import Memory_Model		:: *;
import TypeDefs			:: *;
import Interfaces 		:: *;
import Fabric				:: *;
import RTC_AHB					:: *;
//import Host					:: *;
import myRS232				:: *;
import Proc					:: *;

`include "TLM.defines"
`include "RVC.defines"
`include "macro.defines"

// `define AbstractData0 0x04
// `define AbstractData1 0x05
// `define AbstractData1 0x06
// `define AbstractData1 0x07
// `define AbstractData1 0x08
// `define AbstractData1 0x09
// `define AbstractData1 0x0A
// `define AbstractData1 0x0B
// `define AbstractData1 0x0C
// `define AbstractData1 0x0D
// `define AbstractData1 0x0E
// `define AbstractData1 0x0F
// `define DebugModuleControl 0x10
// `define DebugModuleStatus 0x11
// `define HartInfo 0x12
// `define HaltSummary 0x13
// 0x14Hart Array Window Select200x15Hart Array Window200x16Abstract Control and Status210x17Abstract Command220x18Abstract Command Autoexec220x19Con guration String Addr 0230x1aCon g String Addr 10x1bCon g String Addr 20x1cCon g String Addr 30x20Program Bu er 0230x2fProgram Bu er 150x30Authentication Data240x34Serial Control and Status240x35Serial TX Data250x36Serial RX Data250x38System Bus Access Control and Status250x39System Bus Address 31:0270x3aSystem Bus Address 63:32270x3bSystem Bus Address 95:64270x3cSystem Bus Data 31:0280x3dSystem Bus Data 63:32280x3eSystem Bus Data 95:64290x3fSystem Bus Data 127:9629







mkAutoFSM (
	seq
		while (!halt) seq
			action
				get_message;
			endaction

		endseq
	endseq
);