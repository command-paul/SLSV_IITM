//
// Generated by Bluespec Compiler, version 2015.09.beta2 (build 34689, 2015-09-07)
//
// On Mon Dec 19 16:37:10 IST 2016
//
//
// Ports:
// Name                         I/O  size props
// intfc_tx_get                   O   173
// RDY_intfc_tx_get               O     1
// RDY_intfc_rx_put               O     1
// RDY_sin                        O     1 const
// sout                           O     1 reg
// RDY_sout                       O     1 const
// flush                          O     1
// RDY_flush                      O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// intfc_rx_put                   I    89
// sin_in                         I     1 reg
// EN_intfc_rx_put                I     1
// EN_sin                         I     1
// EN_intfc_tx_get                I     1
//
// No combinational paths from inputs to outputs
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

module mkcore_copy(CLK,
		   RST_N,

		   EN_intfc_tx_get,
		   intfc_tx_get,
		   RDY_intfc_tx_get,

		   intfc_rx_put,
		   EN_intfc_rx_put,
		   RDY_intfc_rx_put,

		   sin_in,
		   EN_sin,
		   RDY_sin,

		   sout,
		   RDY_sout,

		   flush,
		   RDY_flush);
  input  CLK;
  input  RST_N;

  // actionvalue method intfc_tx_get
  input  EN_intfc_tx_get;
  output [172 : 0] intfc_tx_get;
  output RDY_intfc_tx_get;

  // action method intfc_rx_put
  input  [88 : 0] intfc_rx_put;
  input  EN_intfc_rx_put;
  output RDY_intfc_rx_put;

  // action method sin
  input  sin_in;
  input  EN_sin;
  output RDY_sin;

  // value method sout
  output sout;
  output RDY_sout;

  // value method flush
  output flush;
  output RDY_flush;

  // signals for module outputs
  wire [172 : 0] intfc_tx_get;
  wire RDY_flush,
       RDY_intfc_rx_put,
       RDY_intfc_tx_get,
       RDY_sin,
       RDY_sout,
       flush,
       sout;

  // inlined wires
  wire [173 : 0] req_from_core_rv$port0__write_1,
		 req_from_core_rv$port1__read,
		 req_from_core_rv$port1__write_1,
		 req_from_core_rv$port2__read;
  wire [89 : 0] rsp_to_core_rv$port0__write_1,
		rsp_to_core_rv$port1__read,
		rsp_to_core_rv$port1__write_1,
		rsp_to_core_rv$port2__read;
  wire req_from_core_rv$EN_port0__write;

  // register count
  reg [3 : 0] count;
  wire [3 : 0] count$D_IN;
  wire count$EN;

  // register req_from_core_rv
  reg [173 : 0] req_from_core_rv;
  wire [173 : 0] req_from_core_rv$D_IN;
  wire req_from_core_rv$EN;

  // register rg_address
  reg [63 : 0] rg_address;
  reg [63 : 0] rg_address$D_IN;
  wire rg_address$EN;

  // register rg_burst_length
  reg [4 : 0] rg_burst_length;
  reg [4 : 0] rg_burst_length$D_IN;
  wire rg_burst_length$EN;

  // register rg_need_to_drop_incoming_data
  reg rg_need_to_drop_incoming_data;
  wire rg_need_to_drop_incoming_data$D_IN, rg_need_to_drop_incoming_data$EN;

  // register rg_state
  reg [1 : 0] rg_state;
  reg [1 : 0] rg_state$D_IN;
  wire rg_state$EN;

  // register rsp_to_core_rv
  reg [89 : 0] rsp_to_core_rv;
  wire [89 : 0] rsp_to_core_rv$D_IN;
  wire rsp_to_core_rv$EN;

  // ports of submodule core
  wire [136 : 0] core$data_outputs_;
  wire [129 : 0] core$_data_inputs_mem_data,
		 core$_instruction_inputs_mem_data;
  wire [37 : 0] core$instruction_outputs_;
  wire core$EN__data_inputs,
       core$EN__instruction_inputs,
       core$EN_instruction_outputs_,
       core$EN_sin,
       core$RDY_instruction_outputs_,
       core$flush_from_cpu_,
       core$sin_in,
       core$sout;

  // rule scheduling signals
  wire CAN_FIRE_RL_check_request_to_memory_from_either_ports,
       CAN_FIRE_RL_flush_caches,
       CAN_FIRE_RL_read_flush_signal_from_cpu,
       CAN_FIRE_RL_read_request_from_icache,
       CAN_FIRE_RL_send_response_from_memory_to_core,
       CAN_FIRE_intfc_rx_put,
       CAN_FIRE_intfc_tx_get,
       CAN_FIRE_sin,
       WILL_FIRE_RL_check_request_to_memory_from_either_ports,
       WILL_FIRE_RL_flush_caches,
       WILL_FIRE_RL_read_flush_signal_from_cpu,
       WILL_FIRE_RL_read_request_from_icache,
       WILL_FIRE_RL_send_response_from_memory_to_core,
       WILL_FIRE_intfc_rx_put,
       WILL_FIRE_intfc_tx_get,
       WILL_FIRE_sin;

  // inputs to muxes for submodule ports
  wire [173 : 0] MUX_req_from_core_rv$port0__write_1__VAL_1,
		 MUX_req_from_core_rv$port0__write_1__VAL_2;
  wire [63 : 0] MUX_rg_address$write_1__VAL_1;
  wire [4 : 0] MUX_rg_burst_length$write_1__VAL_1;
  wire MUX_rg_address$write_1__SEL_1,
       MUX_rg_burst_length$write_1__SEL_1,
       MUX_rg_state$write_1__SEL_1;

  // remaining internal signals
  reg [63 : 0] v__h1522, v__h2078, v__h2096, v__h2249, v__h2267, v__h978;
  reg [2 : 0] burst_size__h1274;
  wire [63 : 0] addr__h1655;
  wire x__h2208;

  // actionvalue method intfc_tx_get
  assign intfc_tx_get = req_from_core_rv$port1__read[172:0] ;
  assign RDY_intfc_tx_get = req_from_core_rv$port1__read[173] ;
  assign CAN_FIRE_intfc_tx_get = req_from_core_rv$port1__read[173] ;
  assign WILL_FIRE_intfc_tx_get = EN_intfc_tx_get ;

  // action method intfc_rx_put
  assign RDY_intfc_rx_put = !rsp_to_core_rv[89] ;
  assign CAN_FIRE_intfc_rx_put = !rsp_to_core_rv[89] ;
  assign WILL_FIRE_intfc_rx_put = EN_intfc_rx_put ;

  // action method sin
  assign RDY_sin = 1'd1 ;
  assign CAN_FIRE_sin = 1'd1 ;
  assign WILL_FIRE_sin = EN_sin ;

  // value method sout
  assign sout = core$sout ;
  assign RDY_sout = 1'd1 ;

  // value method flush
  assign flush = core$flush_from_cpu_ ;
  assign RDY_flush = 1'd1 ;

  // submodule core
  mkriscv core(.CLK(CLK),
	       .RST_N(RST_N),
	       ._data_inputs_mem_data(core$_data_inputs_mem_data),
	       ._instruction_inputs_mem_data(core$_instruction_inputs_mem_data),
	       .sin_in(core$sin_in),
	       .EN__instruction_inputs(core$EN__instruction_inputs),
	       .EN_instruction_outputs_(core$EN_instruction_outputs_),
	       .EN__data_inputs(core$EN__data_inputs),
	       .EN_sin(core$EN_sin),
	       .RDY__instruction_inputs(),
	       .instruction_outputs_(core$instruction_outputs_),
	       .RDY_instruction_outputs_(core$RDY_instruction_outputs_),
	       .RDY__data_inputs(),
	       .data_outputs_(core$data_outputs_),
	       .RDY_data_outputs_(),
	       .flush_from_cpu_(core$flush_from_cpu_),
	       .RDY_flush_from_cpu_(),
	       .RDY_sin(),
	       .sout(core$sout),
	       .RDY_sout());

  // rule RL_read_flush_signal_from_cpu
  assign CAN_FIRE_RL_read_flush_signal_from_cpu = 1'd1 ;
  assign WILL_FIRE_RL_read_flush_signal_from_cpu = 1'd1 ;

  // rule RL_flush_caches
  assign CAN_FIRE_RL_flush_caches = core$flush_from_cpu_ ;
  assign WILL_FIRE_RL_flush_caches = core$flush_from_cpu_ ;

  // rule RL_check_request_to_memory_from_either_ports
  assign CAN_FIRE_RL_check_request_to_memory_from_either_ports =
	     !req_from_core_rv[173] && rg_state == 2'd0 &&
	     !core$flush_from_cpu_ &&
	     core$data_outputs_[136] ;
  assign WILL_FIRE_RL_check_request_to_memory_from_either_ports =
	     CAN_FIRE_RL_check_request_to_memory_from_either_ports ;

  // rule RL_read_request_from_icache
  assign CAN_FIRE_RL_read_request_from_icache =
	     core$RDY_instruction_outputs_ && !req_from_core_rv[173] &&
	     rg_state == 2'd0 &&
	     !core$flush_from_cpu_ ;
  assign WILL_FIRE_RL_read_request_from_icache =
	     CAN_FIRE_RL_read_request_from_icache &&
	     !WILL_FIRE_RL_check_request_to_memory_from_either_ports ;

  // rule RL_send_response_from_memory_to_core
  assign CAN_FIRE_RL_send_response_from_memory_to_core =
	     rsp_to_core_rv$port1__read[89] && rg_state != 2'd0 &&
	     !core$flush_from_cpu_ ;
  assign WILL_FIRE_RL_send_response_from_memory_to_core =
	     CAN_FIRE_RL_send_response_from_memory_to_core ;

  // inputs to muxes for submodule ports
  assign MUX_rg_address$write_1__SEL_1 =
	     WILL_FIRE_RL_send_response_from_memory_to_core &&
	     rg_state == 2'd2 ;
  assign MUX_rg_burst_length$write_1__SEL_1 =
	     WILL_FIRE_RL_send_response_from_memory_to_core &&
	     rg_burst_length != 5'd1 ;
  assign MUX_rg_state$write_1__SEL_1 =
	     WILL_FIRE_RL_send_response_from_memory_to_core &&
	     rg_burst_length == 5'd1 ;
  assign MUX_req_from_core_rv$port0__write_1__VAL_1 =
	     { 2'd2,
	       core$data_outputs_[7] ? 2'd1 : 2'd0,
	       2'b10 /* unspecified value */ ,
	       core$data_outputs_[135:8],
	       5'd1,
	       8'b10101010 /* unspecified value */ ,
	       2'd0,
	       burst_size__h1274,
	       5'b01010 /* unspecified value */ ,
	       1'b0 /* unspecified value */ ,
	       4'b1010 /* unspecified value */ ,
	       count,
	       8'b10101010 /* unspecified value */  } ;
  assign MUX_req_from_core_rv$port0__write_1__VAL_2 =
	     { 4'd8,
	       2'b10 /* unspecified value */ ,
	       addr__h1655,
	       64'hAAAAAAAAAAAAAAAA /* unspecified value */ ,
	       core$instruction_outputs_[5:1],
	       8'b10101010 /* unspecified value */ ,
	       5'd3,
	       5'b01010 /* unspecified value */ ,
	       1'b0 /* unspecified value */ ,
	       4'b1010 /* unspecified value */ ,
	       count,
	       8'b10101010 /* unspecified value */  } ;
  assign MUX_rg_address$write_1__VAL_1 = rg_address + 64'd4 ;
  assign MUX_rg_burst_length$write_1__VAL_1 = rg_burst_length - 5'd1 ;

  // inlined wires
  assign req_from_core_rv$EN_port0__write =
	     WILL_FIRE_RL_check_request_to_memory_from_either_ports ||
	     WILL_FIRE_RL_read_request_from_icache ;
  assign req_from_core_rv$port0__write_1 =
	     WILL_FIRE_RL_check_request_to_memory_from_either_ports ?
	       MUX_req_from_core_rv$port0__write_1__VAL_1 :
	       MUX_req_from_core_rv$port0__write_1__VAL_2 ;
  assign req_from_core_rv$port1__read =
	     req_from_core_rv$EN_port0__write ?
	       req_from_core_rv$port0__write_1 :
	       req_from_core_rv ;
  assign req_from_core_rv$port1__write_1 =
	     { 1'd0,
	       173'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA /* unspecified value */  } ;
  assign req_from_core_rv$port2__read =
	     EN_intfc_tx_get ?
	       req_from_core_rv$port1__write_1 :
	       req_from_core_rv$port1__read ;
  assign rsp_to_core_rv$port0__write_1 = { 1'd1, intfc_rx_put } ;
  assign rsp_to_core_rv$port1__read =
	     EN_intfc_rx_put ?
	       rsp_to_core_rv$port0__write_1 :
	       rsp_to_core_rv ;
  assign rsp_to_core_rv$port1__write_1 =
	     { 1'd0, 89'h0AAAAAAAAAAAAAAAAAAAAAA /* unspecified value */  } ;
  assign rsp_to_core_rv$port2__read =
	     CAN_FIRE_RL_send_response_from_memory_to_core ?
	       rsp_to_core_rv$port1__write_1 :
	       rsp_to_core_rv$port1__read ;

  // register count
  assign count$D_IN = count + 4'd1 ;
  assign count$EN =
	     WILL_FIRE_RL_read_request_from_icache ||
	     WILL_FIRE_RL_check_request_to_memory_from_either_ports ;

  // register req_from_core_rv
  assign req_from_core_rv$D_IN = req_from_core_rv$port2__read ;
  assign req_from_core_rv$EN = 1'b1 ;

  // register rg_address
  always@(MUX_rg_address$write_1__SEL_1 or
	  MUX_rg_address$write_1__VAL_1 or
	  WILL_FIRE_RL_check_request_to_memory_from_either_ports or
	  core$data_outputs_ or
	  WILL_FIRE_RL_read_request_from_icache or addr__h1655)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_rg_address$write_1__SEL_1:
	  rg_address$D_IN = MUX_rg_address$write_1__VAL_1;
      WILL_FIRE_RL_check_request_to_memory_from_either_ports:
	  rg_address$D_IN = core$data_outputs_[135:72];
      WILL_FIRE_RL_read_request_from_icache: rg_address$D_IN = addr__h1655;
      default: rg_address$D_IN =
		   64'hAAAAAAAAAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign rg_address$EN =
	     WILL_FIRE_RL_send_response_from_memory_to_core &&
	     rg_state == 2'd2 ||
	     WILL_FIRE_RL_check_request_to_memory_from_either_ports ||
	     WILL_FIRE_RL_read_request_from_icache ;

  // register rg_burst_length
  always@(MUX_rg_burst_length$write_1__SEL_1 or
	  MUX_rg_burst_length$write_1__VAL_1 or
	  WILL_FIRE_RL_read_request_from_icache or
	  core$instruction_outputs_ or
	  WILL_FIRE_RL_check_request_to_memory_from_either_ports)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_rg_burst_length$write_1__SEL_1:
	  rg_burst_length$D_IN = MUX_rg_burst_length$write_1__VAL_1;
      WILL_FIRE_RL_read_request_from_icache:
	  rg_burst_length$D_IN = core$instruction_outputs_[5:1];
      WILL_FIRE_RL_check_request_to_memory_from_either_ports:
	  rg_burst_length$D_IN = 5'd1;
      default: rg_burst_length$D_IN = 5'b01010 /* unspecified value */ ;
    endcase
  end
  assign rg_burst_length$EN =
	     WILL_FIRE_RL_send_response_from_memory_to_core &&
	     rg_burst_length != 5'd1 ||
	     WILL_FIRE_RL_read_request_from_icache ||
	     WILL_FIRE_RL_check_request_to_memory_from_either_ports ;

  // register rg_need_to_drop_incoming_data
  assign rg_need_to_drop_incoming_data$D_IN = 1'd1 ;
  assign rg_need_to_drop_incoming_data$EN =
	     core$flush_from_cpu_ && rg_state == 2'd2 ;

  // register rg_state
  always@(MUX_rg_state$write_1__SEL_1 or
	  WILL_FIRE_RL_check_request_to_memory_from_either_ports or
	  WILL_FIRE_RL_read_request_from_icache)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_rg_state$write_1__SEL_1: rg_state$D_IN = 2'd0;
      WILL_FIRE_RL_check_request_to_memory_from_either_ports:
	  rg_state$D_IN = 2'd1;
      WILL_FIRE_RL_read_request_from_icache: rg_state$D_IN = 2'd2;
      default: rg_state$D_IN = 2'b10 /* unspecified value */ ;
    endcase
  end
  assign rg_state$EN =
	     WILL_FIRE_RL_send_response_from_memory_to_core &&
	     rg_burst_length == 5'd1 ||
	     WILL_FIRE_RL_check_request_to_memory_from_either_ports ||
	     WILL_FIRE_RL_read_request_from_icache ;

  // register rsp_to_core_rv
  assign rsp_to_core_rv$D_IN = rsp_to_core_rv$port2__read ;
  assign rsp_to_core_rv$EN = 1'b1 ;

  // submodule core
  assign core$_data_inputs_mem_data =
	     { rsp_to_core_rv$port1__read[86:23],
	       x__h2208,
	       1'd0,
	       64'hAAAAAAAAAAAAAAAA /* unspecified value */  } ;
  assign core$_instruction_inputs_mem_data =
	     { rsp_to_core_rv$port1__read[86:23],
	       x__h2208,
	       1'd0,
	       rg_address } ;
  assign core$sin_in = sin_in ;
  assign core$EN__instruction_inputs = MUX_rg_address$write_1__SEL_1 ;
  assign core$EN_instruction_outputs_ =
	     WILL_FIRE_RL_read_request_from_icache ;
  assign core$EN__data_inputs =
	     WILL_FIRE_RL_send_response_from_memory_to_core &&
	     rg_state == 2'd1 ;
  assign core$EN_sin = EN_sin ;

  // remaining internal signals
  assign addr__h1655 = { 32'd0, core$instruction_outputs_[37:6] } ;
  assign x__h2208 = rsp_to_core_rv$port1__read[22:21] == 2'd1 ;
  always@(core$data_outputs_)
  begin
    case (core$data_outputs_[6:5])
      2'd2: burst_size__h1274 = 3'd3;
      2'd3: burst_size__h1274 = 3'd7;
      default: burst_size__h1274 = { 1'd0, core$data_outputs_[6:5] };
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        count <= `BSV_ASSIGNMENT_DELAY 4'd0;
	req_from_core_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0,
	      173'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA /* unspecified value */  };
	rg_address <= `BSV_ASSIGNMENT_DELAY 64'd0;
	rg_burst_length <= `BSV_ASSIGNMENT_DELAY 5'd1;
	rg_need_to_drop_incoming_data <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rg_state <= `BSV_ASSIGNMENT_DELAY 2'd0;
	rsp_to_core_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 89'h0AAAAAAAAAAAAAAAAAAAAAA /* unspecified value */  };
      end
    else
      begin
        if (count$EN) count <= `BSV_ASSIGNMENT_DELAY count$D_IN;
	if (req_from_core_rv$EN)
	  req_from_core_rv <= `BSV_ASSIGNMENT_DELAY req_from_core_rv$D_IN;
	if (rg_address$EN)
	  rg_address <= `BSV_ASSIGNMENT_DELAY rg_address$D_IN;
	if (rg_burst_length$EN)
	  rg_burst_length <= `BSV_ASSIGNMENT_DELAY rg_burst_length$D_IN;
	if (rg_need_to_drop_incoming_data$EN)
	  rg_need_to_drop_incoming_data <= `BSV_ASSIGNMENT_DELAY
	      rg_need_to_drop_incoming_data$D_IN;
	if (rg_state$EN) rg_state <= `BSV_ASSIGNMENT_DELAY rg_state$D_IN;
	if (rsp_to_core_rv$EN)
	  rsp_to_core_rv <= `BSV_ASSIGNMENT_DELAY rsp_to_core_rv$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    count = 4'hA;
    req_from_core_rv = 174'h2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    rg_address = 64'hAAAAAAAAAAAAAAAA;
    rg_burst_length = 5'h0A;
    rg_need_to_drop_incoming_data = 1'h0;
    rg_state = 2'h2;
    rsp_to_core_rv = 90'h2AAAAAAAAAAAAAAAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_check_request_to_memory_from_either_ports)
	begin
	  v__h978 = $time;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_check_request_to_memory_from_either_ports)
	$display(v__h978,
		 "\tCORE: Sending Dcache request to Memory for Addr: %h",
		 core$data_outputs_[135:72]);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_read_request_from_icache)
	begin
	  v__h1522 = $time;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_read_request_from_icache)
	$display(v__h1522,
		 "\tCORE: Sending Icache request to Memory. Address: %h ",
		 core$instruction_outputs_[37:6]);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_send_response_from_memory_to_core && rg_state == 2'd1)
	begin
	  v__h2078 = $time;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_send_response_from_memory_to_core && rg_state == 2'd1)
	begin
	  v__h2096 = $time;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_send_response_from_memory_to_core && rg_state == 2'd1)
	$display(v__h2078,
		 "\tController : Sending the data back to the DCACHE",
		 v__h2096);
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_send_response_from_memory_to_core && rg_state == 2'd2)
	begin
	  v__h2249 = $time;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_send_response_from_memory_to_core && rg_state == 2'd2)
	begin
	  v__h2267 = $time;
	  #0;
	end
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_send_response_from_memory_to_core && rg_state == 2'd2)
	$display(v__h2249,
		 "\tController : Sending the data back to the ICACHE data:%h for address: %h",
		 rsp_to_core_rv$port1__read[86:23],
		 rg_address,
		 v__h2267);
  end
  // synopsys translate_on
endmodule  // mkcore_copy

