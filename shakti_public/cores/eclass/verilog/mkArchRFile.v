//
// Generated by Bluespec Compiler, version 2016.07.beta1 (build 34806, 2016-07-05)
//
// On Sun Jan 29 01:10:26 IST 2017
//
//
// Ports:
// Name                         I/O  size props
// RDY_upd                        O     1 const
// sub1                           O    32
// RDY_sub1                       O     1 const
// sub2                           O    32
// RDY_sub2                       O     1 const
// sub3                           O    32
// RDY_sub3                       O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// upd_fullRegIndex               I     5
// upd_data                       I    32 reg
// sub1_fullRegIndex              I     5
// sub2_fullRegIndex              I     5
// sub3_fullRegIndex              I     5
// EN_upd                         I     1
//
// Combinational paths from inputs to outputs:
//   sub1_fullRegIndex -> sub1
//   sub2_fullRegIndex -> sub2
//   sub3_fullRegIndex -> sub3
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

module mkArchRFile(CLK,
		   RST_N,

		   upd_fullRegIndex,
		   upd_data,
		   EN_upd,
		   RDY_upd,

		   sub1_fullRegIndex,
		   sub1,
		   RDY_sub1,

		   sub2_fullRegIndex,
		   sub2,
		   RDY_sub2,

		   sub3_fullRegIndex,
		   sub3,
		   RDY_sub3);
  input  CLK;
  input  RST_N;

  // action method upd
  input  [4 : 0] upd_fullRegIndex;
  input  [31 : 0] upd_data;
  input  EN_upd;
  output RDY_upd;

  // value method sub1
  input  [4 : 0] sub1_fullRegIndex;
  output [31 : 0] sub1;
  output RDY_sub1;

  // value method sub2
  input  [4 : 0] sub2_fullRegIndex;
  output [31 : 0] sub2;
  output RDY_sub2;

  // value method sub3
  input  [4 : 0] sub3_fullRegIndex;
  output [31 : 0] sub3;
  output RDY_sub3;

  // signals for module outputs
  reg [31 : 0] sub1, sub2, sub3;
  wire RDY_sub1, RDY_sub2, RDY_sub3, RDY_upd;

  // register gpr_rfile_0
  reg [31 : 0] gpr_rfile_0;
  wire [31 : 0] gpr_rfile_0$D_IN;
  wire gpr_rfile_0$EN;

  // register gpr_rfile_1
  reg [31 : 0] gpr_rfile_1;
  wire [31 : 0] gpr_rfile_1$D_IN;
  wire gpr_rfile_1$EN;

  // register gpr_rfile_10
  reg [31 : 0] gpr_rfile_10;
  wire [31 : 0] gpr_rfile_10$D_IN;
  wire gpr_rfile_10$EN;

  // register gpr_rfile_11
  reg [31 : 0] gpr_rfile_11;
  wire [31 : 0] gpr_rfile_11$D_IN;
  wire gpr_rfile_11$EN;

  // register gpr_rfile_12
  reg [31 : 0] gpr_rfile_12;
  wire [31 : 0] gpr_rfile_12$D_IN;
  wire gpr_rfile_12$EN;

  // register gpr_rfile_13
  reg [31 : 0] gpr_rfile_13;
  wire [31 : 0] gpr_rfile_13$D_IN;
  wire gpr_rfile_13$EN;

  // register gpr_rfile_14
  reg [31 : 0] gpr_rfile_14;
  wire [31 : 0] gpr_rfile_14$D_IN;
  wire gpr_rfile_14$EN;

  // register gpr_rfile_15
  reg [31 : 0] gpr_rfile_15;
  wire [31 : 0] gpr_rfile_15$D_IN;
  wire gpr_rfile_15$EN;

  // register gpr_rfile_16
  reg [31 : 0] gpr_rfile_16;
  wire [31 : 0] gpr_rfile_16$D_IN;
  wire gpr_rfile_16$EN;

  // register gpr_rfile_17
  reg [31 : 0] gpr_rfile_17;
  wire [31 : 0] gpr_rfile_17$D_IN;
  wire gpr_rfile_17$EN;

  // register gpr_rfile_18
  reg [31 : 0] gpr_rfile_18;
  wire [31 : 0] gpr_rfile_18$D_IN;
  wire gpr_rfile_18$EN;

  // register gpr_rfile_19
  reg [31 : 0] gpr_rfile_19;
  wire [31 : 0] gpr_rfile_19$D_IN;
  wire gpr_rfile_19$EN;

  // register gpr_rfile_2
  reg [31 : 0] gpr_rfile_2;
  wire [31 : 0] gpr_rfile_2$D_IN;
  wire gpr_rfile_2$EN;

  // register gpr_rfile_20
  reg [31 : 0] gpr_rfile_20;
  wire [31 : 0] gpr_rfile_20$D_IN;
  wire gpr_rfile_20$EN;

  // register gpr_rfile_21
  reg [31 : 0] gpr_rfile_21;
  wire [31 : 0] gpr_rfile_21$D_IN;
  wire gpr_rfile_21$EN;

  // register gpr_rfile_22
  reg [31 : 0] gpr_rfile_22;
  wire [31 : 0] gpr_rfile_22$D_IN;
  wire gpr_rfile_22$EN;

  // register gpr_rfile_23
  reg [31 : 0] gpr_rfile_23;
  wire [31 : 0] gpr_rfile_23$D_IN;
  wire gpr_rfile_23$EN;

  // register gpr_rfile_24
  reg [31 : 0] gpr_rfile_24;
  wire [31 : 0] gpr_rfile_24$D_IN;
  wire gpr_rfile_24$EN;

  // register gpr_rfile_25
  reg [31 : 0] gpr_rfile_25;
  wire [31 : 0] gpr_rfile_25$D_IN;
  wire gpr_rfile_25$EN;

  // register gpr_rfile_26
  reg [31 : 0] gpr_rfile_26;
  wire [31 : 0] gpr_rfile_26$D_IN;
  wire gpr_rfile_26$EN;

  // register gpr_rfile_27
  reg [31 : 0] gpr_rfile_27;
  wire [31 : 0] gpr_rfile_27$D_IN;
  wire gpr_rfile_27$EN;

  // register gpr_rfile_28
  reg [31 : 0] gpr_rfile_28;
  wire [31 : 0] gpr_rfile_28$D_IN;
  wire gpr_rfile_28$EN;

  // register gpr_rfile_29
  reg [31 : 0] gpr_rfile_29;
  wire [31 : 0] gpr_rfile_29$D_IN;
  wire gpr_rfile_29$EN;

  // register gpr_rfile_3
  reg [31 : 0] gpr_rfile_3;
  wire [31 : 0] gpr_rfile_3$D_IN;
  wire gpr_rfile_3$EN;

  // register gpr_rfile_30
  reg [31 : 0] gpr_rfile_30;
  wire [31 : 0] gpr_rfile_30$D_IN;
  wire gpr_rfile_30$EN;

  // register gpr_rfile_31
  reg [31 : 0] gpr_rfile_31;
  wire [31 : 0] gpr_rfile_31$D_IN;
  wire gpr_rfile_31$EN;

  // register gpr_rfile_4
  reg [31 : 0] gpr_rfile_4;
  wire [31 : 0] gpr_rfile_4$D_IN;
  wire gpr_rfile_4$EN;

  // register gpr_rfile_5
  reg [31 : 0] gpr_rfile_5;
  wire [31 : 0] gpr_rfile_5$D_IN;
  wire gpr_rfile_5$EN;

  // register gpr_rfile_6
  reg [31 : 0] gpr_rfile_6;
  wire [31 : 0] gpr_rfile_6$D_IN;
  wire gpr_rfile_6$EN;

  // register gpr_rfile_7
  reg [31 : 0] gpr_rfile_7;
  wire [31 : 0] gpr_rfile_7$D_IN;
  wire gpr_rfile_7$EN;

  // register gpr_rfile_8
  reg [31 : 0] gpr_rfile_8;
  wire [31 : 0] gpr_rfile_8$D_IN;
  wire gpr_rfile_8$EN;

  // register gpr_rfile_9
  reg [31 : 0] gpr_rfile_9;
  wire [31 : 0] gpr_rfile_9$D_IN;
  wire gpr_rfile_9$EN;

  // rule scheduling signals
  wire CAN_FIRE_upd, WILL_FIRE_upd;

  // action method upd
  assign RDY_upd = 1'd1 ;
  assign CAN_FIRE_upd = 1'd1 ;
  assign WILL_FIRE_upd = EN_upd ;

  // value method sub1
  always@(sub1_fullRegIndex or
	  gpr_rfile_1 or
	  gpr_rfile_2 or
	  gpr_rfile_3 or
	  gpr_rfile_4 or
	  gpr_rfile_5 or
	  gpr_rfile_6 or
	  gpr_rfile_7 or
	  gpr_rfile_8 or
	  gpr_rfile_9 or
	  gpr_rfile_10 or
	  gpr_rfile_11 or
	  gpr_rfile_12 or
	  gpr_rfile_13 or
	  gpr_rfile_14 or
	  gpr_rfile_15 or
	  gpr_rfile_16 or
	  gpr_rfile_17 or
	  gpr_rfile_18 or
	  gpr_rfile_19 or
	  gpr_rfile_20 or
	  gpr_rfile_21 or
	  gpr_rfile_22 or
	  gpr_rfile_23 or
	  gpr_rfile_24 or
	  gpr_rfile_25 or
	  gpr_rfile_26 or
	  gpr_rfile_27 or
	  gpr_rfile_28 or gpr_rfile_29 or gpr_rfile_30 or gpr_rfile_31)
  begin
    case (sub1_fullRegIndex)
      5'd0: sub1 = 32'd0;
      5'd1: sub1 = gpr_rfile_1;
      5'd2: sub1 = gpr_rfile_2;
      5'd3: sub1 = gpr_rfile_3;
      5'd4: sub1 = gpr_rfile_4;
      5'd5: sub1 = gpr_rfile_5;
      5'd6: sub1 = gpr_rfile_6;
      5'd7: sub1 = gpr_rfile_7;
      5'd8: sub1 = gpr_rfile_8;
      5'd9: sub1 = gpr_rfile_9;
      5'd10: sub1 = gpr_rfile_10;
      5'd11: sub1 = gpr_rfile_11;
      5'd12: sub1 = gpr_rfile_12;
      5'd13: sub1 = gpr_rfile_13;
      5'd14: sub1 = gpr_rfile_14;
      5'd15: sub1 = gpr_rfile_15;
      5'd16: sub1 = gpr_rfile_16;
      5'd17: sub1 = gpr_rfile_17;
      5'd18: sub1 = gpr_rfile_18;
      5'd19: sub1 = gpr_rfile_19;
      5'd20: sub1 = gpr_rfile_20;
      5'd21: sub1 = gpr_rfile_21;
      5'd22: sub1 = gpr_rfile_22;
      5'd23: sub1 = gpr_rfile_23;
      5'd24: sub1 = gpr_rfile_24;
      5'd25: sub1 = gpr_rfile_25;
      5'd26: sub1 = gpr_rfile_26;
      5'd27: sub1 = gpr_rfile_27;
      5'd28: sub1 = gpr_rfile_28;
      5'd29: sub1 = gpr_rfile_29;
      5'd30: sub1 = gpr_rfile_30;
      5'd31: sub1 = gpr_rfile_31;
    endcase
  end
  assign RDY_sub1 = 1'd1 ;

  // value method sub2
  always@(sub2_fullRegIndex or
	  gpr_rfile_1 or
	  gpr_rfile_2 or
	  gpr_rfile_3 or
	  gpr_rfile_4 or
	  gpr_rfile_5 or
	  gpr_rfile_6 or
	  gpr_rfile_7 or
	  gpr_rfile_8 or
	  gpr_rfile_9 or
	  gpr_rfile_10 or
	  gpr_rfile_11 or
	  gpr_rfile_12 or
	  gpr_rfile_13 or
	  gpr_rfile_14 or
	  gpr_rfile_15 or
	  gpr_rfile_16 or
	  gpr_rfile_17 or
	  gpr_rfile_18 or
	  gpr_rfile_19 or
	  gpr_rfile_20 or
	  gpr_rfile_21 or
	  gpr_rfile_22 or
	  gpr_rfile_23 or
	  gpr_rfile_24 or
	  gpr_rfile_25 or
	  gpr_rfile_26 or
	  gpr_rfile_27 or
	  gpr_rfile_28 or gpr_rfile_29 or gpr_rfile_30 or gpr_rfile_31)
  begin
    case (sub2_fullRegIndex)
      5'd0: sub2 = 32'd0;
      5'd1: sub2 = gpr_rfile_1;
      5'd2: sub2 = gpr_rfile_2;
      5'd3: sub2 = gpr_rfile_3;
      5'd4: sub2 = gpr_rfile_4;
      5'd5: sub2 = gpr_rfile_5;
      5'd6: sub2 = gpr_rfile_6;
      5'd7: sub2 = gpr_rfile_7;
      5'd8: sub2 = gpr_rfile_8;
      5'd9: sub2 = gpr_rfile_9;
      5'd10: sub2 = gpr_rfile_10;
      5'd11: sub2 = gpr_rfile_11;
      5'd12: sub2 = gpr_rfile_12;
      5'd13: sub2 = gpr_rfile_13;
      5'd14: sub2 = gpr_rfile_14;
      5'd15: sub2 = gpr_rfile_15;
      5'd16: sub2 = gpr_rfile_16;
      5'd17: sub2 = gpr_rfile_17;
      5'd18: sub2 = gpr_rfile_18;
      5'd19: sub2 = gpr_rfile_19;
      5'd20: sub2 = gpr_rfile_20;
      5'd21: sub2 = gpr_rfile_21;
      5'd22: sub2 = gpr_rfile_22;
      5'd23: sub2 = gpr_rfile_23;
      5'd24: sub2 = gpr_rfile_24;
      5'd25: sub2 = gpr_rfile_25;
      5'd26: sub2 = gpr_rfile_26;
      5'd27: sub2 = gpr_rfile_27;
      5'd28: sub2 = gpr_rfile_28;
      5'd29: sub2 = gpr_rfile_29;
      5'd30: sub2 = gpr_rfile_30;
      5'd31: sub2 = gpr_rfile_31;
    endcase
  end
  assign RDY_sub2 = 1'd1 ;

  // value method sub3
  always@(sub3_fullRegIndex or
	  gpr_rfile_1 or
	  gpr_rfile_2 or
	  gpr_rfile_3 or
	  gpr_rfile_4 or
	  gpr_rfile_5 or
	  gpr_rfile_6 or
	  gpr_rfile_7 or
	  gpr_rfile_8 or
	  gpr_rfile_9 or
	  gpr_rfile_10 or
	  gpr_rfile_11 or
	  gpr_rfile_12 or
	  gpr_rfile_13 or
	  gpr_rfile_14 or
	  gpr_rfile_15 or
	  gpr_rfile_16 or
	  gpr_rfile_17 or
	  gpr_rfile_18 or
	  gpr_rfile_19 or
	  gpr_rfile_20 or
	  gpr_rfile_21 or
	  gpr_rfile_22 or
	  gpr_rfile_23 or
	  gpr_rfile_24 or
	  gpr_rfile_25 or
	  gpr_rfile_26 or
	  gpr_rfile_27 or
	  gpr_rfile_28 or gpr_rfile_29 or gpr_rfile_30 or gpr_rfile_31)
  begin
    case (sub3_fullRegIndex)
      5'd0: sub3 = 32'd0;
      5'd1: sub3 = gpr_rfile_1;
      5'd2: sub3 = gpr_rfile_2;
      5'd3: sub3 = gpr_rfile_3;
      5'd4: sub3 = gpr_rfile_4;
      5'd5: sub3 = gpr_rfile_5;
      5'd6: sub3 = gpr_rfile_6;
      5'd7: sub3 = gpr_rfile_7;
      5'd8: sub3 = gpr_rfile_8;
      5'd9: sub3 = gpr_rfile_9;
      5'd10: sub3 = gpr_rfile_10;
      5'd11: sub3 = gpr_rfile_11;
      5'd12: sub3 = gpr_rfile_12;
      5'd13: sub3 = gpr_rfile_13;
      5'd14: sub3 = gpr_rfile_14;
      5'd15: sub3 = gpr_rfile_15;
      5'd16: sub3 = gpr_rfile_16;
      5'd17: sub3 = gpr_rfile_17;
      5'd18: sub3 = gpr_rfile_18;
      5'd19: sub3 = gpr_rfile_19;
      5'd20: sub3 = gpr_rfile_20;
      5'd21: sub3 = gpr_rfile_21;
      5'd22: sub3 = gpr_rfile_22;
      5'd23: sub3 = gpr_rfile_23;
      5'd24: sub3 = gpr_rfile_24;
      5'd25: sub3 = gpr_rfile_25;
      5'd26: sub3 = gpr_rfile_26;
      5'd27: sub3 = gpr_rfile_27;
      5'd28: sub3 = gpr_rfile_28;
      5'd29: sub3 = gpr_rfile_29;
      5'd30: sub3 = gpr_rfile_30;
      5'd31: sub3 = gpr_rfile_31;
    endcase
  end
  assign RDY_sub3 = 1'd1 ;

  // register gpr_rfile_0
  assign gpr_rfile_0$D_IN = upd_data ;
  assign gpr_rfile_0$EN = 1'b0 ;

  // register gpr_rfile_1
  assign gpr_rfile_1$D_IN = upd_data ;
  assign gpr_rfile_1$EN = EN_upd && upd_fullRegIndex == 5'd1 ;

  // register gpr_rfile_10
  assign gpr_rfile_10$D_IN = upd_data ;
  assign gpr_rfile_10$EN = EN_upd && upd_fullRegIndex == 5'd10 ;

  // register gpr_rfile_11
  assign gpr_rfile_11$D_IN = upd_data ;
  assign gpr_rfile_11$EN = EN_upd && upd_fullRegIndex == 5'd11 ;

  // register gpr_rfile_12
  assign gpr_rfile_12$D_IN = upd_data ;
  assign gpr_rfile_12$EN = EN_upd && upd_fullRegIndex == 5'd12 ;

  // register gpr_rfile_13
  assign gpr_rfile_13$D_IN = upd_data ;
  assign gpr_rfile_13$EN = EN_upd && upd_fullRegIndex == 5'd13 ;

  // register gpr_rfile_14
  assign gpr_rfile_14$D_IN = upd_data ;
  assign gpr_rfile_14$EN = EN_upd && upd_fullRegIndex == 5'd14 ;

  // register gpr_rfile_15
  assign gpr_rfile_15$D_IN = upd_data ;
  assign gpr_rfile_15$EN = EN_upd && upd_fullRegIndex == 5'd15 ;

  // register gpr_rfile_16
  assign gpr_rfile_16$D_IN = upd_data ;
  assign gpr_rfile_16$EN = EN_upd && upd_fullRegIndex == 5'd16 ;

  // register gpr_rfile_17
  assign gpr_rfile_17$D_IN = upd_data ;
  assign gpr_rfile_17$EN = EN_upd && upd_fullRegIndex == 5'd17 ;

  // register gpr_rfile_18
  assign gpr_rfile_18$D_IN = upd_data ;
  assign gpr_rfile_18$EN = EN_upd && upd_fullRegIndex == 5'd18 ;

  // register gpr_rfile_19
  assign gpr_rfile_19$D_IN = upd_data ;
  assign gpr_rfile_19$EN = EN_upd && upd_fullRegIndex == 5'd19 ;

  // register gpr_rfile_2
  assign gpr_rfile_2$D_IN = upd_data ;
  assign gpr_rfile_2$EN = EN_upd && upd_fullRegIndex == 5'd2 ;

  // register gpr_rfile_20
  assign gpr_rfile_20$D_IN = upd_data ;
  assign gpr_rfile_20$EN = EN_upd && upd_fullRegIndex == 5'd20 ;

  // register gpr_rfile_21
  assign gpr_rfile_21$D_IN = upd_data ;
  assign gpr_rfile_21$EN = EN_upd && upd_fullRegIndex == 5'd21 ;

  // register gpr_rfile_22
  assign gpr_rfile_22$D_IN = upd_data ;
  assign gpr_rfile_22$EN = EN_upd && upd_fullRegIndex == 5'd22 ;

  // register gpr_rfile_23
  assign gpr_rfile_23$D_IN = upd_data ;
  assign gpr_rfile_23$EN = EN_upd && upd_fullRegIndex == 5'd23 ;

  // register gpr_rfile_24
  assign gpr_rfile_24$D_IN = upd_data ;
  assign gpr_rfile_24$EN = EN_upd && upd_fullRegIndex == 5'd24 ;

  // register gpr_rfile_25
  assign gpr_rfile_25$D_IN = upd_data ;
  assign gpr_rfile_25$EN = EN_upd && upd_fullRegIndex == 5'd25 ;

  // register gpr_rfile_26
  assign gpr_rfile_26$D_IN = upd_data ;
  assign gpr_rfile_26$EN = EN_upd && upd_fullRegIndex == 5'd26 ;

  // register gpr_rfile_27
  assign gpr_rfile_27$D_IN = upd_data ;
  assign gpr_rfile_27$EN = EN_upd && upd_fullRegIndex == 5'd27 ;

  // register gpr_rfile_28
  assign gpr_rfile_28$D_IN = upd_data ;
  assign gpr_rfile_28$EN = EN_upd && upd_fullRegIndex == 5'd28 ;

  // register gpr_rfile_29
  assign gpr_rfile_29$D_IN = upd_data ;
  assign gpr_rfile_29$EN = EN_upd && upd_fullRegIndex == 5'd29 ;

  // register gpr_rfile_3
  assign gpr_rfile_3$D_IN = upd_data ;
  assign gpr_rfile_3$EN = EN_upd && upd_fullRegIndex == 5'd3 ;

  // register gpr_rfile_30
  assign gpr_rfile_30$D_IN = upd_data ;
  assign gpr_rfile_30$EN = EN_upd && upd_fullRegIndex == 5'd30 ;

  // register gpr_rfile_31
  assign gpr_rfile_31$D_IN = upd_data ;
  assign gpr_rfile_31$EN = EN_upd && upd_fullRegIndex == 5'd31 ;

  // register gpr_rfile_4
  assign gpr_rfile_4$D_IN = upd_data ;
  assign gpr_rfile_4$EN = EN_upd && upd_fullRegIndex == 5'd4 ;

  // register gpr_rfile_5
  assign gpr_rfile_5$D_IN = upd_data ;
  assign gpr_rfile_5$EN = EN_upd && upd_fullRegIndex == 5'd5 ;

  // register gpr_rfile_6
  assign gpr_rfile_6$D_IN = upd_data ;
  assign gpr_rfile_6$EN = EN_upd && upd_fullRegIndex == 5'd6 ;

  // register gpr_rfile_7
  assign gpr_rfile_7$D_IN = upd_data ;
  assign gpr_rfile_7$EN = EN_upd && upd_fullRegIndex == 5'd7 ;

  // register gpr_rfile_8
  assign gpr_rfile_8$D_IN = upd_data ;
  assign gpr_rfile_8$EN = EN_upd && upd_fullRegIndex == 5'd8 ;

  // register gpr_rfile_9
  assign gpr_rfile_9$D_IN = upd_data ;
  assign gpr_rfile_9$EN = EN_upd && upd_fullRegIndex == 5'd9 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        gpr_rfile_0 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_1 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_10 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_11 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_12 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_13 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_14 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_15 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_16 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_17 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_18 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_19 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_2 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_20 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_21 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_22 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_23 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_24 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_25 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_26 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_27 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_28 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_29 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_3 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_30 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_31 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_4 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_5 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_6 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_7 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_8 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	gpr_rfile_9 <= `BSV_ASSIGNMENT_DELAY 32'd0;
      end
    else
      begin
        if (gpr_rfile_0$EN)
	  gpr_rfile_0 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_0$D_IN;
	if (gpr_rfile_1$EN)
	  gpr_rfile_1 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_1$D_IN;
	if (gpr_rfile_10$EN)
	  gpr_rfile_10 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_10$D_IN;
	if (gpr_rfile_11$EN)
	  gpr_rfile_11 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_11$D_IN;
	if (gpr_rfile_12$EN)
	  gpr_rfile_12 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_12$D_IN;
	if (gpr_rfile_13$EN)
	  gpr_rfile_13 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_13$D_IN;
	if (gpr_rfile_14$EN)
	  gpr_rfile_14 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_14$D_IN;
	if (gpr_rfile_15$EN)
	  gpr_rfile_15 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_15$D_IN;
	if (gpr_rfile_16$EN)
	  gpr_rfile_16 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_16$D_IN;
	if (gpr_rfile_17$EN)
	  gpr_rfile_17 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_17$D_IN;
	if (gpr_rfile_18$EN)
	  gpr_rfile_18 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_18$D_IN;
	if (gpr_rfile_19$EN)
	  gpr_rfile_19 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_19$D_IN;
	if (gpr_rfile_2$EN)
	  gpr_rfile_2 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_2$D_IN;
	if (gpr_rfile_20$EN)
	  gpr_rfile_20 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_20$D_IN;
	if (gpr_rfile_21$EN)
	  gpr_rfile_21 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_21$D_IN;
	if (gpr_rfile_22$EN)
	  gpr_rfile_22 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_22$D_IN;
	if (gpr_rfile_23$EN)
	  gpr_rfile_23 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_23$D_IN;
	if (gpr_rfile_24$EN)
	  gpr_rfile_24 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_24$D_IN;
	if (gpr_rfile_25$EN)
	  gpr_rfile_25 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_25$D_IN;
	if (gpr_rfile_26$EN)
	  gpr_rfile_26 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_26$D_IN;
	if (gpr_rfile_27$EN)
	  gpr_rfile_27 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_27$D_IN;
	if (gpr_rfile_28$EN)
	  gpr_rfile_28 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_28$D_IN;
	if (gpr_rfile_29$EN)
	  gpr_rfile_29 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_29$D_IN;
	if (gpr_rfile_3$EN)
	  gpr_rfile_3 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_3$D_IN;
	if (gpr_rfile_30$EN)
	  gpr_rfile_30 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_30$D_IN;
	if (gpr_rfile_31$EN)
	  gpr_rfile_31 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_31$D_IN;
	if (gpr_rfile_4$EN)
	  gpr_rfile_4 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_4$D_IN;
	if (gpr_rfile_5$EN)
	  gpr_rfile_5 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_5$D_IN;
	if (gpr_rfile_6$EN)
	  gpr_rfile_6 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_6$D_IN;
	if (gpr_rfile_7$EN)
	  gpr_rfile_7 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_7$D_IN;
	if (gpr_rfile_8$EN)
	  gpr_rfile_8 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_8$D_IN;
	if (gpr_rfile_9$EN)
	  gpr_rfile_9 <= `BSV_ASSIGNMENT_DELAY gpr_rfile_9$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    gpr_rfile_0 = 32'hAAAAAAAA;
    gpr_rfile_1 = 32'hAAAAAAAA;
    gpr_rfile_10 = 32'hAAAAAAAA;
    gpr_rfile_11 = 32'hAAAAAAAA;
    gpr_rfile_12 = 32'hAAAAAAAA;
    gpr_rfile_13 = 32'hAAAAAAAA;
    gpr_rfile_14 = 32'hAAAAAAAA;
    gpr_rfile_15 = 32'hAAAAAAAA;
    gpr_rfile_16 = 32'hAAAAAAAA;
    gpr_rfile_17 = 32'hAAAAAAAA;
    gpr_rfile_18 = 32'hAAAAAAAA;
    gpr_rfile_19 = 32'hAAAAAAAA;
    gpr_rfile_2 = 32'hAAAAAAAA;
    gpr_rfile_20 = 32'hAAAAAAAA;
    gpr_rfile_21 = 32'hAAAAAAAA;
    gpr_rfile_22 = 32'hAAAAAAAA;
    gpr_rfile_23 = 32'hAAAAAAAA;
    gpr_rfile_24 = 32'hAAAAAAAA;
    gpr_rfile_25 = 32'hAAAAAAAA;
    gpr_rfile_26 = 32'hAAAAAAAA;
    gpr_rfile_27 = 32'hAAAAAAAA;
    gpr_rfile_28 = 32'hAAAAAAAA;
    gpr_rfile_29 = 32'hAAAAAAAA;
    gpr_rfile_3 = 32'hAAAAAAAA;
    gpr_rfile_30 = 32'hAAAAAAAA;
    gpr_rfile_31 = 32'hAAAAAAAA;
    gpr_rfile_4 = 32'hAAAAAAAA;
    gpr_rfile_5 = 32'hAAAAAAAA;
    gpr_rfile_6 = 32'hAAAAAAAA;
    gpr_rfile_7 = 32'hAAAAAAAA;
    gpr_rfile_8 = 32'hAAAAAAAA;
    gpr_rfile_9 = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkArchRFile

