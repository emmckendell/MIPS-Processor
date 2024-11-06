`timescale 1ns / 1ps

module INSTRUCTION_FETCH(
    input clk,
    input rst,
    input wire EX_MEM_PCSrc,
    input wire [31:0] EX_MEM_npc,
    output wire [31:0] IF_ID_instruction,   // wire transfer data, register store data
    output wire [31:0] IF_ID_npc
    );
    
    // signals
    wire [31:0] pc;
    wire [31:0] dataOut;
    wire [31:0] npc, npc_mux;
    
    // instantiations
    
    mux mux_INST(
        // .baseClass_var(currentClass_var)
        // inputs
        .a(EX_MEM_npc),
        .b(npc),
        .sel(EX_MEM_PCSrc), // input: a = 1, b = 0
        // output
        .y(npc_mux)
        );
        
    programCounter programCounter_INST(
        .clk(clk),
        .rst(rst),
        .npc(npc_mux),      // input
        .pc(pc)             // output
        );
        
    incrementer incrementer_INST(
        .pc(pc),            // input
        .next_pc(npc)       // output
        );
        
    instructionMemory instructionMemory_INST(
        .clk(clk),
        .address(pc),       // input
        .data(dataOut)      // output
        );
        
    IF_ID IF_ID_INST(
        .clk(clk),
        .rst(rst),
        //inputs
        .npc(npc),
        .instruction(dataOut),
        // outputs
        .npcOut(IF_ID_npc),
        .instructionOut(IF_ID_instruction)
        );
    
endmodule
