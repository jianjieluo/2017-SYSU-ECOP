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
    input rst
    );

    PC pc(
        .clk(clk),
        .rst(rst),
        .PCWre(cu.PCWre),
        .nextPC(ps_selector.out),
        .shiftline_num(extend.imm_32),

        .pc(),
        .pc4(),
        .shiftNextPC()
        );

    JHandle jhandle(
        .in_addr(opdecoder.addr),
        .pc4(pc.pc4),

        .out_addr()
        );

    Mux_FourtoOne32 ps_selector(
        .sel(cu.PCSrc),
        .in0(pc.pc4),
        .in1(pc.shiftNextPC),
        .in2(regfile.reg1dataOut),
        .in3(jhandle.out_addr),

        .out()
        );

    InstructionMemory instmem(
        .Iaddr(pc.pc),
        .RW(cu.InsMemRw),

        .IDataOut()
        );

    IR ir(
        .clk(clk),
        .en(cu.IRWre),
        .in(instmem.IDataOut),

        .out()
        );

    Opdecoder opdecoder(
        .inst(ir.out),

        .opcode(),
        .rs(),
        .rt(),
        .rd(),
        .sa(),
        .immed(),
        .addr()
        );

    ControlUnit cu(
        .clk(clk),
        .rst(rst),
        .op(opdecoder.opcode),
        .zero(alu.zero),

        .ALUOp(),
        .PCWre(),
        .ALUSrcA(),
        .ALUSrcB(),
        .DBDataSrc(),
        .RegWre(),
        .WrRegDSrc(),
        .InsMemRw(),
        .RD(),
        .WR(),
        .IRWre(),
        .ExtSel(),
        .PCSrc(),
        .RegDst()
        );

    Regfile regfile(
        .clk(clk),
        .WE(cu.RegWre),
        .RdReg1addr(opdecoder.rs),
        .RdReg2addr(opdecoder.rt),
        .WrRegaddr(rt_rd_selector.out),
        .inData(writeData_selector.out),

        .reg1dataOut(),
        .reg2dataOut(),
        .reg32Out()
        );

    DataReg adr(
        .clk(clk),
        .in(regfile.reg1dataOut),

        .out()
        );

    DataReg bdr(
        .clk(clk),
        .in(regfile.reg2dataOut),

        .out()
        );

    DataReg aluoutdr(
        .clk(clk),
        .in(alu.result),

        .out()
        );

    DataReg dbdr(
        .clk(clk),
        .in(res_dataout_selector.out),

        .out()
        );

    Extend extend(
        .ExtSel(cu.ExtSel),
        .imm_16(opdecoder.immed),

        .imm_32()
        );

    Mux_ThreetoOne5 rt_rd_selector(
        .sel(cu.RegDst),
        .in0(5'b11111),
        .in1(opdecoder.rt),
        .in2(opdecoder.rd),

        .out()
        );

    Mux_TwotoOne32 writeData_selector(
        .sel(cu.WrRegDSrc),
        .in1(pc.pc4),
        .in2(dbdr.out),

        .out()
        );

    ALU32 alu(
        .ALUopcode(cu.ALUOp),
        .rega(data1_sa_selector.out),
        .regb(data2_exi_selector.out),

        .result(),
        .zero()
        );

    DataMemory datamem(
        .clk(clk),
        .DAddr(aluoutdr.out),
        .RD(cu.RD),
        .WR(cu.WR),
        .DataIn(bdr.out),

        .DataOut()
        );

    Mux_TwotoOne32 data1_sa_selector(
        .sel(cu.ALUSrcA),
        .in1(adr.out),
        .in2({27'b0, opdecoder.sa}),

        .out()
        );
    Mux_TwotoOne32 data2_exi_selector(
        .sel(cu.ALUSrcB),
        .in1(bdr.out),
        .in2(extend.imm_32),

        .out()
        );

    Mux_TwotoOne32 res_dataout_selector(
        .sel(cu.DBDataSrc),
        .in1(alu.result),
        .in2(datamem.DataOut),

        .out()
        );

endmodule
