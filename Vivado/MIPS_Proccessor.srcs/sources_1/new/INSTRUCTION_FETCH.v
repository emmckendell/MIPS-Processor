`timescale 1ns / 1ps

module INSTRUCTION_FETCH(
    input clk,
    input rst,
    
    input wire [31:0] MEM_npc,
    input wire MEM_PCSrc,
    
    output wire [31:0] IF_ID_npc,
    output wire [31:0] IF_ID_instruction
    );
    
    wire [31:0] PCSrcMux;
    wire [31:0] ProgramCount;
    wire [31:0] dataOut;
    wire [31:0] nextProgramCount;
    
    // instantiations
       
    mux_32bit mux_32bit_PCSrc_INST(
        // input: a = 1, b = 0
        
        // input
        .a(MEM_npc),
        .b(nextProgramCount),
        .sel(MEM_PCSrc),
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