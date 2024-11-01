`timescale 1ns / 1ps

/*
Implements an IF/ID pipeline register that inputs and outputs 
the program counter and instructions
*/

module IF_ID(
    input wire clk,
    inout wire rst,
    input wire [31:0] npc, instruction,         // input of IF/ID npc register
    output reg [31:0] npcOut, instructionOut    // output of IF/ID instruction. npc register
    );
    
    initial 
    begin
        npcOut <= 0;
        instructionOut <= 0;
    end
    
    always @(posedge clk)
    begin
        if(rst)
        begin
            npcOut <= 0;
            instructionOut <= 0;
        end
        
        else
        begin
            npcOut <= npc;
            instructionOut <= instruction;
        end
    end

endmodule
