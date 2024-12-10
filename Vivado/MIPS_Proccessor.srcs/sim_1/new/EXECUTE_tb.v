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
    wire [31:0] EX_MEM_addressMemory;
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
        .EX_MEM_addressMemory(EX_MEM_addressMemory),
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
        
        ID_EX_npc = 32'h0;
        ID_EX_readData_rs = 32'h0000_0000;
        ID_EX_readData_rt = 32'h0000_0000;
        ID_EX_signExtend = 32'h0000_0000;
        ID_EX_instruction_20_16 = 5'b00000;
        ID_EX_instruction_15_11 = 5'b00000;
        #10;
        
        rst = 0; #10; // nop
        
        // load (lw) instruction
        ID_EX_controlEX_RegDst = 1'b0;
        ID_EX_controlEX_ALUOp = 2'b00;  // add
        ID_EX_controlEX_ALUSrc = 1'b1;
        ID_EX_controlMEM = 3'b010;
        ID_EX_controlWB = 2'b11;
        
        ID_EX_npc = 32'h0000_0002;
        ID_EX_readData_rs = 32'h0000_0000;
        ID_EX_readData_rt = 32'h0000_0000;
        ID_EX_signExtend = 32'h0000_0001;
        ID_EX_instruction_20_16 = 5'b00001;
        ID_EX_instruction_15_11 = 5'b00000;
        #10;
        
        // load (lw) instruction
        ID_EX_controlEX_RegDst = 1'b0;
        ID_EX_controlEX_ALUOp = 2'b00;  // add
        ID_EX_controlEX_ALUSrc = 1'b1;
        ID_EX_controlMEM = 3'b010;
        ID_EX_controlWB = 2'b11;
        
        ID_EX_npc = 32'h0000_0003;
        ID_EX_readData_rs = 32'h0000_0000;
        ID_EX_readData_rt = 32'h0000_0000;
        ID_EX_signExtend = 32'h0000_0002;
        ID_EX_instruction_20_16 = 5'b00010;
        ID_EX_instruction_15_11 = 5'b00000;
        #10;
        
        // store (sw) instruction
        ID_EX_controlEX_RegDst = 1'b0;
        ID_EX_controlEX_ALUOp = 2'b00;  // add
        ID_EX_controlEX_ALUSrc = 1'b1;
        ID_EX_controlMEM = 3'b001;
        ID_EX_controlWB = 2'b00;
        
        ID_EX_npc = 32'h0000_0004;
        ID_EX_readData_rs = 32'h0000_0001;
        ID_EX_readData_rt = 32'h0000_0001;
        ID_EX_signExtend = 32'h0000_0001;
        ID_EX_instruction_20_16 = 5'b00001;
        ID_EX_instruction_15_11 = 5'b00000;
        #10;
        
        // r-type (e.g add, sub) instruction
        ID_EX_controlEX_RegDst = 1'b1;
        ID_EX_controlEX_ALUOp = 2'b10;  // r-type (add)
        ID_EX_controlEX_ALUSrc = 1'b0;
        ID_EX_controlMEM = 3'b000;
        ID_EX_controlWB = 2'b10;
        
        ID_EX_npc = 32'h0000_0005;
        ID_EX_readData_rs = 32'h0000_0001;
        ID_EX_readData_rt = 32'h0000_0002;
        ID_EX_signExtend = 32'h0000_0820;
        ID_EX_instruction_20_16 = 5'b00010;
        ID_EX_instruction_15_11 = 5'b00001;
        #10;
        
        // branch (beq) instruction
        ID_EX_controlEX_RegDst = 1'b0;
        ID_EX_controlEX_ALUOp = 2'b01;  // sub
        ID_EX_controlEX_ALUSrc = 1'b0;
        ID_EX_controlMEM = 3'b100;
        ID_EX_controlWB = 2'b00;
        
        ID_EX_npc = 32'h0000_0006;
        ID_EX_readData_rs = 32'h0000_0003;
        ID_EX_readData_rt = 32'h0000_0002;
        ID_EX_signExtend = 32'h0000_0001;
        ID_EX_instruction_20_16 = 5'b00010;
        ID_EX_instruction_15_11 = 5'b00000;
        #10;
               
        $finish;
    end   
endmodule