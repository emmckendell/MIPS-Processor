`timescale 1ns / 1ps

module INSTRUCTION_FETCH(
    input clk,
    input rst,
    
    input wire EX_MEM_PCSrc,
    input wire [31:0] EX_MEM_npc,
    
    output wire [31:0] IF_ID_instruction,
    output wire [31:0] IF_ID_npc
    );
    
    wire [31:0] PCSrcMux;
    wire [31:0] ProgramCount;
    wire [31:0] dataOut;
    wire [31:0] nextProgramCount;
    
    // instantiations
       
    mux mux_PCSrc_INST(
        // input: a = 1, b = 0
        
        // input
        .a(EX_MEM_npc),
        .b(nextProgramCount),
        .sel(EX_MEM_PCSrc),
        // output
        .y(PCSrcMux)
        );
        
    programCounter programCounter_INST(
        .clk(clk),
        .rst(rst),
        // input
        .nextProgramCount(PCSrcMux),
        // output
        .ProgramCount(ProgramCount)
        );
        
    incrementer incrementer_INST(
        // input
        .ProgramCount(ProgramCount),
        // output
        .nextProgramCount(nextProgramCount)
        );
        
    instructionMemory instructionMemory_INST(
        .clk(clk),
        // input
        .address(ProgramCount),
        // output
        .data(dataOut)
        );
        
    IF_ID IF_ID_INST(
        .clk(clk),
        .rst(rst),
        //input
        .nextProgramCount(nextProgramCount),
        .instruction(dataOut),
        // output
        .npcIDOut(IF_ID_npc),
        .instructionOut(IF_ID_instruction)
        );   
endmodule