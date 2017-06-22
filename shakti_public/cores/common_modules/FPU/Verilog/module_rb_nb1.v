//
// Generated by Bluespec Compiler, version 2014.07.A (build 34078, 2014-07-30)
//
// On Fri Jan 22 01:17:47 IST 2016
//
//
// Ports:
// Name                         I/O  size props
// rb_nb1                         O    17
// rb_nb1_rb                      I   128
//
// Combinational paths from inputs to outputs:
//   rb_nb1_rb -> rb_nb1
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

module module_rb_nb1(rb_nb1_rb,
		     rb_nb1);
  // value method rb_nb1
  input  [127 : 0] rb_nb1_rb;
  output [16 : 0] rb_nb1;

  // signals for module outputs
  wire [16 : 0] rb_nb1;

  // remaining internal signals
  wire [15 : 0] IF_c_z_mux_3_BIT_1_THEN_1_ELSE_0__q1, _theResult___fst__h25;
  wire [3 : 0] c_z_mux_9_BIT_1_6_CONCAT_c_z_mux_7_BIT_1_7_CON_ETC___d83;
  wire [1 : 0] c_z_mux___d33,
	       c_z_mux___d35,
	       c_z_mux___d37,
	       c_z_mux___d39,
	       c_z_mux___d41,
	       c_z_mux___d43,
	       c_z_mux___d45,
	       c_z_mux___d47,
	       c_z_mux___d49,
	       c_z_mux___d51,
	       c_z_mux___d53,
	       c_z_mux___d55,
	       c_z_mux___d57,
	       c_z_mux___d59,
	       c_z_mux___d61,
	       c_z_mux___d63;

  // value method rb_nb1
  assign rb_nb1 = { _theResult___fst__h25, c_z_mux___d63[0] } ;

  // remaining internal signals
  module_c_z_mux instance_c_z_mux_1(.c_z_mux_fp(rb_nb1_rb[64]),
				    .c_z_mux_fm(rb_nb1_rb[0]),
				    .c_z_mux_cp(1'd1),
				    .c_z_mux(c_z_mux___d33));
  module_c_z_mux instance_c_z_mux_0(.c_z_mux_fp(rb_nb1_rb[65]),
				    .c_z_mux_fm(rb_nb1_rb[1]),
				    .c_z_mux_cp(c_z_mux___d33[0]),
				    .c_z_mux(c_z_mux___d35));
  module_c_z_mux instance_c_z_mux_2(.c_z_mux_fp(rb_nb1_rb[66]),
				    .c_z_mux_fm(rb_nb1_rb[2]),
				    .c_z_mux_cp(c_z_mux___d35[0]),
				    .c_z_mux(c_z_mux___d37));
  module_c_z_mux instance_c_z_mux_3(.c_z_mux_fp(rb_nb1_rb[67]),
				    .c_z_mux_fm(rb_nb1_rb[3]),
				    .c_z_mux_cp(c_z_mux___d37[0]),
				    .c_z_mux(c_z_mux___d39));
  module_c_z_mux instance_c_z_mux_4(.c_z_mux_fp(rb_nb1_rb[68]),
				    .c_z_mux_fm(rb_nb1_rb[4]),
				    .c_z_mux_cp(c_z_mux___d39[0]),
				    .c_z_mux(c_z_mux___d41));
  module_c_z_mux instance_c_z_mux_5(.c_z_mux_fp(rb_nb1_rb[69]),
				    .c_z_mux_fm(rb_nb1_rb[5]),
				    .c_z_mux_cp(c_z_mux___d41[0]),
				    .c_z_mux(c_z_mux___d43));
  module_c_z_mux instance_c_z_mux_6(.c_z_mux_fp(rb_nb1_rb[70]),
				    .c_z_mux_fm(rb_nb1_rb[6]),
				    .c_z_mux_cp(c_z_mux___d43[0]),
				    .c_z_mux(c_z_mux___d45));
  module_c_z_mux instance_c_z_mux_7(.c_z_mux_fp(rb_nb1_rb[71]),
				    .c_z_mux_fm(rb_nb1_rb[7]),
				    .c_z_mux_cp(c_z_mux___d45[0]),
				    .c_z_mux(c_z_mux___d47));
  module_c_z_mux instance_c_z_mux_8(.c_z_mux_fp(rb_nb1_rb[72]),
				    .c_z_mux_fm(rb_nb1_rb[8]),
				    .c_z_mux_cp(c_z_mux___d47[0]),
				    .c_z_mux(c_z_mux___d49));
  module_c_z_mux instance_c_z_mux_9(.c_z_mux_fp(rb_nb1_rb[73]),
				    .c_z_mux_fm(rb_nb1_rb[9]),
				    .c_z_mux_cp(c_z_mux___d49[0]),
				    .c_z_mux(c_z_mux___d51));
  module_c_z_mux instance_c_z_mux_10(.c_z_mux_fp(rb_nb1_rb[74]),
				     .c_z_mux_fm(rb_nb1_rb[10]),
				     .c_z_mux_cp(c_z_mux___d51[0]),
				     .c_z_mux(c_z_mux___d53));
  module_c_z_mux instance_c_z_mux_11(.c_z_mux_fp(rb_nb1_rb[75]),
				     .c_z_mux_fm(rb_nb1_rb[11]),
				     .c_z_mux_cp(c_z_mux___d53[0]),
				     .c_z_mux(c_z_mux___d55));
  module_c_z_mux instance_c_z_mux_12(.c_z_mux_fp(rb_nb1_rb[76]),
				     .c_z_mux_fm(rb_nb1_rb[12]),
				     .c_z_mux_cp(c_z_mux___d55[0]),
				     .c_z_mux(c_z_mux___d57));
  module_c_z_mux instance_c_z_mux_13(.c_z_mux_fp(rb_nb1_rb[77]),
				     .c_z_mux_fm(rb_nb1_rb[13]),
				     .c_z_mux_cp(c_z_mux___d57[0]),
				     .c_z_mux(c_z_mux___d59));
  module_c_z_mux instance_c_z_mux_14(.c_z_mux_fp(rb_nb1_rb[78]),
				     .c_z_mux_fm(rb_nb1_rb[14]),
				     .c_z_mux_cp(c_z_mux___d59[0]),
				     .c_z_mux(c_z_mux___d61));
  module_c_z_mux instance_c_z_mux_15(.c_z_mux_fp(rb_nb1_rb[79]),
				     .c_z_mux_fm(rb_nb1_rb[15]),
				     .c_z_mux_cp(c_z_mux___d61[0]),
				     .c_z_mux(c_z_mux___d63));
  assign IF_c_z_mux_3_BIT_1_THEN_1_ELSE_0__q1 =
	     c_z_mux___d33[1] ? 16'd1 : 16'd0 ;
  assign _theResult___fst__h25 =
	     { c_z_mux___d63[1],
	       c_z_mux___d61[1],
	       c_z_mux___d59[1],
	       c_z_mux___d57[1],
	       c_z_mux___d55[1],
	       c_z_mux___d53[1],
	       c_z_mux___d51[1],
	       c_z_mux___d49[1],
	       c_z_mux___d47[1],
	       c_z_mux___d45[1],
	       c_z_mux___d43[1],
	       c_z_mux___d41[1],
	       c_z_mux_9_BIT_1_6_CONCAT_c_z_mux_7_BIT_1_7_CON_ETC___d83 } ;
  assign c_z_mux_9_BIT_1_6_CONCAT_c_z_mux_7_BIT_1_7_CON_ETC___d83 =
	     { c_z_mux___d39[1],
	       c_z_mux___d37[1],
	       c_z_mux___d35[1],
	       IF_c_z_mux_3_BIT_1_THEN_1_ELSE_0__q1[0] } ;
endmodule  // module_rb_nb1
