//
// Generated by Bluespec Compiler, version 2015.09.beta2 (build 34689, 2015-09-07)
//
// On Mon Dec 19 16:37:11 IST 2016
//
//
// Ports:
// Name                         I/O  size props
// intfc_rcv_tx_get               O    89
// RDY_intfc_rcv_tx_get           O     1
// RDY_intfc_rcv_rx_put           O     1 reg
// RDY_flush_from_proc            O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// intfc_rcv_rx_put               I   173
// flush_from_proc_flush          I     1
// EN_intfc_rcv_rx_put            I     1
// EN_flush_from_proc             I     1
// EN_intfc_rcv_tx_get            I     1
//
// Combinational paths from inputs to outputs:
//   (intfc_rcv_rx_put,
//    flush_from_proc_flush,
//    EN_intfc_rcv_rx_put,
//    EN_flush_from_proc) -> RDY_intfc_rcv_tx_get
//   (intfc_rcv_rx_put,
//    flush_from_proc_flush,
//    EN_intfc_rcv_rx_put,
//    EN_flush_from_proc) -> intfc_rcv_tx_get
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkTLM_Memory(CLK,
		    RST_N,

		    EN_intfc_rcv_tx_get,
		    intfc_rcv_tx_get,
		    RDY_intfc_rcv_tx_get,

		    intfc_rcv_rx_put,
		    EN_intfc_rcv_rx_put,
		    RDY_intfc_rcv_rx_put,

		    flush_from_proc_flush,
		    EN_flush_from_proc,
		    RDY_flush_from_proc);
  input  CLK;
  input  RST_N;

  // actionvalue method intfc_rcv_tx_get
  input  EN_intfc_rcv_tx_get;
  output [88 : 0] intfc_rcv_tx_get;
  output RDY_intfc_rcv_tx_get;

  // action method intfc_rcv_rx_put
  input  [172 : 0] intfc_rcv_rx_put;
  input  EN_intfc_rcv_rx_put;
  output RDY_intfc_rcv_rx_put;

  // action method flush_from_proc
  input  flush_from_proc_flush;
  input  EN_flush_from_proc;
  output RDY_flush_from_proc;

  // signals for module outputs
  wire [88 : 0] intfc_rcv_tx_get;
  wire RDY_flush_from_proc, RDY_intfc_rcv_rx_put, RDY_intfc_rcv_tx_get;

  // inlined wires
  wire [88 : 0] rsp_to_core_enqw$wget;
  wire [63 : 0] dmem_serverAdapterA_outData_outData$wget;
  wire dmem_serverAdapterA_outData_outData$whas,
       dmem_serverAdapterA_writeWithResp$whas,
       dmem_serverAdapterB_writeWithResp$whas;

  // register dmem_serverAdapterA_cnt
  reg [2 : 0] dmem_serverAdapterA_cnt;
  wire [2 : 0] dmem_serverAdapterA_cnt$D_IN;
  wire dmem_serverAdapterA_cnt$EN;

  // register dmem_serverAdapterA_s1
  reg [1 : 0] dmem_serverAdapterA_s1;
  wire [1 : 0] dmem_serverAdapterA_s1$D_IN;
  wire dmem_serverAdapterA_s1$EN;

  // register dmem_serverAdapterB_cnt
  reg [2 : 0] dmem_serverAdapterB_cnt;
  wire [2 : 0] dmem_serverAdapterB_cnt$D_IN;
  wire dmem_serverAdapterB_cnt$EN;

  // register dmem_serverAdapterB_s1
  reg [1 : 0] dmem_serverAdapterB_s1;
  wire [1 : 0] dmem_serverAdapterB_s1$D_IN;
  wire dmem_serverAdapterB_s1$EN;

  // register rg_addr
  reg [63 : 0] rg_addr;
  wire [63 : 0] rg_addr$D_IN;
  wire rg_addr$EN;

  // register rg_clock
  reg [31 : 0] rg_clock;
  wire [31 : 0] rg_clock$D_IN;
  wire rg_clock$EN;

  // register rg_count
  reg [3 : 0] rg_count;
  wire [3 : 0] rg_count$D_IN;
  wire rg_count$EN;

  // register rg_data
  reg [63 : 0] rg_data;
  wire [63 : 0] rg_data$D_IN;
  wire rg_data$EN;

  // register rg_id
  reg [3 : 0] rg_id;
  wire [3 : 0] rg_id$D_IN;
  wire rg_id$EN;

  // register rg_rd_wr_to_memory
  reg rg_rd_wr_to_memory;
  wire rg_rd_wr_to_memory$D_IN, rg_rd_wr_to_memory$EN;

  // register rg_state
  reg rg_state;
  wire rg_state$D_IN, rg_state$EN;

  // register rg_transfer_size
  reg [2 : 0] rg_transfer_size;
  wire [2 : 0] rg_transfer_size$D_IN;
  wire rg_transfer_size$EN;

  // ports of submodule dmem_memory
  wire [63 : 0] dmem_memory$DIA,
		dmem_memory$DIB,
		dmem_memory$DOA,
		dmem_memory$DOB;
  wire [12 : 0] dmem_memory$ADDRA, dmem_memory$ADDRB;
  wire dmem_memory$ENA, dmem_memory$ENB, dmem_memory$WEA, dmem_memory$WEB;

  // ports of submodule dmem_serverAdapterA_outDataCore
  wire [63 : 0] dmem_serverAdapterA_outDataCore$D_IN,
		dmem_serverAdapterA_outDataCore$D_OUT;
  wire dmem_serverAdapterA_outDataCore$CLR,
       dmem_serverAdapterA_outDataCore$DEQ,
       dmem_serverAdapterA_outDataCore$EMPTY_N,
       dmem_serverAdapterA_outDataCore$ENQ,
       dmem_serverAdapterA_outDataCore$FULL_N;

  // ports of submodule dmem_serverAdapterB_outDataCore
  wire [63 : 0] dmem_serverAdapterB_outDataCore$D_IN;
  wire dmem_serverAdapterB_outDataCore$CLR,
       dmem_serverAdapterB_outDataCore$DEQ,
       dmem_serverAdapterB_outDataCore$EMPTY_N,
       dmem_serverAdapterB_outDataCore$ENQ,
       dmem_serverAdapterB_outDataCore$FULL_N;

  // ports of submodule req_from_core_ff
  wire [172 : 0] req_from_core_ff$D_IN, req_from_core_ff$D_OUT;
  wire req_from_core_ff$CLR,
       req_from_core_ff$DEQ,
       req_from_core_ff$EMPTY_N,
       req_from_core_ff$ENQ,
       req_from_core_ff$FULL_N;

  // ports of submodule req_from_core_firstValid
  wire req_from_core_firstValid$D_IN,
       req_from_core_firstValid$EN,
       req_from_core_firstValid$Q_OUT;

  // ports of submodule rsp_to_core_ff
  wire [88 : 0] rsp_to_core_ff$D_IN, rsp_to_core_ff$D_OUT;
  wire rsp_to_core_ff$CLR,
       rsp_to_core_ff$DEQ,
       rsp_to_core_ff$EMPTY_N,
       rsp_to_core_ff$ENQ,
       rsp_to_core_ff$FULL_N;

  // ports of submodule rsp_to_core_firstValid
  wire rsp_to_core_firstValid$D_IN,
       rsp_to_core_firstValid$EN,
       rsp_to_core_firstValid$Q_OUT;

  // rule scheduling signals
  wire CAN_FIRE_RL_dmem_serverAdapterA_cnt_finalAdd,
       CAN_FIRE_RL_dmem_serverAdapterA_moveToOutFIFO,
       CAN_FIRE_RL_dmem_serverAdapterA_outData_deqOnly,
       CAN_FIRE_RL_dmem_serverAdapterA_outData_enqAndDeq,
       CAN_FIRE_RL_dmem_serverAdapterA_outData_enqOnly,
       CAN_FIRE_RL_dmem_serverAdapterA_outData_setFirstCore,
       CAN_FIRE_RL_dmem_serverAdapterA_outData_setFirstEnq,
       CAN_FIRE_RL_dmem_serverAdapterA_overRun,
       CAN_FIRE_RL_dmem_serverAdapterA_s1__dreg_update,
       CAN_FIRE_RL_dmem_serverAdapterA_stageReadResponse,
       CAN_FIRE_RL_dmem_serverAdapterA_stageWriteResponse,
       CAN_FIRE_RL_dmem_serverAdapterA_stageWriteResponseBypass,
       CAN_FIRE_RL_dmem_serverAdapterB_cnt_finalAdd,
       CAN_FIRE_RL_dmem_serverAdapterB_moveToOutFIFO,
       CAN_FIRE_RL_dmem_serverAdapterB_outData_deqOnly,
       CAN_FIRE_RL_dmem_serverAdapterB_outData_enqAndDeq,
       CAN_FIRE_RL_dmem_serverAdapterB_outData_enqOnly,
       CAN_FIRE_RL_dmem_serverAdapterB_outData_setFirstCore,
       CAN_FIRE_RL_dmem_serverAdapterB_outData_setFirstEnq,
       CAN_FIRE_RL_dmem_serverAdapterB_overRun,
       CAN_FIRE_RL_dmem_serverAdapterB_s1__dreg_update,
       CAN_FIRE_RL_dmem_serverAdapterB_stageReadResponse,
       CAN_FIRE_RL_dmem_serverAdapterB_stageWriteResponse,
       CAN_FIRE_RL_dmem_serverAdapterB_stageWriteResponseBypass,
       CAN_FIRE_RL_get_request,
       CAN_FIRE_RL_read_request_from_proc,
       CAN_FIRE_RL_req_from_core_dequeue,
       CAN_FIRE_RL_req_from_core_enqueue,
       CAN_FIRE_RL_rl_clock,
       CAN_FIRE_RL_rsp_to_core_dequeue,
       CAN_FIRE_RL_rsp_to_core_enqueue,
       CAN_FIRE_flush_from_proc,
       CAN_FIRE_intfc_rcv_rx_put,
       CAN_FIRE_intfc_rcv_tx_get,
       WILL_FIRE_RL_dmem_serverAdapterA_cnt_finalAdd,
       WILL_FIRE_RL_dmem_serverAdapterA_moveToOutFIFO,
       WILL_FIRE_RL_dmem_serverAdapterA_outData_deqOnly,
       WILL_FIRE_RL_dmem_serverAdapterA_outData_enqAndDeq,
       WILL_FIRE_RL_dmem_serverAdapterA_outData_enqOnly,
       WILL_FIRE_RL_dmem_serverAdapterA_outData_setFirstCore,
       WILL_FIRE_RL_dmem_serverAdapterA_outData_setFirstEnq,
       WILL_FIRE_RL_dmem_serverAdapterA_overRun,
       WILL_FIRE_RL_dmem_serverAdapterA_s1__dreg_update,
       WILL_FIRE_RL_dmem_serverAdapterA_stageReadResponse,
       WILL_FIRE_RL_dmem_serverAdapterA_stageWriteResponse,
       WILL_FIRE_RL_dmem_serverAdapterA_stageWriteResponseBypass,
       WILL_FIRE_RL_dmem_serverAdapterB_cnt_finalAdd,
       WILL_FIRE_RL_dmem_serverAdapterB_moveToOutFIFO,
       WILL_FIRE_RL_dmem_serverAdapterB_outData_deqOnly,
       WILL_FIRE_RL_dmem_serverAdapterB_outData_enqAndDeq,
       WILL_FIRE_RL_dmem_serverAdapterB_outData_enqOnly,
       WILL_FIRE_RL_dmem_serverAdapterB_outData_setFirstCore,
       WILL_FIRE_RL_dmem_serverAdapterB_outData_setFirstEnq,
       WILL_FIRE_RL_dmem_serverAdapterB_overRun,
       WILL_FIRE_RL_dmem_serverAdapterB_s1__dreg_update,
       WILL_FIRE_RL_dmem_serverAdapterB_stageReadResponse,
       WILL_FIRE_RL_dmem_serverAdapterB_stageWriteResponse,
       WILL_FIRE_RL_dmem_serverAdapterB_stageWriteResponseBypass,
       WILL_FIRE_RL_get_request,
       WILL_FIRE_RL_read_request_from_proc,
       WILL_FIRE_RL_req_from_core_dequeue,
       WILL_FIRE_RL_req_from_core_enqueue,
       WILL_FIRE_RL_rl_clock,
       WILL_FIRE_RL_rsp_to_core_dequeue,
       WILL_FIRE_RL_rsp_to_core_enqueue,
       WILL_FIRE_flush_from_proc,
       WILL_FIRE_intfc_rcv_rx_put,
       WILL_FIRE_intfc_rcv_tx_get;

  // inputs to muxes for submodule ports
  wire MUX_dmem_serverAdapterA_outData_enqData$wset_1__SEL_1,
       MUX_dmem_serverAdapterB_outData_enqData$wset_1__SEL_1;

  // remaining internal signals
  reg [63 : 0] CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2,
	       CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q3,
	       _theResult___snd__h5970,
	       _theResult___snd__h5987,
	       _theResult___snd__h6003,
	       new_data__h5068,
	       resp_to_core___1_data__h5101,
	       v__h4926,
	       v__h6086,
	       v__h6104,
	       v__h7301;
  reg [1 : 0] CASE_rg_transfer_size_0_0_1_0_3_0_1__q1;
  wire [63 : 0] new_data___1__h6220,
		new_data___1__h6285,
		new_data___1__h6350,
		new_data___1__h6414,
		new_data___1__h6499,
		new_data___1__h6584,
		new_data___1__h6651,
		new_data___1__h6715,
		new_data___1__h6800,
		new_data___1__h6885,
		new_data___1__h6970,
		new_data___1__h7055,
		new_data___1__h7140,
		new_data___1__h7225,
		x__h4588;
  wire [22 : 0] IF_rg_rd_wr_to_memory_01_THEN_IF_rg_transfer_s_ETC___d272;
  wire [2 : 0] dmem_serverAdapterA_cnt_6_PLUS_IF_dmem_serverA_ETC___d32;
  wire IF_req_from_core_ff_i_notEmpty__32_THEN_NOT_re_ETC___d167;

  // actionvalue method intfc_rcv_tx_get
  assign intfc_rcv_tx_get =
	     rsp_to_core_ff$EMPTY_N ?
	       rsp_to_core_ff$D_OUT :
	       rsp_to_core_enqw$wget ;
  assign RDY_intfc_rcv_tx_get =
	     rsp_to_core_firstValid$Q_OUT &&
	     (rsp_to_core_ff$EMPTY_N || WILL_FIRE_RL_read_request_from_proc) ;
  assign CAN_FIRE_intfc_rcv_tx_get =
	     rsp_to_core_firstValid$Q_OUT &&
	     (rsp_to_core_ff$EMPTY_N || WILL_FIRE_RL_read_request_from_proc) ;
  assign WILL_FIRE_intfc_rcv_tx_get = EN_intfc_rcv_tx_get ;

  // action method intfc_rcv_rx_put
  assign RDY_intfc_rcv_rx_put = req_from_core_ff$FULL_N ;
  assign CAN_FIRE_intfc_rcv_rx_put = req_from_core_ff$FULL_N ;
  assign WILL_FIRE_intfc_rcv_rx_put = EN_intfc_rcv_rx_put ;

  // action method flush_from_proc
  assign RDY_flush_from_proc = 1'd1 ;
  assign CAN_FIRE_flush_from_proc = 1'd1 ;
  assign WILL_FIRE_flush_from_proc = EN_flush_from_proc ;

  // submodule dmem_memory
  BRAM2Load #(.FILENAME("code.hex"),
	      .PIPELINED(1'd0),
	      .ADDR_WIDTH(32'd13),
	      .DATA_WIDTH(32'd64),
	      .MEMSIZE(14'd8192),
	      .BINARY(1'd0)) dmem_memory(.CLKA(CLK),
					 .CLKB(CLK),
					 .ADDRA(dmem_memory$ADDRA),
					 .ADDRB(dmem_memory$ADDRB),
					 .DIA(dmem_memory$DIA),
					 .DIB(dmem_memory$DIB),
					 .WEA(dmem_memory$WEA),
					 .WEB(dmem_memory$WEB),
					 .ENA(dmem_memory$ENA),
					 .ENB(dmem_memory$ENB),
					 .DOA(dmem_memory$DOA),
					 .DOB(dmem_memory$DOB));

  // submodule dmem_serverAdapterA_outDataCore
  FIFO2 #(.width(32'd64),
	  .guarded(32'd1)) dmem_serverAdapterA_outDataCore(.RST(RST_N),
							   .CLK(CLK),
							   .D_IN(dmem_serverAdapterA_outDataCore$D_IN),
							   .ENQ(dmem_serverAdapterA_outDataCore$ENQ),
							   .DEQ(dmem_serverAdapterA_outDataCore$DEQ),
							   .CLR(dmem_serverAdapterA_outDataCore$CLR),
							   .D_OUT(dmem_serverAdapterA_outDataCore$D_OUT),
							   .FULL_N(dmem_serverAdapterA_outDataCore$FULL_N),
							   .EMPTY_N(dmem_serverAdapterA_outDataCore$EMPTY_N));

  // submodule dmem_serverAdapterB_outDataCore
  FIFO2 #(.width(32'd64),
	  .guarded(32'd1)) dmem_serverAdapterB_outDataCore(.RST(RST_N),
							   .CLK(CLK),
							   .D_IN(dmem_serverAdapterB_outDataCore$D_IN),
							   .ENQ(dmem_serverAdapterB_outDataCore$ENQ),
							   .DEQ(dmem_serverAdapterB_outDataCore$DEQ),
							   .CLR(dmem_serverAdapterB_outDataCore$CLR),
							   .D_OUT(),
							   .FULL_N(dmem_serverAdapterB_outDataCore$FULL_N),
							   .EMPTY_N(dmem_serverAdapterB_outDataCore$EMPTY_N));

  // submodule req_from_core_ff
  FIFO1 #(.width(32'd173), .guarded(32'd0)) req_from_core_ff(.RST(RST_N),
							     .CLK(CLK),
							     .D_IN(req_from_core_ff$D_IN),
							     .ENQ(req_from_core_ff$ENQ),
							     .DEQ(req_from_core_ff$DEQ),
							     .CLR(req_from_core_ff$CLR),
							     .D_OUT(req_from_core_ff$D_OUT),
							     .FULL_N(req_from_core_ff$FULL_N),
							     .EMPTY_N(req_from_core_ff$EMPTY_N));

  // submodule req_from_core_firstValid
  RevertReg #(.width(32'd1), .init(1'd1)) req_from_core_firstValid(.CLK(CLK),
								   .D_IN(req_from_core_firstValid$D_IN),
								   .EN(req_from_core_firstValid$EN),
								   .Q_OUT(req_from_core_firstValid$Q_OUT));

  // submodule rsp_to_core_ff
  FIFO1 #(.width(32'd89), .guarded(32'd0)) rsp_to_core_ff(.RST(RST_N),
							  .CLK(CLK),
							  .D_IN(rsp_to_core_ff$D_IN),
							  .ENQ(rsp_to_core_ff$ENQ),
							  .DEQ(rsp_to_core_ff$DEQ),
							  .CLR(rsp_to_core_ff$CLR),
							  .D_OUT(rsp_to_core_ff$D_OUT),
							  .FULL_N(rsp_to_core_ff$FULL_N),
							  .EMPTY_N(rsp_to_core_ff$EMPTY_N));

  // submodule rsp_to_core_firstValid
  RevertReg #(.width(32'd1), .init(1'd1)) rsp_to_core_firstValid(.CLK(CLK),
								 .D_IN(rsp_to_core_firstValid$D_IN),
								 .EN(rsp_to_core_firstValid$EN),
								 .Q_OUT(rsp_to_core_firstValid$Q_OUT));

  // rule RL_rl_clock
  assign CAN_FIRE_RL_rl_clock = 1'd1 ;
  assign WILL_FIRE_RL_rl_clock = 1'd1 ;

  // rule RL_get_request
  assign CAN_FIRE_RL_get_request =
	     req_from_core_firstValid$Q_OUT &&
	     (req_from_core_ff$EMPTY_N || EN_intfc_rcv_rx_put) &&
	     (dmem_serverAdapterA_cnt ^ 3'h4) < 3'd6 &&
	     (!EN_flush_from_proc || !flush_from_proc_flush) ;
  assign WILL_FIRE_RL_get_request = CAN_FIRE_RL_get_request ;

  // rule RL_dmem_serverAdapterA_stageReadResponse
  assign CAN_FIRE_RL_dmem_serverAdapterA_stageReadResponse =
	     dmem_serverAdapterA_writeWithResp$whas ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_stageReadResponse =
	     dmem_serverAdapterA_writeWithResp$whas ;

  // rule RL_dmem_serverAdapterA_stageWriteResponseBypass
  assign CAN_FIRE_RL_dmem_serverAdapterA_stageWriteResponseBypass = 1'b0 ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_stageWriteResponseBypass = 1'b0 ;

  // rule RL_dmem_serverAdapterA_stageWriteResponse
  assign CAN_FIRE_RL_dmem_serverAdapterA_stageWriteResponse = 1'b0 ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_stageWriteResponse = 1'b0 ;

  // rule RL_dmem_serverAdapterA_moveToOutFIFO
  assign CAN_FIRE_RL_dmem_serverAdapterA_moveToOutFIFO =
	     dmem_serverAdapterA_outDataCore$FULL_N &&
	     dmem_serverAdapterA_s1[1] ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_moveToOutFIFO =
	     CAN_FIRE_RL_dmem_serverAdapterA_moveToOutFIFO ;

  // rule RL_dmem_serverAdapterA_overRun
  assign CAN_FIRE_RL_dmem_serverAdapterA_overRun =
	     dmem_serverAdapterA_s1[1] &&
	     !dmem_serverAdapterA_outDataCore$FULL_N ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_overRun =
	     CAN_FIRE_RL_dmem_serverAdapterA_overRun ;

  // rule RL_dmem_serverAdapterA_outData_setFirstCore
  assign CAN_FIRE_RL_dmem_serverAdapterA_outData_setFirstCore =
	     dmem_serverAdapterA_outDataCore$EMPTY_N ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_outData_setFirstCore =
	     dmem_serverAdapterA_outDataCore$EMPTY_N ;

  // rule RL_dmem_serverAdapterA_outData_setFirstEnq
  assign CAN_FIRE_RL_dmem_serverAdapterA_outData_setFirstEnq =
	     !dmem_serverAdapterA_outDataCore$EMPTY_N &&
	     MUX_dmem_serverAdapterA_outData_enqData$wset_1__SEL_1 ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_outData_setFirstEnq =
	     CAN_FIRE_RL_dmem_serverAdapterA_outData_setFirstEnq ;

  // rule RL_read_request_from_proc
  assign CAN_FIRE_RL_read_request_from_proc =
	     (dmem_serverAdapterA_outDataCore$EMPTY_N ||
	      MUX_dmem_serverAdapterA_outData_enqData$wset_1__SEL_1) &&
	     rsp_to_core_ff$FULL_N &&
	     (dmem_serverAdapterB_cnt ^ 3'h4) < 3'd6 &&
	     dmem_serverAdapterA_outData_outData$whas ;
  assign WILL_FIRE_RL_read_request_from_proc =
	     CAN_FIRE_RL_read_request_from_proc && !WILL_FIRE_RL_get_request ;

  // rule RL_dmem_serverAdapterA_outData_enqOnly
  assign CAN_FIRE_RL_dmem_serverAdapterA_outData_enqOnly =
	     dmem_serverAdapterA_outDataCore$FULL_N &&
	     !WILL_FIRE_RL_read_request_from_proc &&
	     MUX_dmem_serverAdapterA_outData_enqData$wset_1__SEL_1 ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_outData_enqOnly =
	     CAN_FIRE_RL_dmem_serverAdapterA_outData_enqOnly ;

  // rule RL_dmem_serverAdapterA_outData_deqOnly
  assign CAN_FIRE_RL_dmem_serverAdapterA_outData_deqOnly =
	     dmem_serverAdapterA_outDataCore$EMPTY_N &&
	     WILL_FIRE_RL_read_request_from_proc &&
	     !MUX_dmem_serverAdapterA_outData_enqData$wset_1__SEL_1 ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_outData_deqOnly =
	     CAN_FIRE_RL_dmem_serverAdapterA_outData_deqOnly ;

  // rule RL_dmem_serverAdapterA_outData_enqAndDeq
  assign CAN_FIRE_RL_dmem_serverAdapterA_outData_enqAndDeq =
	     dmem_serverAdapterA_outDataCore$EMPTY_N &&
	     dmem_serverAdapterA_outDataCore$FULL_N &&
	     WILL_FIRE_RL_read_request_from_proc &&
	     MUX_dmem_serverAdapterA_outData_enqData$wset_1__SEL_1 ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_outData_enqAndDeq =
	     CAN_FIRE_RL_dmem_serverAdapterA_outData_enqAndDeq ;

  // rule RL_dmem_serverAdapterA_cnt_finalAdd
  assign CAN_FIRE_RL_dmem_serverAdapterA_cnt_finalAdd =
	     dmem_serverAdapterA_writeWithResp$whas ||
	     WILL_FIRE_RL_read_request_from_proc ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_cnt_finalAdd =
	     CAN_FIRE_RL_dmem_serverAdapterA_cnt_finalAdd ;

  // rule RL_dmem_serverAdapterA_s1__dreg_update
  assign CAN_FIRE_RL_dmem_serverAdapterA_s1__dreg_update = 1'd1 ;
  assign WILL_FIRE_RL_dmem_serverAdapterA_s1__dreg_update = 1'd1 ;

  // rule RL_dmem_serverAdapterB_stageReadResponse
  assign CAN_FIRE_RL_dmem_serverAdapterB_stageReadResponse = 1'b0 ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_stageReadResponse = 1'b0 ;

  // rule RL_dmem_serverAdapterB_stageWriteResponseBypass
  assign CAN_FIRE_RL_dmem_serverAdapterB_stageWriteResponseBypass = 1'b0 ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_stageWriteResponseBypass = 1'b0 ;

  // rule RL_dmem_serverAdapterB_stageWriteResponse
  assign CAN_FIRE_RL_dmem_serverAdapterB_stageWriteResponse = 1'b0 ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_stageWriteResponse = 1'b0 ;

  // rule RL_dmem_serverAdapterB_moveToOutFIFO
  assign CAN_FIRE_RL_dmem_serverAdapterB_moveToOutFIFO =
	     dmem_serverAdapterB_outDataCore$FULL_N &&
	     dmem_serverAdapterB_s1[1] ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_moveToOutFIFO =
	     CAN_FIRE_RL_dmem_serverAdapterB_moveToOutFIFO ;

  // rule RL_dmem_serverAdapterB_overRun
  assign CAN_FIRE_RL_dmem_serverAdapterB_overRun =
	     dmem_serverAdapterB_s1[1] &&
	     !dmem_serverAdapterB_outDataCore$FULL_N ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_overRun =
	     CAN_FIRE_RL_dmem_serverAdapterB_overRun ;

  // rule RL_dmem_serverAdapterB_outData_setFirstCore
  assign CAN_FIRE_RL_dmem_serverAdapterB_outData_setFirstCore =
	     dmem_serverAdapterB_outDataCore$EMPTY_N ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_outData_setFirstCore =
	     dmem_serverAdapterB_outDataCore$EMPTY_N ;

  // rule RL_dmem_serverAdapterB_outData_setFirstEnq
  assign CAN_FIRE_RL_dmem_serverAdapterB_outData_setFirstEnq =
	     !dmem_serverAdapterB_outDataCore$EMPTY_N &&
	     MUX_dmem_serverAdapterB_outData_enqData$wset_1__SEL_1 ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_outData_setFirstEnq =
	     CAN_FIRE_RL_dmem_serverAdapterB_outData_setFirstEnq ;

  // rule RL_dmem_serverAdapterB_outData_enqOnly
  assign CAN_FIRE_RL_dmem_serverAdapterB_outData_enqOnly =
	     dmem_serverAdapterB_outDataCore$FULL_N &&
	     MUX_dmem_serverAdapterB_outData_enqData$wset_1__SEL_1 ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_outData_enqOnly =
	     CAN_FIRE_RL_dmem_serverAdapterB_outData_enqOnly ;

  // rule RL_dmem_serverAdapterB_outData_deqOnly
  assign CAN_FIRE_RL_dmem_serverAdapterB_outData_deqOnly = 1'b0 ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_outData_deqOnly = 1'b0 ;

  // rule RL_dmem_serverAdapterB_outData_enqAndDeq
  assign CAN_FIRE_RL_dmem_serverAdapterB_outData_enqAndDeq = 1'b0 ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_outData_enqAndDeq = 1'b0 ;

  // rule RL_dmem_serverAdapterB_cnt_finalAdd
  assign CAN_FIRE_RL_dmem_serverAdapterB_cnt_finalAdd = 1'b0 ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_cnt_finalAdd = 1'b0 ;

  // rule RL_dmem_serverAdapterB_s1__dreg_update
  assign CAN_FIRE_RL_dmem_serverAdapterB_s1__dreg_update = 1'd1 ;
  assign WILL_FIRE_RL_dmem_serverAdapterB_s1__dreg_update = 1'd1 ;

  // rule RL_req_from_core_enqueue
  assign CAN_FIRE_RL_req_from_core_enqueue =
	     EN_intfc_rcv_rx_put &&
	     (!dmem_serverAdapterA_writeWithResp$whas ||
	      req_from_core_ff$EMPTY_N) ;
  assign WILL_FIRE_RL_req_from_core_enqueue =
	     CAN_FIRE_RL_req_from_core_enqueue ;

  // rule RL_req_from_core_dequeue
  assign CAN_FIRE_RL_req_from_core_dequeue =
	     dmem_serverAdapterA_writeWithResp$whas &&
	     req_from_core_ff$EMPTY_N ;
  assign WILL_FIRE_RL_req_from_core_dequeue =
	     CAN_FIRE_RL_req_from_core_dequeue ;

  // rule RL_rsp_to_core_enqueue
  assign CAN_FIRE_RL_rsp_to_core_enqueue =
	     WILL_FIRE_RL_read_request_from_proc &&
	     (!EN_intfc_rcv_tx_get || rsp_to_core_ff$EMPTY_N) ;
  assign WILL_FIRE_RL_rsp_to_core_enqueue = CAN_FIRE_RL_rsp_to_core_enqueue ;

  // rule RL_rsp_to_core_dequeue
  assign CAN_FIRE_RL_rsp_to_core_dequeue =
	     EN_intfc_rcv_tx_get && rsp_to_core_ff$EMPTY_N ;
  assign WILL_FIRE_RL_rsp_to_core_dequeue = CAN_FIRE_RL_rsp_to_core_dequeue ;

  // inputs to muxes for submodule ports
  assign MUX_dmem_serverAdapterA_outData_enqData$wset_1__SEL_1 =
	     WILL_FIRE_RL_dmem_serverAdapterA_moveToOutFIFO &&
	     dmem_serverAdapterA_s1[0] ;
  assign MUX_dmem_serverAdapterB_outData_enqData$wset_1__SEL_1 =
	     WILL_FIRE_RL_dmem_serverAdapterB_moveToOutFIFO &&
	     dmem_serverAdapterB_s1[0] ;

  // inlined wires
  assign dmem_serverAdapterA_outData_outData$wget =
	     dmem_serverAdapterA_outDataCore$EMPTY_N ?
	       dmem_serverAdapterA_outDataCore$D_OUT :
	       dmem_memory$DOA ;
  assign dmem_serverAdapterA_outData_outData$whas =
	     dmem_serverAdapterA_outDataCore$EMPTY_N ||
	     WILL_FIRE_RL_dmem_serverAdapterA_outData_setFirstEnq ;
  assign dmem_serverAdapterA_writeWithResp$whas =
	     WILL_FIRE_RL_get_request &&
	     IF_req_from_core_ff_i_notEmpty__32_THEN_NOT_re_ETC___d167 ;
  assign dmem_serverAdapterB_writeWithResp$whas =
	     WILL_FIRE_RL_read_request_from_proc && rg_rd_wr_to_memory ;
  assign rsp_to_core_enqw$wget =
	     { rg_rd_wr_to_memory ? 2'd1 : 2'd0,
	       resp_to_core___1_data__h5101,
	       IF_rg_rd_wr_to_memory_01_THEN_IF_rg_transfer_s_ETC___d272 } ;

  // register dmem_serverAdapterA_cnt
  assign dmem_serverAdapterA_cnt$D_IN =
	     dmem_serverAdapterA_cnt_6_PLUS_IF_dmem_serverA_ETC___d32 ;
  assign dmem_serverAdapterA_cnt$EN =
	     CAN_FIRE_RL_dmem_serverAdapterA_cnt_finalAdd ;

  // register dmem_serverAdapterA_s1
  assign dmem_serverAdapterA_s1$D_IN =
	     { dmem_serverAdapterA_writeWithResp$whas, 1'b1 } ;
  assign dmem_serverAdapterA_s1$EN = 1'd1 ;

  // register dmem_serverAdapterB_cnt
  assign dmem_serverAdapterB_cnt$D_IN =
	     dmem_serverAdapterB_cnt + 3'd0 + 3'd0 ;
  assign dmem_serverAdapterB_cnt$EN = 1'b0 ;

  // register dmem_serverAdapterB_s1
  assign dmem_serverAdapterB_s1$D_IN = 2'b01 ;
  assign dmem_serverAdapterB_s1$EN = 1'd1 ;

  // register rg_addr
  assign rg_addr$D_IN = x__h4588 ;
  assign rg_addr$EN = dmem_serverAdapterA_writeWithResp$whas ;

  // register rg_clock
  assign rg_clock$D_IN = rg_clock + 32'd1 ;
  assign rg_clock$EN = 1'd1 ;

  // register rg_count
  assign rg_count$D_IN = rg_count + 4'd1 ;
  assign rg_count$EN = dmem_serverAdapterA_writeWithResp$whas ;

  // register rg_data
  assign rg_data$D_IN =
	     req_from_core_ff$EMPTY_N ?
	       req_from_core_ff$D_OUT[103:40] :
	       intfc_rcv_rx_put[103:40] ;
  assign rg_data$EN = dmem_serverAdapterA_writeWithResp$whas ;

  // register rg_id
  assign rg_id$D_IN =
	     req_from_core_ff$EMPTY_N ?
	       req_from_core_ff$D_OUT[11:8] :
	       intfc_rcv_rx_put[11:8] ;
  assign rg_id$EN = dmem_serverAdapterA_writeWithResp$whas ;

  // register rg_rd_wr_to_memory
  assign rg_rd_wr_to_memory$D_IN =
	     (req_from_core_ff$EMPTY_N ?
		req_from_core_ff$D_OUT[171:170] :
		intfc_rcv_rx_put[171:170]) !=
	     2'd0 ;
  assign rg_rd_wr_to_memory$EN = dmem_serverAdapterA_writeWithResp$whas ;

  // register rg_state
  assign rg_state$D_IN = 1'b0 ;
  assign rg_state$EN = 1'b0 ;

  // register rg_transfer_size
  assign rg_transfer_size$D_IN =
	     req_from_core_ff$EMPTY_N ?
	       req_from_core_ff$D_OUT[24:22] :
	       intfc_rcv_rx_put[24:22] ;
  assign rg_transfer_size$EN = dmem_serverAdapterA_writeWithResp$whas ;

  // submodule dmem_memory
  assign dmem_memory$ADDRA = x__h4588[15:3] ;
  assign dmem_memory$ADDRB = rg_addr[15:3] ;
  assign dmem_memory$DIA = 64'd0 ;
  assign dmem_memory$DIB = new_data__h5068 ;
  assign dmem_memory$WEA = 1'd0 ;
  assign dmem_memory$WEB = 1'd1 ;
  assign dmem_memory$ENA = dmem_serverAdapterA_writeWithResp$whas ;
  assign dmem_memory$ENB = dmem_serverAdapterB_writeWithResp$whas ;

  // submodule dmem_serverAdapterA_outDataCore
  assign dmem_serverAdapterA_outDataCore$D_IN = dmem_memory$DOA ;
  assign dmem_serverAdapterA_outDataCore$ENQ =
	     WILL_FIRE_RL_dmem_serverAdapterA_outData_enqAndDeq ||
	     WILL_FIRE_RL_dmem_serverAdapterA_outData_enqOnly ;
  assign dmem_serverAdapterA_outDataCore$DEQ =
	     WILL_FIRE_RL_dmem_serverAdapterA_outData_enqAndDeq ||
	     WILL_FIRE_RL_dmem_serverAdapterA_outData_deqOnly ;
  assign dmem_serverAdapterA_outDataCore$CLR = 1'b0 ;

  // submodule dmem_serverAdapterB_outDataCore
  assign dmem_serverAdapterB_outDataCore$D_IN = dmem_memory$DOB ;
  assign dmem_serverAdapterB_outDataCore$ENQ =
	     WILL_FIRE_RL_dmem_serverAdapterB_outData_enqOnly ;
  assign dmem_serverAdapterB_outDataCore$DEQ = 1'b0 ;
  assign dmem_serverAdapterB_outDataCore$CLR = 1'b0 ;

  // submodule req_from_core_ff
  assign req_from_core_ff$D_IN = intfc_rcv_rx_put ;
  assign req_from_core_ff$ENQ = CAN_FIRE_RL_req_from_core_enqueue ;
  assign req_from_core_ff$DEQ = CAN_FIRE_RL_req_from_core_dequeue ;
  assign req_from_core_ff$CLR = 1'b0 ;

  // submodule req_from_core_firstValid
  assign req_from_core_firstValid$D_IN = 1'd1 ;
  assign req_from_core_firstValid$EN =
	     dmem_serverAdapterA_writeWithResp$whas ;

  // submodule rsp_to_core_ff
  assign rsp_to_core_ff$D_IN = rsp_to_core_enqw$wget ;
  assign rsp_to_core_ff$ENQ = CAN_FIRE_RL_rsp_to_core_enqueue ;
  assign rsp_to_core_ff$DEQ = CAN_FIRE_RL_rsp_to_core_dequeue ;
  assign rsp_to_core_ff$CLR = 1'b0 ;

  // submodule rsp_to_core_firstValid
  assign rsp_to_core_firstValid$D_IN = 1'd1 ;
  assign rsp_to_core_firstValid$EN = EN_intfc_rcv_tx_get ;

  // remaining internal signals
  assign IF_req_from_core_ff_i_notEmpty__32_THEN_NOT_re_ETC___d167 =
	     req_from_core_ff$EMPTY_N ?
	       !req_from_core_ff$D_OUT[172] :
	       EN_intfc_rcv_rx_put && !intfc_rcv_rx_put[172] ;
  assign IF_rg_rd_wr_to_memory_01_THEN_IF_rg_transfer_s_ETC___d272 =
	     { rg_rd_wr_to_memory ?
		 CASE_rg_transfer_size_0_0_1_0_3_0_1__q1 :
		 2'd0,
	       5'b01010 /* unspecified value */ ,
	       4'b1010 /* unspecified value */ ,
	       rg_id,
	       8'b10101010 /* unspecified value */  } ;
  assign dmem_serverAdapterA_cnt_6_PLUS_IF_dmem_serverA_ETC___d32 =
	     dmem_serverAdapterA_cnt +
	     (dmem_serverAdapterA_writeWithResp$whas ? 3'd1 : 3'd0) +
	     (WILL_FIRE_RL_read_request_from_proc ? 3'd7 : 3'd0) ;
  assign new_data___1__h6220 =
	     { dmem_serverAdapterA_outData_outData$wget[63:32],
	       rg_data[31:0] } ;
  assign new_data___1__h6285 =
	     { rg_data[31:0],
	       dmem_serverAdapterA_outData_outData$wget[31:0] } ;
  assign new_data___1__h6350 =
	     { dmem_serverAdapterA_outData_outData$wget[63:16],
	       rg_data[15:0] } ;
  assign new_data___1__h6414 =
	     { dmem_serverAdapterA_outData_outData$wget[63:32],
	       rg_data[15:0],
	       dmem_serverAdapterA_outData_outData$wget[15:0] } ;
  assign new_data___1__h6499 =
	     { dmem_serverAdapterA_outData_outData$wget[63:48],
	       rg_data[15:0],
	       dmem_serverAdapterA_outData_outData$wget[31:0] } ;
  assign new_data___1__h6584 =
	     { rg_data[15:0],
	       dmem_serverAdapterA_outData_outData$wget[47:0] } ;
  assign new_data___1__h6651 =
	     { dmem_serverAdapterA_outData_outData$wget[63:8],
	       rg_data[7:0] } ;
  assign new_data___1__h6715 =
	     { dmem_serverAdapterA_outData_outData$wget[63:16],
	       rg_data[7:0],
	       dmem_serverAdapterA_outData_outData$wget[7:0] } ;
  assign new_data___1__h6800 =
	     { dmem_serverAdapterA_outData_outData$wget[63:24],
	       rg_data[7:0],
	       dmem_serverAdapterA_outData_outData$wget[15:0] } ;
  assign new_data___1__h6885 =
	     { dmem_serverAdapterA_outData_outData$wget[63:32],
	       rg_data[7:0],
	       dmem_serverAdapterA_outData_outData$wget[23:0] } ;
  assign new_data___1__h6970 =
	     { dmem_serverAdapterA_outData_outData$wget[63:40],
	       rg_data[7:0],
	       dmem_serverAdapterA_outData_outData$wget[31:0] } ;
  assign new_data___1__h7055 =
	     { dmem_serverAdapterA_outData_outData$wget[63:48],
	       rg_data[7:0],
	       dmem_serverAdapterA_outData_outData$wget[39:0] } ;
  assign new_data___1__h7140 =
	     { dmem_serverAdapterA_outData_outData$wget[63:56],
	       rg_data[7:0],
	       dmem_serverAdapterA_outData_outData$wget[47:0] } ;
  assign new_data___1__h7225 =
	     { rg_data[7:0],
	       dmem_serverAdapterA_outData_outData$wget[55:0] } ;
  assign x__h4588 =
	     req_from_core_ff$EMPTY_N ?
	       req_from_core_ff$D_OUT[167:104] :
	       intfc_rcv_rx_put[167:104] ;
  always@(rg_transfer_size)
  begin
    case (rg_transfer_size)
      3'd0, 3'd1, 3'd3: CASE_rg_transfer_size_0_0_1_0_3_0_1__q1 = 2'd0;
      default: CASE_rg_transfer_size_0_0_1_0_3_0_1__q1 = 2'd1;
    endcase
  end
  always@(rg_addr or dmem_serverAdapterA_outData_outData$wget)
  begin
    case (rg_addr[2:0])
      3'd0:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2 =
	      { 56'd0, dmem_serverAdapterA_outData_outData$wget[7:0] };
      3'd1:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2 =
	      { 56'd0, dmem_serverAdapterA_outData_outData$wget[15:8] };
      3'd2:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2 =
	      { 56'd0, dmem_serverAdapterA_outData_outData$wget[23:16] };
      3'd3:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2 =
	      { 56'd0, dmem_serverAdapterA_outData_outData$wget[31:24] };
      3'd4:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2 =
	      { 56'd0, dmem_serverAdapterA_outData_outData$wget[39:32] };
      3'd5:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2 =
	      { 56'd0, dmem_serverAdapterA_outData_outData$wget[47:40] };
      3'd6:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2 =
	      { 56'd0, dmem_serverAdapterA_outData_outData$wget[55:48] };
      3'd7:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2 =
	      { 56'd0, dmem_serverAdapterA_outData_outData$wget[63:56] };
    endcase
  end
  always@(rg_addr or dmem_serverAdapterA_outData_outData$wget)
  begin
    case (rg_addr[2:0])
      3'd0:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q3 =
	      { 48'd0, dmem_serverAdapterA_outData_outData$wget[15:0] };
      3'd2:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q3 =
	      { 48'd0, dmem_serverAdapterA_outData_outData$wget[31:16] };
      3'd4:
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q3 =
	      { 48'd0, dmem_serverAdapterA_outData_outData$wget[47:32] };
      default: CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q3 =
		   { 48'd0, dmem_serverAdapterA_outData_outData$wget[63:48] };
    endcase
  end
  always@(rg_transfer_size or
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2 or
	  CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q3 or
	  rg_addr or dmem_serverAdapterA_outData_outData$wget)
  begin
    case (rg_transfer_size)
      3'd1:
	  resp_to_core___1_data__h5101 =
	      CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q3;
      3'd3:
	  resp_to_core___1_data__h5101 =
	      (rg_addr[2:0] == 3'd0) ?
		{ 32'd0, dmem_serverAdapterA_outData_outData$wget[31:0] } :
		{ 32'd0, dmem_serverAdapterA_outData_outData$wget[63:32] };
      3'd7:
	  resp_to_core___1_data__h5101 =
	      dmem_serverAdapterA_outData_outData$wget;
      default: resp_to_core___1_data__h5101 =
		   CASE_rg_addr_BITS_2_TO_0_0_0_CONCAT_dmem_serve_ETC__q2;
    endcase
  end
  always@(rg_addr or new_data___1__h6220 or new_data___1__h6285)
  begin
    case (rg_addr[2:0])
      3'd0: _theResult___snd__h5970 = new_data___1__h6220;
      3'd4: _theResult___snd__h5970 = new_data___1__h6285;
      default: _theResult___snd__h5970 = 64'd0;
    endcase
  end
  always@(rg_addr or
	  new_data___1__h6350 or
	  new_data___1__h6414 or new_data___1__h6499 or new_data___1__h6584)
  begin
    case (rg_addr[2:0])
      3'd0: _theResult___snd__h5987 = new_data___1__h6350;
      3'd2: _theResult___snd__h5987 = new_data___1__h6414;
      3'd4: _theResult___snd__h5987 = new_data___1__h6499;
      3'd6: _theResult___snd__h5987 = new_data___1__h6584;
      default: _theResult___snd__h5987 = 64'd0;
    endcase
  end
  always@(rg_addr or
	  new_data___1__h6651 or
	  new_data___1__h6715 or
	  new_data___1__h6800 or
	  new_data___1__h6885 or
	  new_data___1__h6970 or
	  new_data___1__h7055 or new_data___1__h7140 or new_data___1__h7225)
  begin
    case (rg_addr[2:0])
      3'd0: _theResult___snd__h6003 = new_data___1__h6651;
      3'd1: _theResult___snd__h6003 = new_data___1__h6715;
      3'd2: _theResult___snd__h6003 = new_data___1__h6800;
      3'd3: _theResult___snd__h6003 = new_data___1__h6885;
      3'd4: _theResult___snd__h6003 = new_data___1__h6970;
      3'd5: _theResult___snd__h6003 = new_data___1__h7055;
      3'd6: _theResult___snd__h6003 = new_data___1__h7140;
      3'd7: _theResult___snd__h6003 = new_data___1__h7225;
    endcase
  end
  always@(rg_transfer_size or
	  _theResult___snd__h6003 or
	  _theResult___snd__h5987 or _theResult___snd__h5970)
  begin
    case (rg_transfer_size)
      3'd0: new_data__h5068 = _theResult___snd__h6003;
      3'd1: new_data__h5068 = _theResult___snd__h5987;
      3'd3: new_data__h5068 = _theResult___snd__h5970;
      default: new_data__h5068 = 64'd0;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        dmem_serverAdapterA_cnt <= `BSV_ASSIGNMENT_DELAY 3'd0;
	dmem_serverAdapterA_s1 <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 1'b0 /* unspecified value */  };
	dmem_serverAdapterB_cnt <= `BSV_ASSIGNMENT_DELAY 3'd0;
	dmem_serverAdapterB_s1 <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 1'b0 /* unspecified value */  };
	rg_addr <= `BSV_ASSIGNMENT_DELAY 64'd0;
	rg_clock <= `BSV_ASSIGNMENT_DELAY 32'd0;
	rg_count <= `BSV_ASSIGNMENT_DELAY 4'd0;
	rg_data <= `BSV_ASSIGNMENT_DELAY 64'd0;
	rg_id <= `BSV_ASSIGNMENT_DELAY 4'd0;
	rg_rd_wr_to_memory <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_state <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_transfer_size <= `BSV_ASSIGNMENT_DELAY 3'd0;
      end
    else
      begin
        if (dmem_serverAdapterA_cnt$EN)
	  dmem_serverAdapterA_cnt <= `BSV_ASSIGNMENT_DELAY
	      dmem_serverAdapterA_cnt$D_IN;
	if (dmem_serverAdapterA_s1$EN)
	  dmem_serverAdapterA_s1 <= `BSV_ASSIGNMENT_DELAY
	      dmem_serverAdapterA_s1$D_IN;
	if (dmem_serverAdapterB_cnt$EN)
	  dmem_serverAdapterB_cnt <= `BSV_ASSIGNMENT_DELAY
	      dmem_serverAdapterB_cnt$D_IN;
	if (dmem_serverAdapterB_s1$EN)
	  dmem_serverAdapterB_s1 <= `BSV_ASSIGNMENT_DELAY
	      dmem_serverAdapterB_s1$D_IN;
	if (rg_addr$EN) rg_addr <= `BSV_ASSIGNMENT_DELAY rg_addr$D_IN;
	if (rg_clock$EN) rg_clock <= `BSV_ASSIGNMENT_DELAY rg_clock$D_IN;
	if (rg_count$EN) rg_count <= `BSV_ASSIGNMENT_DELAY rg_count$D_IN;
	if (rg_data$EN) rg_data <= `BSV_ASSIGNMENT_DELAY rg_data$D_IN;
	if (rg_id$EN) rg_id <= `BSV_ASSIGNMENT_DELAY rg_id$D_IN;
	if (rg_rd_wr_to_memory$EN)
	  rg_rd_wr_to_memory <= `BSV_ASSIGNMENT_DELAY rg_rd_wr_to_memory$D_IN;
	if (rg_state$EN) rg_state <= `BSV_ASSIGNMENT_DELAY rg_state$D_IN;
	if (rg_transfer_size$EN)
	  rg_transfer_size <= `BSV_ASSIGNMENT_DELAY rg_transfer_size$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    dmem_serverAdapterA_cnt = 3'h2;
    dmem_serverAdapterA_s1 = 2'h2;
    dmem_serverAdapterB_cnt = 3'h2;
    dmem_serverAdapterB_s1 = 2'h2;
    rg_addr = 64'hAAAAAAAAAAAAAAAA;
    rg_clock = 32'hAAAAAAAA;
    rg_count = 4'hA;
    rg_data = 64'hAAAAAAAAAAAAAAAA;
    rg_id = 4'hA;
    rg_rd_wr_to_memory = 1'h0;
    rg_state = 1'h0;
    rg_transfer_size = 3'h2;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_get_request &&
	  IF_req_from_core_ff_i_notEmpty__32_THEN_NOT_re_ETC___d167)
	begin
	  v__h4926 = $time;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_get_request &&
	  IF_req_from_core_ff_i_notEmpty__32_THEN_NOT_re_ETC___d167)
	$display(v__h4926,
		 "\tGot the request from the core addr: %h",
		 x__h4588);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_dmem_serverAdapterA_overRun)
	$display("ERROR: %m: mkBRAMSeverAdapter overrun");
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_read_request_from_proc && rg_rd_wr_to_memory)
	begin
	  v__h7301 = $time;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_read_request_from_proc && rg_rd_wr_to_memory)
	$display(v__h7301,
		 " Main Mem : Received request from D-cache Write for address : %h Size : %d sending data : %h",
		 rg_addr,
		 rg_transfer_size,
		 new_data__h5068);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_read_request_from_proc && !rg_rd_wr_to_memory)
	begin
	  v__h6086 = $time;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_read_request_from_proc && !rg_rd_wr_to_memory)
	begin
	  v__h6104 = $time;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_read_request_from_proc && !rg_rd_wr_to_memory)
	$display(v__h6086,
		 "\t Main Mem : Received single transaction request from D-cache READ for address : %h Size : %d sending data : %h data0:%h",
		 rg_addr,
		 rg_transfer_size,
		 resp_to_core___1_data__h5101,
		 dmem_serverAdapterA_outData_outData$wget,
		 v__h6104);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_dmem_serverAdapterB_overRun)
	$display("ERROR: %m: mkBRAMSeverAdapter overrun");
  end
  // synopsys translate_on
endmodule  // mkTLM_Memory
