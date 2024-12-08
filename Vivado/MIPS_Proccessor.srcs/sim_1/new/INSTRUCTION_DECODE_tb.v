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
        // i-format: opcode(0)_rs_rt_rd_shamt_funct
        // j-format: opcode(35/43)_rs_rt_address
        // r-format: opcode(4)_rs_rt_address
                     
        IF_ID_instruction = 32'b000000_00000_00000_0000_0000_0000_0000;
        WB_writeRegister = 5'd0;
        WB_writeDataRegister = 32'h0000_0000;
        WB_controlWB_RegWrite = 0;
        IF_ID_npc = 32'h0000_0000;
        #10;
        
        rst = 0; #10;
        
        // $r16 = $zero + 3 | opcode=001000, rs=00000, rt=10000, immediate=0000_0000_0000_0011
        IF_ID_npc = 32'h0000_0001;
        IF_ID_instruction = 32'b001000_00000_10001_0000_0000_0000_0011;
        #50;
        
        // write to register 16 ($r16)
        WB_writeRegister = 5'd16;
        WB_writeDataRegister = 32'h0000_0003;
        WB_controlWB_RegWrite = 1;
        #50;
        
        // $r17 = $zero + 2 | opcode=001000, rs=00000, rt=10001, immediate=0000_0000_0000_0010
        IF_ID_npc = 32'h0000_0002;
        IF_ID_instruction = 32'b001000_00000_10001_00000_00000_000010;
        #50;
        
        // write to register 17 ($r17)
        WB_writeRegister = 5'd17;
        WB_writeDataRegister = 32'h0000_0002;
        WB_controlWB_RegWrite = 1;
        #50;
        
        // $r18 = $r16 + $r17 | opcode=000000, rs=10000, rt=10001, rd=10010, shamt=00000, funct=100000
        // $r18 = 3 + 2
        IF_ID_npc = 32'h0000_0003;
        IF_ID_instruction = 32'b000000_10000_10001_10010_00000_100000;
        #50;
        
        // write to register 18 ($r18)
        WB_writeRegister = 5'd18;
        WB_writeDataRegister = 32'h0000_0005;
        WB_controlWB_RegWrite = 1;
        #50;
        
        // $r19 = $r16 - $r17 | opcode=000000, rs=10000, rt=10001, rd=10011, shamt=00000, funct=100010
        // $r19 = 3 - 2
        IF_ID_npc = 32'h0000_0004;
        IF_ID_instruction = 32'b000000_10000_10001_10011_00000_100010;
        #50;
        
        // write to register 19 ($r19)
        WB_writeRegister = 5'd19;
        WB_writeDataRegister = 32'h0000_0001;
        WB_controlWB_RegWrite = 1;
        #50;
        
        // memory[$r16 + 3] = $r18(32'h5) | opcode=101011, rs=10000, rt=10010, offset=0000_0000_0000_0011
        // memory[3 + 3] = (32'h5)
        IF_ID_npc = 32'h0000_0005;
        IF_ID_instruction = 32'b101011_10000_10010_0000000000000011;
        #50;
                
        // no write to register needed
        WB_controlWB_RegWrite = 0; 
        #50;
        
        // $r20 = memory[$r16 + 3] | opcode=100011, rs=10000, rt=10100, offset=0000_0000_0000_0010
        // $r20 = memory[3 + 3](contains 32'h5)
        IF_ID_npc = 32'h0000_0006;
        IF_ID_instruction = 32'b100011_10000_10100_0000000000000011;
        #50;
        
        // write to register 20 ($r20)
        WB_writeRegister = 5'd20;
        WB_writeDataRegister = 32'h0000_0005;  // assuming memory[$r16 + 3] contains 32'h5
        WB_controlWB_RegWrite = 1;
        #50;
                  
        $finish;
    end
endmodule