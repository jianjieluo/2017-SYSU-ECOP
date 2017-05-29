`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/23 14:21:26
// Design Name:
// Module Name: singlecpu_sim
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


module singlecpu_sim( );
    reg clk;
    reg reset;
    wire [31:0] curpc;

    CPU uut(
        .clk(clk),
        .reset(reset),
        .curpc(curpc)
        );

    always #30 clk = !clk;
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
        // Wait 100 ns for global reset to finish
        #60 reset = 1;
    end
endmodule
