`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/05/18 16:03:52
// Design Name:
// Module Name: Mux_FourtoOne32
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


module Mux_FourtoOne32(sel, in0, in1, in2, in3, out);

    input [1:0] sel;
    input [31:0] in0;
    input [31:0] in1;
    input [31:0] in2;
    input [31:0] in3;
    output reg [31:0] out;

    always @ ( * ) begin
        case (sel)
            2'b00: out = in0;
            2'b01: begin
                out = in1;
                $display("in1: %b", in1);
            end
            2'b10: out = in2;
            2'b11: begin
                out = in3;
               // $display("in3: %b", in3);
            end
            default: begin
                $display("sel:%b :case wrong in Mux_FourtoOne32!", sel);
            end
        endcase
    end
endmodule
