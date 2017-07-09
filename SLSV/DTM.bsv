package DTM;
	/*====== Package imports === */
	import FIFO::*;
	import FIFOF::*;
	import SpecialFIFOs::*;
	import GetPut::*;
	import ClientServer::*;
	import Vector::*;
	import Connectable::*;
	import StmtFSM      :: *;
	/*========================== */
	/*=== Project imports === */
	import Control_Fabric_Defs::*;
	import ConcatReg::*;
	import AXI4_Types::*;
	import AXI4_Fabric::*;
	import defined_types::*;
	import DebugModule::*;
	import Memory_AXI4	::*;
	// `ifndef simulate
	// 	import qspi				 :: *;
	// 	import Uart16550		 :: *;
	// 	import DMA				 :: *;
	// 	import I2C_top			 :: *;
	// 	import sdr_top			 :: *;
	// 	import hyperflash_bsv_wrapper ::*;
	// `endif
	import MemoryMap		 :: *;
	`include "defines.bsv"
	`include "defined_parameters.bsv"
	/*========================= */

	module mkDTM(Empty);

// DMI :: Begins
	/*=========== DEBUG REGISTERS =========== */

	/*======= HART INFO REGISTERS =========== */
		Reg#(Bit#(32)) hart_Info <-mkReg (0) ;
		/*======================================== */
		// Hart registers end here 
		//Registers from debug spec .13 start here 
    /*========= DM Control Registers ======== */
		Reg#(Bit#(1)) rg_haltreq<-mkReg(0);
		Reg#(Bit#(1)) rg_resumereq<-mkReg(0);
		Reg#(Bit#(1)) rg_hartreset<-mkReg(0);
		Reg#(Bit#(1)) rg_reset<-mkReg(0);
		Reg#(Bit#(1)) rg_dmactive<-mkReg(1);
		Reg#(Bit#(32)) dm_control =concatReg8(rg_haltreq,rg_resumereq,
        rg_hartreset,readOnlyReg(2'b0),readOnlyReg(1'b0),
        readOnlyReg(24'b0),rg_reset,rg_dmactive);
		/*======================================== */

		/*====== DM STATUS REGISTERS ========== */
    	Reg#(Bit#(1)) rg_resume<-mkReg(0);
    	Reg#(Bit#(1)) rg_unavailable<-mkReg(0);
    	Reg#(Bit#(1)) rg_running <-mkReg(0);
    	Reg#(Bit#(1)) rg_halted<-mkReg(0);
		Reg#(Bit#(32)) dm_status =concatReg11(readOnlyReg(14'd0),
        readOnlyReg(rg_resume),readOnlyReg(rg_resume),
        readOnlyReg(2'b0), readOnlyReg(rg_unavailable),readOnlyReg(rg_unavailable),
        readOnlyReg(rg_running), readOnlyReg(rg_running),
        readOnlyReg(rg_halted), readOnlyReg(rg_halted),
        readOnlyReg(8'b10000001)); // TODO Make the 4th bit if using Configstring
		/*======================================== */
		
		/*== ABSTRACT REGISTERS === */
    	Reg#(Bit#(1)) rg_busy<-mkReg(0);
    	Reg#(Bit#(3)) rg_cmderr<-mkReg(0);
    	Reg#(Bit#(32)) abstract_Control_And_Status=concatReg8(readOnlyReg(3'b0),
        readOnlyReg(5'd16),readOnlyReg(11'b0),
        readOnlyReg(rg_busy),readOnlyReg(1'b0),rg_cmderr,
        readOnlyReg(3'b0),readOnlyReg(5'd12));

		Reg#(Bit#(8)) rg_cmdtype <-mkReg(0);
    	Reg#(Bit#(24)) rg_control<-mkReg(0);
		Reg#(Bit#(32)) abstract_Commands =concatReg2(rg_cmdtype,rg_control); // TODO has a write-side effect.

		Reg#(Bit#(16)) rg_autoexecprogbuf<-mkReg(0);
    	Reg#(Bit#(12)) rg_autoexecdata<-mkReg(0);
		Reg#(Bit#(32)) abstract_Command_Autoexe =concatReg3(rg_autoexecprogbuf,readOnlyReg(4'b0),rg_autoexecdata) ;
		Vector#(12,Reg#(Bit #(32))) abstract_Data <- replicateM(mkReg(0));
		/*======================================== */


		//Reg#(Bit#(32)) configuration_String_Addr_0<-mkReg (0) ; // TODO need to fiure this out
		//Reg#(Bit#(32)) configuration_String_Addr_1<-mkReg (0) ;
		//Reg#(Bit#(32)) configuration_String_Addr_2<-mkReg (0) ;
		//Reg#(Bit#(32)) configuration_String_Addr_3<-mkReg (0) ;
		//Reg#(Bit#(32)) serial_Control_And_Status <-mkReg (0) ;
		//Reg#(Bit#(64)) serial_Data <-mkReg(0) ;
    /*======= System Bus Access Registers ======= */
		Reg#(Bit#(3)) rg_sberror<-mkReg(0);
		Reg#(Bit#(1)) rg_sbautoread<-mkReg(0);
		Reg#(Bit#(1)) rg_sbautoincrement<-mkReg(0);
		Reg#(Bit#(3)) rg_sbaccess<-mkReg(0);
		Reg#(Bit#(1)) rg_sbsingleread<-mkReg(0);
		Reg#(Bit#(32)) bus_ctrlstatus=concatReg8(readOnlyReg(11'b0),
				rg_sbsingleread,rg_sbaccess,
				rg_sbautoincrement,rg_sbautoread,
				rg_sberror,readOnlyReg(7'h40),
				readOnlyReg(5'b01111));

		Reg#(Bit#(32)) busAddr0 <- mkReg(0) ;
		Reg#(Bit#(32)) busAddr1 <- mkReg(0) ;
		Reg#(Bit#(32)) busData0 <- mkReg(0) ;
		Reg#(Bit#(32)) busData1 <- mkReg(0) ;
		/*======================================== */


		/*======================================== */

		Ifc_DebugModule core<-mkDebugModule;
		`ifdef simulate
			`ifdef RV64
				Memory_IFC#(`ConfigMBase,12) config_memory <-mkMemory("config_string64.hex.MSB","config_string64.hex.LSB","CONFIGMEM");
				Memory_IFC#(`MemCBase,`Addr_space) main_memory <- mkMemory("code.mem.MSB","code.mem.LSB","MainMEM");
			`else
			 	Memory_IFC#(`ConfigMBase,12) config_memory <-mkMemory("config_string.hex","CONFIGMEM");
				Memory_IFC#(`MemCBase,`Addr_space) main_memory <- mkMemory("code.mem","MainMEM");
			 `endif
		// `else
		// 	Uart16550_AXI4_Ifc	uart0				<- mkUart16550();
		// 	Uart16550_AXI4_Ifc	uart1				<- mkUart16550();
		// 	Ifc_wrap_qspi			qspi0				<-	mkwrap_qspi();
		// 	Ifc_wrap_qspi			qspi1				<-	mkwrap_qspi();
		// 	I2C_IFC					i2c0				<- mkI2CController();
		// 	I2C_IFC					i2c1				<- mkI2CController();
		// 	DmaC#(7,12)				dma				<- mkDMA();
		// 	Ifc_sdr_slave			sdram				<- mksdr_axi4_slave();
		// 	Ifc_hyperflash			hyperflash		<- mkhyperflash();
		`endif

   	// Fabric
   	AXI4_Fabric_IFC #(Num_Masters, Num_Slaves, `Addr_width, `Reg_width,`USERSPACE)
		 		fabric <- mkAXI4_Fabric(fn_addr_to_slave_num);

   	// Connect traffic generators to fabric
   	mkConnection (core.dmem_master, fabric.v_from_masters [0]);
   	mkConnection (core.imem_master, fabric.v_from_masters [1]);
   	mkConnection (core.debug_master, fabric.v_from_masters [2]);
		`ifdef MMU   mkConnection (core.ptw_master, fabric.v_from_masters [3]); `endif

		// Connect fabric to memory slaves
		`ifdef simulate
			mkConnection(fabric.v_to_slaves[`Memc_slave_num],main_memory.axi_slave);
			mkConnection(fabric.v_to_slaves[`Configm_slave_num],config_memory.axi_slave);
		// `else
		// 	mkConnection (fabric.v_to_slaves [Uart0_slave_num],	uart0.slave_axi_uart);  
  //  		mkConnection (fabric.v_to_slaves [Uart1_slave_num],	uart1.slave_axi_uart); 
  //  		mkConnection (fabric.v_to_slaves [Qspi0_slave_num],	qspi0.slave); 
  //  		mkConnection (fabric.v_to_slaves [Qspi1_slave_num],	qspi1.slave); 
  //  		mkConnection (fabric.v_to_slaves [I2c0_slave_num],		i2c0.slave_i2c_axi); 
  //  		mkConnection (fabric.v_to_slaves [I2c1_slave_num],		i2c1.slave_i2c_axi); // 
  //  		mkConnection (fabric.v_to_slaves [Sdram_slave_num],	sdram.axi4_slave_sdram); // 
  //  		mkConnection (fabric.v_to_slaves [Sdram_cfg_slave_num],	sdram.axi4_slave_cntrl_reg); // 
  //  		mkConnection (fabric.v_to_slaves [Hyperflash_mem_slave_num],	hyperflash.axi4_slave_m); // 
  //  		mkConnection (fabric.v_to_slaves [Hyperflash_reg_slave_num],	hyperflash.axi4_slave_r); // 
  //  		mkConnection (fabric.v_to_slaves [Dma_slave_num],	dma.cfg); //
		`endif
		
		
		// Reg#(Bit#(32)) rg_counter<-mkReg(0);
		// Reg#(Bit#(64)) rg <- mkReg(0) ;


		// rule increment_counter;
		// 	rg_counter<=rg_counter+1;
		// endrule

		// rule end_sim(rg_counter==250);
		// 	$display("TB: Finished");
		// 	$finish(0);
		// endrule

		// rule create_stop(rg_counter==200);
		// 	$display($time,"\tTB: Sending halt request to Debug_module");
		// 	let x=DTMRequest{address:`DMCONTROL,
		// 								data:'h80000001,
		// 								write:True};
		// 	let rep<-core.toDTM(x);
		// endrule

		// rule create_clear_halt(rg_counter==205);
		// 	$display($time,"\tTB: Clearing Halt Request");
		// 	let x=DTMRequest{address:`DMCONTROL,
		// 								data:'h00000001,
		// 								write:True};
		// 	let rep<-core.toDTM(x);
		// endrule


		Reg#(Bit#(12)) 	address<-mkReg(0);
		Reg#(Bit#(32)) 	data <- mkReg(0) ;
		Bool 			write;

		Stmt just 
		= seq
			action
			rg_haltreq <= 'h1;

			endaction
		endseq;

		// function Action halt_request();
		Stmt halt_request 
		= seq
			action
			rg_haltreq <= 'h1;
			$display($time,"\tTB: STMT:: Sending halt request to Debug_module");
			$display("\nTEST 1:: %h \n",dm_control);
			let x=DTMRequest{address:`DMCONTROL,
										data:dm_control,
										write:True};
			let rep<-core.toDTM(x);
			endaction
		endseq;
	// endfunction : halt_request

		mkAutoFSM (
	    seq
	    // just;
		
		 // Initialize CPU
		 halt_request;
			$display("\nTEST 2:: %h \n",dm_control);
		 // reset_dmi;
		 halt_request;
	      endseq
	      );

		//    // Statement to INITIALISE Debug Module
	 //   Stmt initialize_cpu
	 //   = seq
		// 	action // Reset CPU
		// 		$display ($time, " TB: Initializing Debug Module");
		// 		proc.debug_ifc.reset;	// True sets mode to debug
		// 	endaction
			
		// 	action // Set initial PC
		// 		Addr start_pc = `PC_INIT_VALUE;
		// 		let reset_done <- proc.debug_ifc.reset_complete;
		// 		if(reset_done == True) proc.debug_ifc.write_pc (start_pc);
		// 		$display ($time, " TB: Setting initial PC to: %0h", start_pc);
		// 	endaction
		// endseq;



		// `ifdef simulate
		// 	method  Action sin(Bit#(1) in) = core.sin(in);
		// 	method  Bit#(1)     sout()=core.sout;
		// `endif

		// `ifndef simulate
		// 	interface get_to_console   = uart2.get_to_console;
  //  		interface put_from_console = uart2.put_from_console;
		// 	interface uart0_coe=uart0.coe_rs232;
		// 	interface uart1_coe=uart1.coe_rs232;

		// 	interface i2c0_out=i2c0.out;
		// 	interface i2c1_out=i2c1.out;
			
		// 	interface qspi0_sio0=qspi0.sio0;
		// 	interface qspi0_sio1=qspi0.sio1;
		// 	interface qspi0_sio2=qspi0.sio2;
		// 	interface qspi0_sio3=qspi0.sio3;
		// 	method Bit#(1) qspi0_ncs=qspi0.ncs;
		// 	method Bit#(1) qspi0_clk=qspi0.clk;
			
		// 	interface qspi1_sio0=qspi1.sio0;
		// 	interface qspi1_sio1=qspi1.sio1;
		// 	interface qspi1_sio2=qspi1.sio2;
		// 	interface qspi1_sio3=qspi1.sio3;
		// 	method Bit#(1) qspi1_ncs = qspi1.ncs;
		// 	method Bit#(1) qspi1_clk = qspi1.clk;
		// 	interface sdram_out=sdram.ifc_sdram_out;
		// 	interface sdr_dq0=sdram.sdr_dq0;	
		// 	interface sdr_dq1=sdram.sdr_dq1;	
  //  		interface ifc_pinout_flash=hyperflash.ifc_pinout_flash;
		// `endif

// DMI :: Ends

		// Ifc_Soc soc <-mkSoc;
		// Reg#(Bit#(32)) rg_counter<-mkReg(0);
		// Reg#(Bit#(64)) rg <- mkReg(0) ;
		// rule create_stop(rg_counter==200);
		// 	$display($time,"\tTB: Sending halt request to Debug_module");
		// 	let x=DTMRequest{address:`DMCONTROL,
		// 								data:'h80000001,
		// 								write:True};
		// 	let rep<-soc.toDTM(x);
		// endrule

		// rule create_clear_halt(rg_counter==205);
		// 	$display($time,"\tTB: Clearing Halt Request");
		// 	let x=DTMRequest{address:`DMCONTROL,
		// 								data:'h00000001,
		// 								write:True};
		// 	let rep<-soc.toDTM(x);
		// endrule

		
		// rule write_memory_request_2(rg_counter == 300);
		// 	let x = DTMRequest{address:`BUSCONTROL,data:'h0005040F,write:True} ;
		// 	let rep <- soc.toDTM(x) ;
		// 	$display($time,"TB: Set bus control register : %d",x.data);
		// endrule

		// rule write_memory_request(rg_counter == 310 );
		// 	let x = DTMRequest{address:`BUSADDRESS0,data:'h80000000,write:True} ;
		// 	let rep <- soc.toDTM(x) ;
		// 	$display($time,"TB: Set write address : %d",x.data);
		// endrule

		// rule write_memory_request_3(rg_counter >= 320 && rg_counter <= 370 && (rg_counter - 320) % 20 == 0);
		// 	let x = DTMRequest{address:`BUSDATA0,data:rg_counter-320,write:True} ;
		// 	let rep <- soc.toDTM(x) ;
		// 	$display($time,"TB: Set write data : %d",x.data);
		// endrule

		

		// rule read_memory_request_1(rg_counter == 400);
		// 	let x = DTMRequest{address:`BUSADDRESS0,data:'h80000000,write:True} ;
		// 	let rep <- soc.toDTM(x) ;
		// 	$display($time,"TB: Set read address : %d",x.data);
		// endrule

		// rule read_memory_request_2(rg_counter == 410);
		// 	let x = DTMRequest{address:`BUSCONTROL,data:'h0015840F,write:True} ;
		// 	let rep <- soc.toDTM(x) ;
		// 	$display($time,"TB: Set bus control register : %d",x.data);
		// endrule

		// rule read_memory_request_3(rg_counter >= 450 && rg_counter <= 460 && rg_counter % 10 == 0);
		// 	let x = DTMRequest{address:`BUSDATA0,data:?,write:False} ;
		// 	let rep <- soc.toDTM(x) ;
		// 	$display($time,"TB: Read Data : %d",rep.resp_word);
		// endrule

		// rule read_memory_request_4(rg_counter == 520);
		// 	let x = DTMRequest{address:`BUSCONTROL,data:'h0014040F,write:True} ;
		// 	let rep <- soc.toDTM(x) ;
		// 	$display($time,"TB: Set bus control register : %d",x.data);
		// endrule

		// rule read_memory_request_5(rg_counter == 530);
		// 	let x = DTMRequest{address:`BUSDATA0,data:?,write:False} ;
		// 	let rep <- soc.toDTM(x) ;
		// 	$display($time,"TB: Read Data : %d",rep.resp_word);
		// endrule

		// // rule assert_reset(rg_counter == 250);
		// // 	$display($time,"TB: Sending Reset request");
		// // 	let x = DTMRequest{address:`DMCONTROL,data:'h20000001,write:True};
		// // 	let rep <- soc.toDTM(x) ;
		// // endrule
		// // rule deassert_reset(rg_counter == 300);
		// // 	$display($time,"TB: Sending De-assert Reset request");
		// // 	let x = DTMRequest{address:`DMCONTROL,data:'h00000001,write:True};
		// // 	let rep <- soc.toDTM(x) ;
		// // endrule

		// // rule create_resume(rg_counter==260);
		// // 	$display($time,"\tTB: Sending resume request to Debug_module");
		// // 	let x=DTMRequest{address:`DMCONTROL,
		// // 								data:'h40000001,
		// // 								write:True};
		// // 	let rep<-soc.toDTM(x);
		// // endrule

		// // rule create_clear_resume(rg_counter==270);
		// // 	$display($time,"\tTB: Clearing Resume Request");
		// // 	let x=DTMRequest{address:`DMCONTROL,
		// // 								data:'h00000001,
		// // 								write:True};
		// // 	let rep <- soc.toDTM(x);
		// // endrule
		

		// // rule read_register_request(rg_counter == 1210 || rg_counter == 1235) ;
		// // 	let x = DTMRequest{address:`ABSTRACTCMD,data:'h00321025,write:True} ;
		// // 	$display($time," TB:Sending Read request for IGPR %d",x.data[4:0]);
		// // 	let rep <- soc.toDTM(x) ;
		// // endrule

		// // rule read_register_1(rg_counter == 1215 || rg_counter == 1240);
		// // 	let x = DTMRequest{address:`ABSTRACTDATASTART,data:?,write:False};			
		// // 	$display($time," TB: READING REGISTER ..BITS[31:0]");
		// // 	let rep <- soc.toDTM(x) ;
		// // 	$display("RESPONSE FROM DEBUG MODULE :",fshow(rep));
		// // 	rg[31:0] <= rep.resp_word ;
		// // endrule

		// // rule read_register_2(rg_counter == 1220 || rg_counter == 1245);
		// // 	let x = DTMRequest{address:`ABSTRACTDATASTART + 1,data:?,write:False};
		// // 	let rep <- soc.toDTM(x) ;
		// // 	$display("RESPONSE FROM DEBUG MODULE :",fshow(rep));	
		// // 	rg[63:32] <= rep.resp_word ;
		// // 	$display($time," TB: READING REGISTER ..BITS[63:32]");
		// // endrule

		// // rule display_register(rg_counter == 1225 || rg_counter == 1250);
		// // 	$display($time," TB: REGISTER VALUE :%d",rg);
		// // endrule

		// // rule write_register_1(rg_counter == 1227 ) ;
		// // 	let x = DTMRequest{address:`ABSTRACTDATASTART,data:'h10,write:True} ;
		// // 	$display("Send write value %d",x.data);
		// // 	let rep <- soc.toDTM(x) ;
		// // endrule

		// // rule write_register_2(rg_counter == 1229 ) ;
		// // 	let x = DTMRequest{address:`ABSTRACTDATASTART+1,data:'h0,write:True} ;
		// // 	$display("Send write value %d",x.data);
		// // 	let rep <- soc.toDTM(x) ;
		// // endrule

		// // rule write_register_request(rg_counter == 1230 ) ;
		// // 	let x = DTMRequest{address:`ABSTRACTCMD,data:'h00331025,write:True} ;
		// // 	$display($time," TB:Sending Write request for IGPR %d",x.data[4:0]);
		// // 	let rep <- soc.toDTM(x) ;
		// // endrule

		// rule increment_counter;
		// 	rg_counter<=rg_counter+1;
		// endrule
		// rule end_sim(rg_counter==700);
		// 	$display("TB: Finished");
		// 	$finish(0);
		// endrule
	endmodule
endpackage
