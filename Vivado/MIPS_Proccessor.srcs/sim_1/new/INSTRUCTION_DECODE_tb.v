`timescale 1ns / 1ps

module INSTRUCTION_DECODE_tb;
    reg clk;
    reg rst;
    
    reg [31:0] IF_ID_npc;
    reg [31:0] IF_ID_instruction;
    reg [4:0] WB_writeRegister;
    reg [31:0] WB_writeDataRegister;
    reg WB_controlWB_RegWrite;
    
    wire ID_EX_controlEX_RegDst;
    wire [1:0] ID_EX_controlEX_ALUOp;
    wire ID_EX_controlEX_ALUSrc;
    
    wire [2:0] ID_EX_controlMEM;
    wire [1:0] ID_EX_controlWB;
    
    wire [31:0] ID_EX_npc;
    wire [31:0] ID_EX_readData_rs;
    wire [31:0] ID_EX_readData_rt;
    wire [31:0] ID_EX_signExtend;
    wire [4:0] ID_EX_instruction_20_16;
    wire [4:0] ID_EX_instruction_15_11;
    
    wire [31:0] register0, register1, register2, register3,
                register4, register5, register6, register7,
                register8, register9, register10, register11,
                register12,register13, register14, register15,
                register16, register17, register18, register19,
                register20, register21, register22, register23,
                register24, register25, register26, register27,
                register28, register29, register30, register31;
    
    // instantiate
    
    INSTRUCTION_DECODE INSTRUCTION_DECODE_uut(
        .clk(clk),
        .rst(rst),
        // input
        .IF_ID_npc(IF_ID_npc),
        .IF_ID_instruction(IF_ID_instruction),
        .WB_writeRegister(WB_writeRegister),
        .WB_writeDataRegister(WB_writeDataRegister),
        .WB_controlWB_RegWrite(WB_controlWB_RegWrite),
        // control output
        .ID_EX_controlEX_RegDst(ID_EX_controlEX_RegDst),    // controlEX[3] (RegDst)
        .ID_EX_controlEX_ALUOp(ID_EX_controlEX_ALUOp),      // controlEX[2:1] (ALUOp[1:0])
        .ID_EX_controlEX_ALUSrc(ID_EX_controlEX_ALUSrc),    // controlEX[0] (ALUSrc)
        .ID_EX_controlMEM(ID_EX_controlMEM),                // [Branch, MemRead, MemWrite
        .ID_EX_controlWB(ID_EX_controlWB),                  // [RegWrite, MemToReg]
        // output
        .ID_EX_npc(ID_EX_npc),
        .ID_EX_readData_rs(ID_EX_readData_rs),
        .ID_EX_readData_rt(ID_EX_readData_rt),
        .ID_EX_signExtend(ID_EX_signExtend),
        .ID_EX_instruction_20_16(ID_EX_instruction_20_16),
        .ID_EX_instruction_15_11(ID_EX_instruction_15_11),
        
        .register0(register0), .register1(register1), .register2(register2), .register3(register3),
        .register4(register4), .register5(register5), .register6(register6), .register7(register7),
        .register8(register8), .register9(register9), .register10(register10), .register11(register11),
        .register12(register12), .register13(register13), .register14(register14), .register15(register15),
        .register16(register16), .register17(register17), .register18(register18), .register19(register19),
        .register20(register20), .register21(register21), .register22(register22), .register23(register23),
        .register24(register24), .register25(register25), .register26(register26), .register27(register27),
        .register28(register28), .register29(register29), .register30(register30), .register31(register31)
    );
    
    // clock
    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk;  // 5 time units
    end
    
    initial 
    begin
        rst = 1;               
        IF_ID_instruction = 32'b000000_00000_00000_0000_0000_0000_0000;
        WB_writeRegister = 5'd0;
        WB_writeDataRegister = 32'h0000_0000;
        WB_controlWB_RegWrite = 0;
        IF_ID_npc = 32'h0000_0000;
        #10;
        
        // no operation (nop) instruction
        rst = 0;
        IF_ID_instruction = 32'b100000_00000_00000_0000000000000000;
        WB_writeRegister = 5'd0;
        WB_writeDataRegister = 32'h0000_0000;
        WB_controlWB_RegWrite = 0;
        IF_ID_npc = 32'h0000_0000;
        #10;
        
        // load (lw) instruction
        IF_ID_instruction = 32'b100011_00000_00001_0000000000000001;
        WB_writeRegister = 5'd1;
        WB_writeDataRegister = 32'h0000_0001;
        WB_controlWB_RegWrite = 1;
        IF_ID_npc = 32'h0000_0002;
        #10;
        
        // load (lw) instruction
        IF_ID_instruction = 32'b100011_00000_00010_0000000000000010;
        WB_writeRegister = 5'd2;
        WB_writeDataRegister = 32'h0000_0002;
        WB_controlWB_RegWrite = 1;
        IF_ID_npc = 32'h0000_0003;
        #10;
        
        // store (sw) instruction
        IF_ID_instruction = 32'b101011_00000_00001_0000000000000001;
        WB_writeRegister = 5'd2;
        WB_writeDataRegister = 32'hA5A5_A5A5;
        WB_controlWB_RegWrite = 0;
        IF_ID_npc = 32'h0000_0004;
        #10;
        
        // r-type (e.g add, sub) instruction
        IF_ID_instruction = 32'b000000_00001_00010_00001_00000_100000;
        WB_writeRegister = 5'd1;
        WB_writeDataRegister = 32'h0000_0003;
        WB_controlWB_RegWrite = 1;
        IF_ID_npc = 32'h0000_0005;
        #10;
        
        // branch (beq) instruction
        IF_ID_instruction = 32'b000100_00001_00010_0000000000000001;
        WB_writeRegister = 5'd2;
        WB_writeDataRegister = 32'hC3C3_C3C3;
        WB_controlWB_RegWrite = 0;
        IF_ID_npc = 32'h0000_0006;
        #10;
         
        $finish;
    end
endmodule