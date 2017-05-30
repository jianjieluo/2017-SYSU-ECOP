`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/22 12:03:52
// Design Name:
// Module Name: Opdecoder
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


module Opdecoder(
    input [31:0] inst,
    output wire [5:0] opcode,
    output wire [4:0] rs,
    output wire [4:0] rt,
    output wire [4:0] rd,
    output wire [4:0] sa,
    output wire [15:0] immed,
    output wire [25:0] addr
    );

    assign opcode = inst[31:26];
    assign rs = inst[25:21];
    assign rt = inst[20:16];
    assign rd = inst[15:11];
    assign sa = inst[10:6];
    assign immed = inst[15:0];
    assign addr = inst[25:0];
endmodule
