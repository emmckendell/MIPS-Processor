`timescale 1ns / 1ps

module INSTRUCTION_FETCH_tb;
    
    reg clk;
    reg rst;
    // inputs
    reg EX_MEM_PCSrc;
    reg [31:0] EX_MEM_npc;
    // outputs
    wire [31:0] IF_ID_instruction;
    wire [31:0] IF_ID_npc;

    // instantiate
    INSTRUCTION_FETCH INSTRUCTION_FETCH_uut(
        .clk(clk),
        .rst(rst),
        .EX_MEM_PCSrc(EX_MEM_PCSrc),
        .EX_MEM_npc(EX_MEM_npc),
        .IF_ID_instruction(IF_ID_instruction),
        .IF_ID_npc(IF_ID_npc)
    );

    // clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 5 time units
    end
    
    initial 
    begin
//        $monitor("time %t, pc = %h, npc = %h, dataOut = %h, IF_ID_instruction = %h, IF_ID_npc = %h", 
//                 $time, 
//                 INSTRUCTION_FETCH_uut.pc, 
//                 INSTRUCTION_FETCH_uut.npc, 
//                 INSTRUCTION_FETCH_uut.dataOut,
//                 IF_ID_npc, 
//                 IF_ID_instruction
//                 );
        
        rst = 1;
        EX_MEM_PCSrc = 0;
        EX_MEM_npc = 32'h0000_0000;
        #10;

        rst = 0; 
              
        EX_MEM_PCSrc = 1;
        EX_MEM_npc = 32'h0000_0004;
        #50;
        
        EX_MEM_PCSrc = 0;
        EX_MEM_npc = 32'h0000_0008;
        #50;
        
        EX_MEM_PCSrc = 1;
        EX_MEM_npc = 32'h0000_0008;
        #50;     
        
        $finish;
    end

endmodule
