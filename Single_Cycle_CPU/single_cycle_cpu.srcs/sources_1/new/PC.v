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


module PC( clk, reset, PCWre, nextPC, curPC);
    input  clk, reset, PCWre;
    input  [31:0] nextPC;
    output reg [31:0] curPC;



    always@( posedge clk ) begin
        if( reset == 0 )
            curPC = 0;
        else
            if (PCWre)
		        curPC = nextPC;
    end

endmodule
