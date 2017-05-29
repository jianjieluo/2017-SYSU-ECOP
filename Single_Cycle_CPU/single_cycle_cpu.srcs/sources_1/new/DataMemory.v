`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/21 21:05:50
// Design Name:
// Module Name: DataMemory
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


module DataMemory(
    input clk,
	input [31:0] DAddr,
	input RD,
	input WR,
	input [31:0] DataIn,
	output [31:0] DataOut
    );
    // The DataMemory is a RAM
    reg [7:0] RAM[0:60];

    // construct the DataOut
    assign DataOut[31:24] = (RD==1)?8'bz:RAM[DAddr];
    assign DataOut[23:16] = (RD==1)?8'bz:RAM[DAddr+1];
    assign DataOut[15:8] = (RD==1)?8'bz:RAM[DAddr+2];
    assign DataOut[7:0] = (RD==1)?8'bz:RAM[DAddr+3];

    always @ ( negedge clk ) begin
        if (WR==0) begin
            RAM[DAddr] <= DataIn[31:24];
            RAM[DAddr+1] <= DataIn[23:16];
            RAM[DAddr+2] <= DataIn[15:8];
            RAM[DAddr+3] <= DataIn[7:0];
        end
    end
endmodule
