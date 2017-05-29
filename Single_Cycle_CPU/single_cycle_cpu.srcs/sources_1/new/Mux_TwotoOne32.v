`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/20 12:04:18
// Design Name:
// Module Name: Mux_TwotoOne
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module Mux_TwotoOne32(sel, in1, in2, out);
	input  sel;
	input  [31:0]  in1;
	input  [31:0]  in2;
	output [31:0]  out;

	assign out = (sel) ? in2 : in1;
endmodule
