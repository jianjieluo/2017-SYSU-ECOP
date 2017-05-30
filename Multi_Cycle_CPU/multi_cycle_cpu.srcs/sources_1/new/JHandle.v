`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/05/22 07:47:43
// Design Name:
// Module Name: JHandle
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


module JHandle(
    input [25:0] in_addr,
    input [31:0] pc4,

    output [31:0] out_addr
    );

    assign out_addr = {pc4[31:28],in_addr[25:0],2'b00};
endmodule
