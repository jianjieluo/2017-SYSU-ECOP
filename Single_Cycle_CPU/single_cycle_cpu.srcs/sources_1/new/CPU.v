`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/04/23 10:13:27
// Design Name:
// Module Name: CPU
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


module CPU(
    input clk,
    input reset,
    output [31:0] curpc,
    output [31:0] inst,
    output zero,
    output PCWre, ALUSrcA, ALUSrcB, ALUM2Reg, RegWre, InsMemRW, DataMemRW, ExtSel, PCSrc, RegOut, RegDst,
    output [2:0] ALUop,
    output [31:0] ALUout
    );
    
    wire [5:0] op;

    ControlUnit cu(
        .zero(zero),
        .op(op),

        .ExtSel(ExtSel),
        .PCWre(),
        .InsMemRw(InsMemRw),
        .RegDst(RegDst),
        .RegWre(RegWre),
        .ALUOp(ALUop),
        .ALUSrcB(ALUSrcB),
        .ALUSrcA(ALUSrcA),
        .PCSrc(PCSrc),
        .RD(),
        .WR(),
        .DBDataSrc()
        );

    PC pc(
        .clk(clk),
        .reset(reset),
        .PCWre(cu.PCWre),
        .nextPC(pcs.nextPC),

        .curPC(curpc)
        );

    PCShift pcs(
        .curPC(pc.curPC),
        .PCSrc(cu.PCSrc),
        .shiftline_num(extend.imm_32),

        .nextPC()
        );

    InstructionMemory instmem(
        .Iaddr(pc.curPC),
        .RW(cu.InsMemRw),

        .IDataOut(inst)
        );

    Extend extend(
        .ExtSel(cu.ExtSel),
        .imm_16(opdecoder.immed),

        .imm_32()
        );

    Regfile regfile(
        .clk(clk),
        .WE(cu.RegWre),
        .RdReg1addr(opdecoder.rs),
        .RdReg2addr(opdecoder.rt),
        .WrRegaddr(rt_rd_selector.out),
        .inData(res_dataout_selector.out),

        .reg1dataOut(),
        .reg2dataOut()
        );

    Mux_TwotoOne5 rt_rd_selector(
        .sel(cu.RegDst),
        .in1(opdecoder.rt),
        .in2(opdecoder.rd),

        .out()
        );

    Opdecoder opdecoder(
        .inst(instmem.IDataOut),

        .opcode(op),
        .rs(),
        .rt(),
        .rd(),
        .sa(),
        .immed(),
        .addr()
        );

    ALU32 alu(
        .ALUopcode(cu.ALUOp),
        .rega(data1_sa_selector.out),
        .regb(data2_exi_selector.out),

        .result(),
        .zero(zero)
        );

    DataMemory datamem(
        .clk(clk),
        .DAddr(alu.result),
        .RD(cu.RD),
        .WR(cu.WR),
        .DataIn(regfile.reg2dataOut),

        .DataOut()
        );

    // double imm_32 for the shift ammount of sw or lw command
    LeftShift2 doubleHandler(
        .DoubleEn(cu.DBDataSrc),
        .in_32(extend.imm_32),

        .out_32()
        );

    Mux_TwotoOne32 data1_sa_selector(
        .sel(cu.ALUSrcA),
        .in1(regfile.reg1dataOut),
        .in2({27'b0, opdecoder.sa}),

        .out()
        );
    Mux_TwotoOne32 data2_exi_selector(
        .sel(cu.ALUSrcB),
        .in1(regfile.reg2dataOut),
        // export the extend.imm_32 through the doubleHandler,
        // if the command is sw or lw, than the imm_32 need to be doubled.
        // .in2(extend.imm_32),
        .in2(doubleHandler.out_32),

        .out()
        );
    Mux_TwotoOne32 res_dataout_selector(
        .sel(cu.DBDataSrc),
        .in1(alu.result),
        .in2(datamem.DataOut),

        .out()
        );

endmodule
