`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/05/20 03:06:35
// Design Name:
// Module Name: NextState
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


module NextState(
    input [2:0] currState,
    input [5:0] op,
    output reg[2:0] nextState
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

    parameter [2:0] IF = 3'b000, // IF状�??
                         ID = 3'b001, // ID状�??
                         EXE1 = 3'b110, // add等指令的EXE状�??
                         EXE2 = 3'b101, // beq指令的EXE状�??
                         EXE3 = 3'b010, // sw，lw指令的EXE状�??
                         MEM = 3'b011, // MEM状�??
                         WB1 = 3'b111, //add等指令的WB状�??
                         WB3 = 3'b100; // lw指令的WB状�??

    initial begin
        nextState = IF;
    end

    always @ ( * ) begin
        if (currState == IF) nextState = ID;
        else if (currState == ID && (add | sub | addi | or_ | and_ | ori | slt | slti | sll)) nextState = EXE1;
        else if (currState == ID && beq) nextState = EXE2;
        else if (currState == ID && (sw | lw)) nextState = EXE3;
        else if (currState == ID && (j | jal | jr | halt)) nextState = IF;
        else if (currState == EXE1) nextState = WB1;
        else if (currState == EXE2) nextState = IF;
        else if (currState == EXE3) nextState = MEM;
        else if (currState == WB1) nextState = IF;
        else if (currState == MEM && lw) nextState = WB3;
        else if (currState == MEM && sw ) nextState = IF;
        else if (currState == WB3) nextState = IF;
    end
endmodule
