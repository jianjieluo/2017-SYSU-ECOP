`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/20 11:31:55
// Design Name:
// Module Name: PC
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


module PC( clk, rst, PCWre, nextPC, shiftline_num, pc, pc4, shiftNextPC);
    input clk, rst, PCWre;
    input [31:0] nextPC;
    input [31:0] shiftline_num;

    output wire [31:0] pc;
    output reg [31:0] pc4;
    output reg [31:0] shiftNextPC;

    reg [31:0] curPC;

    assign pc = curPC;

    always@( posedge clk) begin
        if( rst == 0 ) curPC = 0;
        else begin
            if (PCWre) curPC = nextPC;
        end
    end

    always@(curPC) begin
        pc4 = curPC + 4;
    end

    always @ ( shiftline_num ) begin
        shiftNextPC = pc4 + {shiftline_num[29:0], 2'b00};
    end

endmodule
