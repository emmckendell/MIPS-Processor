`timescale 1ns / 1ps

module EX_MEM(
    input clk,
    input rst,
    
    // control input
    input wire [2:0] controlMEM,    // [Branch, MemRead, MemWrite]
    input wire [1:0] controlWB,     // [RegWrite, MemToReg]
    input wire zeroFlag,
    
    // control output
    output reg controlMEM_Branch,   // controlMEM[2]
    output reg controlMEM_MemRead,  // controlMEM[1]
    output reg controlMEM_MemWrite, // controlMEM[0]
    
    output reg [1:0] controlWBOut,  // [RegWrite, MemToReg]
    output reg zeroFlagOut,
    
    // input
    input wire [31:0] addResult,
    input wire [31:0] result,
    input wire [31:0] readData_rt,  // second register
    input wire [4:0] RegDstMux,
       
    // output
    output reg [31:0] npcMEM,
    output reg [31:0] addressMemory,
    output reg [31:0] writeDataMemory,
    output reg [4:0] writeRegister
    );
    
    initial
    begin
        controlMEM_Branch <= 0;     // controlMEM[2]
        controlMEM_MemRead <= 0;    // controlMEM[1]
        controlMEM_MemWrite <= 0;   // controlMEM[0]
        
        controlWBOut <= 0;          // [RegWrite, MemToReg]
        
        zeroFlagOut <= 0;
        
        npcMEM <= 0;
        addressMemory <= 0;
        writeDataMemory <= 0;
        writeRegister <= 0;
    end
    
    always @(posedge clk)
    begin
        if(rst)
        begin
            controlMEM_Branch <= 0;     // controlMEM[2]
            controlMEM_MemRead <= 0;    // controlMEM[1]
            controlMEM_MemWrite <= 0;   // controlMEM[0]
            
            controlWBOut <= 0;          // [RegWrite, MemToReg]
        
            zeroFlagOut <= 0;
            
            npcMEM <= 0;
            addressMemory <= 0;
            writeDataMemory <= 0;
            writeRegister <= 0;
        end
        else
        begin
            controlMEM_Branch <= controlMEM[2];     // controlMEM[2]
            controlMEM_MemRead <= controlMEM[1];    // controlMEM[1]
            controlMEM_MemWrite <= controlMEM[0];   // controlMEM[0]
            
            controlWBOut <= controlWB;              // [RegWrite, MemToReg]
        
            zeroFlagOut <= zeroFlag;
            
            npcMEM <= addResult;
            addressMemory <= result;
            writeDataMemory <= readData_rt;
            writeRegister <= RegDstMux;
        end
    end
endmodule      