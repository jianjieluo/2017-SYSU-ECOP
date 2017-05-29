`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/23 14:07:10
// Design Name:
// Module Name: PCShift
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


module PCShift(
    input [31:0] curPC,
    input PCSrc,
    input [31:0] shiftline_num,

    output reg [31:0] nextPC
    );

    always @ ( curPC or PCSrc or shiftline_num ) begin
        nextPC = curPC + 4;
        if (PCSrc)
            nextPC = nextPC + {shiftline_num[29:0], 2'b00};
    end
endmodule
