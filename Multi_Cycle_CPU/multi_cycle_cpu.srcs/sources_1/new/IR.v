`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/05/18 17:30:24
// Design Name:
// Module Name: IR
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

module IR (clk, en, in, out);
    input clk;
    input en;
    input [31:0] in;
    output reg [31:0] out;

	always @ (negedge clk) begin
        if (en) out = in;
	end

endmodule
