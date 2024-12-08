`timescale 1ns / 1ps

module IF_ID_tb;    
    reg clk;
    reg rst;
    
    reg [31:0] nextProgramCount;
    reg [31:0] instruction;
    
    wire [31:0] npcIDOut;
    wire [31:0] instructionOut;

    // instantiate
    
    IF_ID IF_ID_uut(
        .clk(clk),
        .rst(rst),
        // input
        .nextProgramCount(nextProgramCount),
        .instruction(instruction),
        // output
        .npcIDOut(npcIDOut),
        .instructionOut(instructionOut)
    );

    // clock
    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk; // 5 time units
    end

    initial 
    begin       
        rst = 1;
        nextProgramCount = 32'h0000_0000;
        instruction = 32'h0000_0000;
        #10;
        
        rst = 0; #10;
        
        nextProgramCount = 32'h0000_00040; 
        instruction = 32'hA000_000A;
        #10;
        
        nextProgramCount = 32'h0000_0050; 
        instruction = 32'h9000_0009;
        #10;
        
        nextProgramCount = 32'h0000_0003; 
        instruction = 32'h9000_0099;
        #10;
        
        $finish;
    end
endmodule