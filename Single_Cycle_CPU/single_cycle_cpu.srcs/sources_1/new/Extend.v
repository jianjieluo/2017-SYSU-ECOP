`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/22 10:38:52
// Design Name:
// Module Name: Extend
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

// finished

module Extend(
    input ExtSel,
    input [15:0] imm_16,
    output [31:0] imm_32
    );
    assign imm_32 = (ExtSel && imm_16[15] == 1) ? {16'hffff, imm_16} : {16'h0000, imm_16};
endmodule
