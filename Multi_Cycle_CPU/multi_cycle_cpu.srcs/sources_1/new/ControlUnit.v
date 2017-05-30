`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/05/20 05:40:23
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
    input clk,
    input rst,
    input [5:0] op,
    input zero,

    output [2:0] ALUOp,
    output PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRw,
    output RD, WR, IRWre, ExtSel,
    output [1:0] PCSrc,
    output [1:0] RegDst
    );

    wire [2:0] nextstate;
    wire [2:0] currestate;

    D3 dFlipFlop(
        .rst(rst),
        .clk(clk),
        .in(nextstate),

        .out(currestate)
        );

    NextState next(
        .currState(currestate),
        .op(op),

        .nextState(nextstate)
        );

    OutputFun outputFun(
        .op(op),
        .zero(zero),
        .currState(currestate),

        .ALUOp(ALUOp),
        .PCWre(PCWre),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .DBDataSrc(DBDataSrc),
        .RegWre(RegWre),
        .WrRegDSrc(WrRegDSrc),
        .InsMemRw(InsMemRw),
        .RD(RD),
        .WR(WR),
        .IRWre(IRWre),
        .ExtSel(ExtSel),
        .PCSrc(PCSrc),
        .RegDst(RegDst)
        );

endmodule
