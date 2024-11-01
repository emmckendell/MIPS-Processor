`timescale 1ns / 1ps

module ID_EX(
    input wire clk,
    
    input wire [31:0] npc, readData1, readData2, instructionSignExtend_15_0,
    input wire [5:0] instruction_20_16, instruction_15_11,
    
    output reg [31:0] npcOut, readData1Out, readData2Out, instructionSignExtend_15_0_Out,
    output reg [5:0] instruction_20_16_Out, instruction_15_11_Out
    );
    
    initial 
    begin
        // 32 bits
        npcOut <= 0;
        readData1Out <= 0;
        readData2Out <= 0;
        instructionSignExtend_15_0_Out <= 0;
        
        // 6 bits
        instruction_20_16_Out <= 0;
        instruction_15_11_Out <= 0;
    end
    
    always @(posedge clk)
    begin
        npcOut <= npc;
        readData1Out <= readData1;
        readData2Out <= readData2;
        instructionSignExtend_15_0_Out <= instructionSignExtend_15_0;
        
        instruction_20_16_Out <= instruction_20_16;
        instruction_15_11_Out <= instruction_15_11; 
    end
    
endmodule