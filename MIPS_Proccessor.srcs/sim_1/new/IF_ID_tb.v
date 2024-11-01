`timescale 1ns / 1ps

module IF_ID_tb;
    
    reg clk;
    reg rst;
    // inputs
    reg [31:0] npc;
    reg [31:0] instruction;
    // outputs
    wire [31:0] npcOut;
    wire [31:0] instructionOut;

    // instantiate
    IF_ID IF_ID_uut (
        .clk(clk),
        .rst(rst),
        .npc(npc),
        .instruction(instruction),
        .npcOut(npcOut),
        .instructionOut(instructionOut)
    );

    // clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 5 time units
    end

    initial begin
        $monitor("time %t: npcOut = %h, instructionOut = %h", $time, npcOut, instructionOut);
    end

    initial 
    begin
        rst = 1;
        npc = 32'h0000_0000;
        instruction = 32'h0000_0000;
        #10;
        
        rst = 0; #10;
        
        npc = 32'h0000_0000; 
        instruction = 32'hA000_00AA;
        #10;
        
        npc = 32'h0000_0003; 
        instruction = 32'h9000_0099;
        #10;
        
        $finish;
    end

endmodule
