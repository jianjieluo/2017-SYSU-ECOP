`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/23 09:42:45
// Design Name:
// Module Name: Mux_TwotoOne5
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


module Mux_TwotoOne5(sel, in1, in2, out);
	input  sel;
	input  [4:0]  in1;
	input  [4:0]  in2;
	output [4:0]  out;

	assign out = (sel) ? in2 : in1;
endmodule
