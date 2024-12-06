`timescale 1ns / 1ps

module programCounter(
    input clk,
    input rst,
    
    input wire [31:0] nextProgramCount,
    output reg [31:0] ProgramCount
    );
    
    initial 
    begin
        ProgramCount <= 0;
    end
    
    always @(posedge clk) 
    begin
        if(rst)
            ProgramCount <= 0;
        else
            // non-blocking assignment
            ProgramCount <= nextProgramCount;
    end   
endmodule