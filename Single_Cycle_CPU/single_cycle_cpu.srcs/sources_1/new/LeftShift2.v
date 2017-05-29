`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/24 01:41:01
// Design Name:
// Module Name: LeftShift2
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


module LeftShift2(
    input DoubleEn,
    input [31:0] in_32,
    output [31:0] out_32
    );

    assign out_32 = (DoubleEn) ? {in_32[29:0], 2'b00} : in_32;
endmodule
