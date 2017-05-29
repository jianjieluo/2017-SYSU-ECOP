`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/22 10:12:39
// Design Name:
// Module Name: ControlUnit
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


module ControlUnit(
    input zero,
    input [5:0] op,
    output ExtSel,
    output PCWre,
    output wire InsMemRw,
    output RegDst,
    output RegWre,
    output reg [2:0] ALUOp,
    output ALUSrcB,
    output ALUSrcA,
    output PCSrc,
    output RD,
    output WR,
    // output DoubleEn,
    output DBDataSrc
    );


    // construct the fingerprint of all the commands
    wire add, addi, sub, ori, and_, or_, sll, sw, lw, beq, halt;
    assign add = ~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]; // add 000000
    assign addi = ~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0]; // addi 000001
    assign sub = ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0]; // sub 000010
    assign ori = ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]; // ori 010000
    assign and_ = ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & op[0]; // and 010001
    assign or_ = ~op[5] & op[4] & ~op[3] & ~op[2] & op[1] & ~op[0]; // or 010010
    assign sll = ~op[5] & op[4] & op[3] & ~op[2] & ~op[1] & ~op[0]; // sll 011000
    assign sw = op[5] & ~op[4] & ~op[3] & op[2] & op[1] & ~op[0]; // sw 100110
    assign lw = op[5] & ~op[4] & ~op[3] & op[2] & op[1] & op[0]; // lw 100111
    assign beq = op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]; // beq 110000
    assign halt = op[5] & op[4] & op[3] & op[2] & op[1] & op[0]; // halt 111111

    assign ExtSel = addi | sw | lw | beq;
    assign PCWre = ~halt;
    assign InsMemRw = 0;
    assign RegDst = add | sub | and_ | or_ | sll;
    assign RegWre = add | addi | sub | ori | and_ | or_ | sll | lw;
    assign ALUSrcA = sll;
    assign ALUSrcB = addi | ori | sw | lw;
    assign PCSrc = zero;
    // assign RD = sw;
    // assign WR = lw;
    assign RD = ~lw;
    assign WR = ~sw;
    // Found that DBDataSrc is the same as DoubleEn, so discard the DoubleEn
    assign DBDataSrc = sw | lw;

    always @ ( op ) begin
        case (op)
            6'b000000: ALUOp = 3'b000 ;
            6'b000001: ALUOp = 3'b000 ;
            6'b000010: ALUOp = 3'b001 ;
            6'b010000: ALUOp = 3'b100 ;
            6'b010001: ALUOp = 3'b101 ;
            6'b010010: ALUOp = 3'b100 ;
            6'b011000: ALUOp = 3'b011 ;
            6'b100110: ALUOp = 3'b000 ;
            6'b100111: ALUOp = 3'b000 ;
            6'b110000: ALUOp = 3'b001 ;
            6'b111111: ALUOp = 3'bzzz ;
            default: begin
                $display ("ControlUnit OpToALUOp no match");
            end
        endcase
    end

endmodule
