`timescale 1ns / 1ps

module IF_ID(
    input clk,
    input rst,
    
    // input
    input wire [31:0] nextProgramCount,
    input wire [31:0] instruction,
    
    // output
    output reg [31:0] npcIDOut, 
    output reg [31:0] instructionOut
    );
    
    initial 
    begin
        npcIDOut <= 0;
        instructionOut <= 0;
    end
    
    always @(posedge clk)
    begin
        if(rst)
        begin
            npcIDOut <= 0;
            instructionOut <= 0;
        end   
        else
        begin
            npcIDOut <= nextProgramCount;
            instructionOut <= instruction;
        end
    end
endmodule