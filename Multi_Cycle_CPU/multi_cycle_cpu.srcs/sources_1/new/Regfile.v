`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/21 20:31:10
// Design Name:
// Module Name: Regfile
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


module Regfile(
    input clk,
    input WE,
    input [4:0] RdReg1addr,
    input [4:0] RdReg2addr,
    input [4:0] WrRegaddr,
    input [31:0] inData,

    output [31:0] reg1dataOut,
    output [31:0] reg2dataOut,
    output [31:0] reg32Out
    );
	reg [31:0] register [1:31];
    integer i;

	assign reg1dataOut = (RdReg1addr== 0)? 0 : register[RdReg1addr];
	assign reg2dataOut = (RdReg2addr== 0)? 0 : register[RdReg2addr];
    assign reg32Out = register[31];

    // The first time clean the registers
    initial begin
        for (i=0; i<32; i=i+1)
            register[i] = 0;
    end

	always @(negedge clk) begin
        if ((WrRegaddr != 0) && (WE == 1)) // if can write then write
            register[WrRegaddr] = inData;
	end

endmodule
