`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/05/21 12:17:17
// Design Name:
// Module Name: Mux_ThreetoOne5
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


module Mux_ThreetoOne5(sel, in0, in1, in2, out);

    input [1:0] sel;
    input [4:0] in0;
    input [4:0] in1;
    input [4:0] in2;
    output reg [4:0] out;

    always @ ( * ) begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            default: begin
                $display("case wrong in Mux_FourtoOne32!");
                out = 5'bzzzzz;
            end
        endcase
    end
endmodule
