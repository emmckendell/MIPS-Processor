`timescale 1ns / 1ps

module programCounter_tb;
    reg clk;
    reg rst;
    reg [31:0] nextProgramCount;

    wire [31:0] ProgramCount;

    // instantiate
    programCounter programCounter_uut (
        .clk(clk),
        .rst(rst),
        .nextProgramCount(nextProgramCount),    // input
        .ProgramCount(ProgramCount)             // output
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
        nextProgramCount = 32'h0000_0000;
        #10;
        
        rst = 0; 
        
        nextProgramCount = 32'h0000_0008; #20; 
        // Expected: ProgramCount = 0000_0008
        
        nextProgramCount = 32'hA5A5_A5A5; #20; 
        // Expected: ProgramCount = A5A5_A5A5
        
        nextProgramCount = 32'hF0F0_F0F0; #20; 
        // Expected: ProgramCount = F0F0_F0F0
        
        nextProgramCount = 32'hFFFF_FFFF; #20; 
        // Expected: ProgramCount = FFFF_FFFF
        
        rst = 1; #20;
        $finish;
    end   
endmodule