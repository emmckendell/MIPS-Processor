`timescale 1ns / 1ps

module MEMORY(
    input clk,
    input rst,
    
    input wire EX_MEM_controlMEM_Branch,        // controlMEM[2] (Branch)
    input wire EX_MEM_controlMEM_MemRead,       // controlMEM[1] (MemRead)
    input wire EX_MEM_controlMEM_MemWrite,      // controlMEM[0] (MemWrite)
    input wire [1:0] EX_MEM_controlWB,          // [RegWrite, MemToReg]
    
    input wire EX_MEM_zeroFlag,                 // ALU_result = 0
    
    input wire [31:0] EX_MEM_npc,
    input wire [31:0] EX_MEM_addressMemory,
    input wire [31:0] EX_MEM_writeDataMemory,
    input wire [4:0] EX_MEM_writeRegister,
    
    output wire MEM_WB_controlWB_RegWrite,      // controlWB[1]
    output wire MEM_WB_controlWB_MemToReg,      // controlWB[0]
    
    output wire [31:0] MEM_WB_readData_mem,
    output wire [31:0] MEM_WB_addressMemory,
    output wire [4:0] MEM_WB_writeRegister,
    
    output wire [31:0] MEM_npc,
    output wire MEM_PCSrc
    );
    
    assign MEM_npc = EX_MEM_npc;
    
    wire [31:0] readData_mem;
    
    // instantiations
    
    // AND gate
    branch branch_INST(
        // y = a & b
        
        // input
        .a(EX_MEM_controlMEM_Branch),
        .b(EX_MEM_zeroFlag),            // ALU_result = 0
        // output
        .y(MEM_PCSrc)
        );
    
    dataMemory dataMemory_INST(
        .clk(clk),
        .rst(rst),
        // control input
        .MemWrite(EX_MEM_controlMEM_MemWrite),
        .MemRead(EX_MEM_controlMEM_MemRead),
        // input
        .addressMemory(EX_MEM_addressMemory),
        .writeDataMemory(EX_MEM_writeDataMemory),
        // output
        .readData_mem(readData_mem)
        );
    
    MEM_WB MEM_WB_tb(
        .clk(clk),
        .rst(rst),
        
        // control input
        .controlWB(EX_MEM_controlWB),                       // split into two signals, ued in WB stage
        
        // control output
        .controlWB_RegWrite(MEM_WB_controlWB_RegWrite),     // controlWB[1]
        .controlWB_MemToReg(MEM_WB_controlWB_MemToReg),     // controlWB[0]
        
        // input
        .readData_mem(readData_mem),
        .addressMemory(EX_MEM_addressMemory),
        .writeRegister(EX_MEM_writeRegister),
        
        // output
        .readData_memOut(MEM_WB_readData_mem),
        .addressMemoryOut(MEM_WB_addressMemory),
        .writeRegisterOut(MEM_WB_writeRegister)
        );  
endmodule