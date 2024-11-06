`timescale 1ns / 1ps

module programCounter_tb;

    // inputs
    reg clk;
    reg rst;
    reg [31:0] npc;

    wire [31:0] pc; // output

    // instantiate
    programCounter programCounter_uut (
        .clk(clk),
        .rst(rst),
        .npc(npc),
        .pc(pc)
    );

    // clock
    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk;  // 5 time units
    end
    
    initial 
    begin
        $monitor("time = %t, rst = %b, npc = %h, pc = %h", $time, rst, npc, pc);
        
        // initialize
        rst = 1;
        npc = 32'h0000_0000;
        #10;
        
        rst = 0; 
        
        npc = 32'h0000_0008; #20; // pc = 0000_0008
        npc = 32'h0000_0004; #20; // pc = 0000_0004
        npc = 32'hFFFF_FFFF; #20; // pc = FFFF_FFFF
        
        rst = 1; #20;       
        $finish;
    end
    
endmodule