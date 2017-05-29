`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/21 20:37:20
// Design Name:
// Module Name: InstructionMemory
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


module InstructionMemory(
    input [31:0] Iaddr,
    input RW,
    output [31:0] IDataOut
    );

    reg [7:0] mem[50:0];

    initial begin
      $readmemb("C:/Users/longj/Desktop/vivado/VivadoProject/single_cycle_cpu/memFile.txt", mem);
    end
    // RW �?0的时候开始构建新的指�?
    assign IDataOut = (RW) ? 0 : {mem[Iaddr], mem[Iaddr+1], mem[Iaddr+2], mem[Iaddr+3]};
endmodule
