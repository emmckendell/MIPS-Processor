`timescale 1ns / 1ps

module EXECUTE_tb;
    reg clk;
    reg rst;
    
    reg ID_EX_controlEX_RegDst;
    reg [1:0] ID_EX_controlEX_ALUOp;
    reg ID_EX_controlEX_ALUSrc;
    reg [2:0] ID_EX_controlMEM;
    reg [1:0] ID_EX_controlWB;
    
    wire EX_MEM_controlMEM_Branch;
    wire EX_MEM_controlMEM_MemRead;
    wire EX_MEM_controlMEM_MemWrite;
    wire [1:0] EX_MEM_controlWB;
    
    wire EX_MEM_zeroFlag; 
    
    reg [31:0] ID_EX_npc;
    reg [31:0] ID_EX_readData_rs;
    reg [31:0] ID_EX_readData_rt;
    reg [31:0] ID_EX_signExtend;
    reg [4:0] ID_EX_instruction_20_16;
    reg [4:0] ID_EX_instruction_15_11;
    
    
    wire [31:0] EX_MEM_npc;   
    wire [31:0] EX_MEM_address;
    wire [31:0] EX_MEM_writeDataMemory;
    wire [4:0] EX_MEM_writeRegister;
    
    // instantiate
    
    EXECUTE EXECUTE_uut(
        .clk(clk),
        .rst(rst),
        // control input
        .ID_EX_controlEX_RegDst(ID_EX_controlEX_RegDst),    // controlEX[3] (RegDst)
        .ID_EX_controlEX_ALUOp(ID_EX_controlEX_ALUOp),      // controlEX[2:1] (ALUOp[1:0])
        .ID_EX_controlEX_ALUSrc(ID_EX_controlEX_ALUSrc),    // controlEX[0] (ALUSrc)
        .ID_EX_controlMEM(ID_EX_controlMEM),                // [Branch, MemRead, MemWrite]
        .ID_EX_controlWB(ID_EX_controlWB),                  // [RegWrite, MemToReg]
        // control output
        .EX_MEM_controlMEM_Branch(EX_MEM_controlMEM_Branch),        // controlMEM[2]
        .EX_MEM_controlMEM_MemRead(EX_MEM_controlMEM_MemRead),      // controlMEM[1]
        .EX_MEM_controlMEM_MemWrite(EX_MEM_controlMEM_MemWrite),    // controlMEM[0]
        .EX_MEM_controlWB(EX_MEM_controlWB),                        // [RegWrite, MemToReg]
        .EX_MEM_zeroFlag(EX_MEM_zeroFlag),
        // input
        .ID_EX_npc(ID_EX_npc),
        .ID_EX_readData_rs(ID_EX_readData_rs),      // first (source) register
        .ID_EX_readData_rt(ID_EX_readData_rt),      // second register
        .ID_EX_signExtend(ID_EX_signExtend),
        .ID_EX_instruction_20_16(ID_EX_instruction_20_16),
        .ID_EX_instruction_15_11(ID_EX_instruction_15_11),
        // output
        .EX_MEM_npc(EX_MEM_npc),
        .EX_MEM_address(EX_MEM_address),
        .EX_MEM_writeDataMemory(EX_MEM_writeDataMemory),
        .EX_MEM_writeRegister(EX_MEM_writeRegister)
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
        ID_EX_controlEX_RegDst = 1'b0;
        ID_EX_controlEX_ALUOp = 2'b00;
        ID_EX_controlEX_ALUSrc = 1'b0;
        ID_EX_controlMEM = 3'b000;
        ID_EX_controlWB = 2'b00;
        
        ID_EX_npc = 32'd0;
        ID_EX_readData_rs = 32'd0;
        ID_EX_readData_rt = 32'd0;
        ID_EX_signExtend = 32'd0;
        ID_EX_instruction_20_16 = 5'd0;
        ID_EX_instruction_15_11 = 5'd0;
        #10;
        
        rst = 0; #10;

        // $s0 = 0 + 3
        // addi $s0, $zero, 3 | opcode=001000, rs=00000, rt=10000, immediate=0000_0000_0000_0011
        ID_EX_controlEX_RegDst = 1;
        ID_EX_controlEX_ALUOp = 2'b10; // Assume 10 corresponds to a "SUB" operation
        ID_EX_controlEX_ALUSrc = 1;
        ID_EX_controlMEM = 3'b101; // Branch = 1, MemRead = 0, MemWrite = 1
        ID_EX_controlWB = 2'b11;   // RegWrite = 1, MemToReg = 1
        
        ID_EX_npc = 32'd100;
        ID_EX_readData_rs = 32'd15;
        ID_EX_readData_rt = 32'd5;
        ID_EX_signExtend = 32'd10;
        ID_EX_instruction_20_16 = 5'd2;
        ID_EX_instruction_15_11 = 5'd3;

        #20;

        // Test Case 2: Branch operation
        ID_EX_controlEX_RegDst = 0;
        ID_EX_controlEX_ALUOp = 2'b01; // Assume 01 corresponds to a "BEQ" operation
        ID_EX_controlEX_ALUSrc = 0;
        ID_EX_controlMEM = 3'b100; // Branch = 1, MemRead = 0, MemWrite = 0
        ID_EX_controlWB = 2'b00;   // RegWrite = 0, MemToReg = 0
        ID_EX_npc = 32'd200;
        ID_EX_readData_rs = 32'd25;
        ID_EX_readData_rt = 32'd25;
        ID_EX_signExtend = 32'd4;
        ID_EX_instruction_20_16 = 5'd4;
        ID_EX_instruction_15_11 = 5'd5;

        #20
    
    
        $finish;
    end   
endmodule