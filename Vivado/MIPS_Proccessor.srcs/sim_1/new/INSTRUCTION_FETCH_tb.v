`timescale 1ns / 1ps

module INSTRUCTION_FETCH_tb;  
    reg clk;
    reg rst;
    
    reg MEM_PCSrc;
    reg [31:0] MEM_npc;
    
    wire [31:0] IF_ID_npc;
    wire [31:0] IF_ID_instruction;

    // instantiate
    
    INSTRUCTION_FETCH INSTRUCTION_FETCH_uut(
        .clk(clk),
        .rst(rst),
        // input
        .MEM_PCSrc(MEM_PCSrc),
        .MEM_npc(MEM_npc),
        // output
        .IF_ID_npc(IF_ID_npc),
        .IF_ID_instruction(IF_ID_instruction)
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
        MEM_PCSrc = 0;
        MEM_npc = 32'h0000_0000;
        #10;

        rst = 0; 
              
        MEM_PCSrc = 1;
        MEM_npc = 32'h0000_0002;
        #50;
        
        MEM_PCSrc = 0;
        MEM_npc = 32'h0000_0000;
        #50;
        
        MEM_PCSrc = 1;
        MEM_npc = 32'h0000_000A;
        #50;
        
        $finish;
    end
endmodule