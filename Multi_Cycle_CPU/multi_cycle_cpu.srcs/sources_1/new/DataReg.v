`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/05/18 17:59:36
// Design Name:
// Module Name: DataReg
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


module DataReg(clk, in, out);
  input clk;
  input [31:0] in;
  output reg[31:0] out;
  
  always @(posedge clk) begin
    out = in;
  end
endmodule
