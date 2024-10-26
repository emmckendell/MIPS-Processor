`timescale 1ns / 1ps

module instructionMemory(
    input clk,
    output reg [31:0] data,     // output of instruction memory
    input wire [31:0] address   // input of instruction memory
    );
    
    // register declarations
    reg [31:0] Memory[0:127];   // 128 words of 32-bit memory
    
    initial 
    begin
        Memory[0] <= 'hA000_00AA;
        Memory[1] <= 'h1000_0011;
        Memory[2] <= 'h2000_0022;
        Memory[3] <= 'h3000_0033;
        Memory[4] <= 'h4000_0044;
        Memory[5] <= 'h5000_0055;
        Memory[6] <= 'h6000_0066;
        Memory[7] <= 'h7000_0077;
        Memory[8] <= 'h8000_0088;
        Memory[9] <= 'h9000_0099;
    end
    
    always @(posedge clk) data <= Memory[address];      
endmodule
