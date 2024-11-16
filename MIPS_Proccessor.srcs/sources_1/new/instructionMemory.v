`timescale 1ns / 1ps

module instructionMemory(
    input clk,
    input rst,
    
    input wire [31:0] address,
    
    output reg [31:0] data
    );
    
    reg [31:0] Memory[0:127];   // 128 words of 32-bit memory
    
    initial 
    begin
        
        // Machine code, create an assembler to write the MIPS ISA
        // add up to 127 instructions
        
        Memory[0]  <= 'h0000_0000;
        Memory[1]  <= 'h1000_0011;
        Memory[2]  <= 'h2000_0022;
        Memory[3]  <= 'h3000_0033;
        Memory[4]  <= 'h4000_0044;
        Memory[5]  <= 'h5000_0055;
        Memory[6]  <= 'h6000_0066;
        Memory[7]  <= 'h7000_0077;
        Memory[8]  <= 'h8000_0088;
        Memory[9]  <= 'h9000_0099;
        Memory[10] <= 'hA000_00AA;
        Memory[11] <= 'hB000_00BB;
        Memory[12] <= 'hC000_00CC;
        Memory[13] <= 'hD000_00DD;
        Memory[14] <= 'hE000_00EE;
        Memory[15] <= 'hF000_00FF;
        
        // Memory[n]
        // . . .
        // Memory[127]
    end
    
    always @(posedge clk) 
    begin
        if(rst)
            data <= 0;
        else
            data <= Memory[address];    
    end  
endmodule