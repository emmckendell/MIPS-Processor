`timescale 1ns / 1ps

module programCounter(
    input clk,
    input rst,
    input wire [31:0] npc,  // input of_mod
    output reg [31:0] pc   // output of pc_mod
    );
    
    initial 
    begin
        pc <= 0;
    end
    
    always @(posedge clk) 
    begin
        if(rst)
            pc <= 0;
        else
            pc <= npc;          // non-blocking assignment for pc = npc
    end
      
endmodule