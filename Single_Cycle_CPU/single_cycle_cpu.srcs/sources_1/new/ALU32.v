`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/20 11:28:10
// Design Name:
// Module Name: ALU32
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

// finished

module ALU32(
    input [2:0] ALUopcode,
    input [31:0] rega,
    input [31:0] regb,
    output reg [31:0] result,
    output zero
    );

    initial begin
        result = 32'b0;
    end

    assign zero = (result==0)?1:0;
    always @( ALUopcode or rega or regb ) begin
        case (ALUopcode)
            3'b000 : result = rega + regb;
            3'b001 : result = rega - regb;
            3'b010 : result = (rega < regb)?1:0;
            3'b011 : result = regb << rega;
            3'b100 : result = rega | regb;
            3'b101 : result = rega & regb;
            3'b110 : result = rega ^ regb;
            3'b111 : result = ~(rega ^ regb);
            default : begin
                result = 8'h00000000;
                $display ("ALUOp no match");
            end
        endcase
    end
endmodule
