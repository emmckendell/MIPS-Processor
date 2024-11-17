`timescale 1ns / 1ps

module ID_EX(
    input clk,
    input rst,
    
    // control input
    input wire [3:0] controlEX,         // [regDst, aluOp[1:0], aluSrc]
    input wire [2:0] controlMEM,        // [Branch, MemRead, MemWrite]
    input wire [1:0] controlWB,         // [RegWrite, MemToReg]
    
    // control output
    output reg controlEX_RegDst,        // controlEX[3]
    output reg [1:0] controlEX_ALUOp,   // controlEX[2:1]
    output reg controlEX_ALUSrc,        // controlEX[0]
    
    output reg [2:0] controlMEMOut,     // [Branch, MemRead, MemWrite]
    output reg [1:0] controlWBOut,      // [RegWrite, MemToReg]
    
    // input
    input wire [31:0] nextProgramCount,
    input wire [31:0] readData_rs, readData_rt,
    input wire [31:0] instructionSignExtend_15_0,   // 32 bits 
     
    input wire [5:0] instruction_20_16, instruction_15_11,
      
    // output
    output reg [31:0] npcEXOut,
    output reg [31:0] readData_rsOut, readData_rtOut,
    output reg [31:0] instructionSignExtend_15_0_Out,
    
    output reg [5:0] instruction_20_16_Out, instruction_15_11_Out
    );
    
    initial 
    begin
        controlEX_RegDst <= 0;  // controlEX[3]
        controlEX_ALUOp <= 0;   // controlEX[2:1]
        controlEX_ALUSrc <= 0;  // controlEX[0]
        
        controlMEMOut <= 0;     // [Branch, MemRead, MemWrite]
        controlWBOut <= 0;      // [RegWrite, MemToReg]
    
        // 32 bits
        npcEXOut <= 0;
        readData_rsOut <= 0;
        readData_rtOut <= 0;
        instructionSignExtend_15_0_Out <= 0;
        
        // 6 bits
        instruction_20_16_Out <= 0;
        instruction_15_11_Out <= 0;
    end
    
    always @(posedge clk)
    begin
        if (rst) 
        begin
            controlEX_RegDst <= 0;  // controlEX[3]
            controlEX_ALUOp <= 0;   // controlEX[2:1]
            controlEX_ALUSrc <= 0;  // controlEX[0]
            
            controlMEMOut <= 0;     // [Branch, MemRead, MemWrite]
            controlWBOut <= 0;      // [RegWrite, MemToReg]
            
            npcEXOut <= 0;
            readData_rsOut <= 0;
            readData_rtOut <= 0;
            instructionSignExtend_15_0_Out <= 0;    // 32 bits
            instruction_20_16_Out <= 0;
            instruction_15_11_Out <= 0;
        end
        else 
        begin
            controlEX_RegDst <= controlEX[3];
            controlEX_ALUOp <= controlEX[2:1];
            controlEX_ALUSrc <= controlEX[0];
            
            controlMEMOut <= controlMEM;    // [Branch, MemRead, MemWrite]
            controlWBOut <= controlWB;      // [RegWrite, MemToReg]
        
            npcEXOut <= nextProgramCount;
            readData_rsOut <= readData_rs;
            readData_rtOut <= readData_rt;
            instructionSignExtend_15_0_Out <= instructionSignExtend_15_0;   // 32 bits
            instruction_20_16_Out <= instruction_20_16;
            instruction_15_11_Out <= instruction_15_11; 
        end
    end 
endmodule