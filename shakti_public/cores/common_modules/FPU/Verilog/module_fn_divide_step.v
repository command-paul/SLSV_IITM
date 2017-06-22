//
// Generated by Bluespec Compiler, version 2014.07.A (build 34078, 2014-07-30)
//
// On Fri Jan 22 01:17:40 IST 2016
//
//
// Ports:
// Name                         I/O  size props
// fn_divide_step                 O   170
// fn_divide_step_denominator     I    56
// fn_divide_step_quotient_and_remainder  I   114
//
// Combinational paths from inputs to outputs:
//   (fn_divide_step_denominator,
//    fn_divide_step_quotient_and_remainder) -> fn_divide_step
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

module module_fn_divide_step(fn_divide_step_denominator,
			     fn_divide_step_quotient_and_remainder,
			     fn_divide_step);
  // value method fn_divide_step
  input  [55 : 0] fn_divide_step_denominator;
  input  [113 : 0] fn_divide_step_quotient_and_remainder;
  output [169 : 0] fn_divide_step;

  // signals for module outputs
  wire [169 : 0] fn_divide_step;

  // remaining internal signals
  wire [113 : 0] temp___1__h18;
  wire [56 : 0] IF_fn_divide_step_quotient_and_remainder_BITS__ETC___d10,
		IF_fn_divide_step_quotient_and_remainder_BITS__ETC__q1,
		x__h15,
		y__h17;
  wire IF_fn_divide_step_quotient_and_remainder_BITS__ETC___d11,
       fn_divide_step_quotient_and_remainder_BITS_56__ETC___d4;

  // value method fn_divide_step
  assign fn_divide_step = { fn_divide_step_denominator, temp___1__h18 } ;

  // remaining internal signals
  assign IF_fn_divide_step_quotient_and_remainder_BITS__ETC___d10 =
	     { IF_fn_divide_step_quotient_and_remainder_BITS__ETC__q1[55:0],
	       1'd0 } ;
  assign IF_fn_divide_step_quotient_and_remainder_BITS__ETC___d11 =
	     IF_fn_divide_step_quotient_and_remainder_BITS__ETC___d10 <
	     { 1'b0, fn_divide_step_denominator } ;
  assign IF_fn_divide_step_quotient_and_remainder_BITS__ETC__q1 =
	     fn_divide_step_quotient_and_remainder_BITS_56__ETC___d4 ?
	       fn_divide_step_quotient_and_remainder[56:0] :
	       x__h15 ;
  assign fn_divide_step_quotient_and_remainder_BITS_56__ETC___d4 =
	     fn_divide_step_quotient_and_remainder[56:0] <
	     { 1'b0, fn_divide_step_denominator } ;
  assign temp___1__h18 =
	     { fn_divide_step_quotient_and_remainder[111:58],
	       !fn_divide_step_quotient_and_remainder_BITS_56__ETC___d4,
	       !IF_fn_divide_step_quotient_and_remainder_BITS__ETC___d11,
	       IF_fn_divide_step_quotient_and_remainder_BITS__ETC___d11 ?
		 IF_fn_divide_step_quotient_and_remainder_BITS__ETC___d10 :
		 y__h17,
	       1'd0 } ;
  assign x__h15 =
	     fn_divide_step_quotient_and_remainder[56:0] -
	     { 1'b0, fn_divide_step_denominator } ;
  assign y__h17 =
	     IF_fn_divide_step_quotient_and_remainder_BITS__ETC___d10 -
	     { 1'b0, fn_divide_step_denominator } ;
endmodule  // module_fn_divide_step
