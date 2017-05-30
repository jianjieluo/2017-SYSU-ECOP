`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/05/20 03:03:55
// Design Name:
// Module Name: D3
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


module D3(
    input rst,
    input clk,
    input [2:0] in,
    output reg[2:0] out
    );

    always @ ( posedge clk ) begin
        if (rst) out = in;
        else out = 3'b000;
    end
endmodule
