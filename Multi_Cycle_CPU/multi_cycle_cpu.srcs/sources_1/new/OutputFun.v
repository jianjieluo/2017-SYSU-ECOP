`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/05/20 04:12:18
// Design Name:
// Module Name: OutputFun
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


module OutputFun(
    input [5:0] op,
    input zero,
    input [2:0] currState,

    output reg [2:0] ALUOp,
    output InsMemRw,
    output reg PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc,
    output reg RD, WR, IRWre, ExtSel,
    output reg [1:0] PCSrc,
    output reg [1:0] RegDst
    );

    wire add, sub, addi, or_, and_, ori, sll, slt, slti, sw, lw, beq, j, jr, jal, halt;

    assign add = ~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]; // 000000
    assign sub = ~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0]; // 000001
    assign addi = ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0]; // 000010
    assign or_ = ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]; // 010000
    assign and_ = ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & op[0]; // 010001
    assign ori = ~op[5] & op[4] & ~op[3] & ~op[2] & op[1] & ~op[0]; // 010010
    assign sll = ~op[5] & op[4] & op[3] & ~op[2] & ~op[1] & ~op[0]; // 011000
    assign slt = op[5] & ~op[4] & ~op[3] & op[2] & op[1] & ~op[0]; // 100110
    assign slti = op[5] & ~op[4] & ~op[3] & op[2] & op[1] & op[0]; // 100111
    assign sw = op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]; // 110000
    assign lw = op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & op[0]; //110001
    assign beq = op[5] & op[4] & ~op[3] & op[2] & ~op[1] & ~op[0]; // 110100
    assign j = op[5] & op[4] & op[3] & ~op[2] & ~op[1] & ~op[0]; // 111000
    assign jr = op[5] & op[4] & op[3] & ~op[2] & ~op[1] & op[0]; // 111001
    assign jal = op[5] & op[4] & op[3] & ~op[2] & op[1] & ~op[0]; //111010
    assign halt = op[5] & op[4] & op[3] & op[2] & op[1] & op[0]; //111111

    assign InsMemRw = 1;

    parameter [2:0] IF = 3'b000, // IF状�??
                          ID = 3'b001, // ID状�??
                          EXE1 = 3'b110, // add等指令的EXE状�??
                          EXE2 = 3'b101, // beq指令的EXE状�??
                          EXE3 = 3'b010, // sw，lw指令的EXE状�??
                          MEM = 3'b011, // MEM状�??
                          WB1 = 3'b111, //add等指令的WB状�??
                          WB2 = 3'b100; // lw指令的WB状�??

    always @ ( currState ) begin
        if (currState == WB1 || currState == WB2 || (currState == EXE2 && beq) || 
        (currState == MEM && sw) || (currState == ID && (j || jal || jr || halt))) begin
            PCWre = 1;
            if (halt) PCWre = 0;
        end
        else PCWre = 0;

        if (currState == EXE1 && sll) ALUSrcA = 1;
        else ALUSrcA = 0;

        if (currState == EXE1 || currState == EXE3) begin
            if (addi || slti || ori || lw || sw) ALUSrcB = 1;
            else ALUSrcB = 0;
        end
        else ALUSrcB = 0;

        if (currState == MEM && lw) DBDataSrc = 1;
        else DBDataSrc = 0;

        // Here is the question to deal with the jal
        if (currState == WB1 || currState == WB2 || (jal && currState == ID)) begin
            if (jal && currState == ID) begin
                WrRegDSrc = 0;
            end
            else WrRegDSrc = 1;

            if (beq || j || sw || jr || halt) RegWre = 0;
            else RegWre = 1;
        end
        else RegWre = 0;

        RD = (currState == MEM && lw) ? 0 : 1;
        WR = (currState == MEM && sw) ? 0 : 1;

        IRWre = (currState == IF) ? 1 : 0;

        ExtSel = (currState == ID && ori) ? 0 : 1;

        if (beq && zero == 1) PCSrc = 2'b01;
        else if (jr) PCSrc = 2'b10;
        else if (j || jal) PCSrc = 2'b11;
        else PCSrc = 2'b00;

        if (jal) RegDst = 2'b00;
        else if (addi || slti || ori || lw) RegDst = 2'b01;
        else if (add || sub || or_ || and_ || slt || sll) RegDst = 2'b10;
     end

     always @ ( op ) begin
         case (op)
             6'b000000: ALUOp = 3'b000 ;
             6'b000001: ALUOp = 3'b001 ;
             6'b000010: ALUOp = 3'b000 ;
             6'b010000: ALUOp = 3'b101 ;
             6'b010001: ALUOp = 3'b110 ;
             6'b010010: ALUOp = 3'b101 ;
             6'b011000: ALUOp = 3'b100 ;
             6'b100110: ALUOp = 3'b010 ;
             6'b100111: ALUOp = 3'b010 ;
             6'b110000: ALUOp = 3'b000 ;
             6'b110001: ALUOp = 3'b000 ;
             6'b110100: ALUOp = 3'b001 ;

             // 剩下的j jr jal halt 都不��?要用到ALU, 输出zzz
             default: begin
                 $display ("ControlUnit OpToALUOp no match Or Don't need to use ALU");
                 ALUOp = 3'bzzz;
             end
         endcase
     end



endmodule
