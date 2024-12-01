`timescale 1ns / 1ps

module instructionMemory(
    input clk,
    input rst,
    
    input wire [31:0] address,
    
    output reg [31:0] data
    );
    
    reg [31:0] instruction[0:127];   // 128 words of 32-bit instruction
    
    initial 
    begin
        // Machine code, create an assembler to write the MIPS ISA
        // up to 127 instructions      
        
        instruction[0]  <= 'h0000_0000;
        instruction[1]  <= 'h1000_0011;
        instruction[2]  <= 'h2000_0022;
        instruction[3]  <= 'h3000_0033;
        instruction[4]  <= 'h4000_0044;
        instruction[5]  <= 'h5000_0055;
        instruction[6]  <= 'h6000_0066;
        instruction[7]  <= 'h7000_0077;
        instruction[8]  <= 'h8000_0088;
        instruction[9]  <= 'h9000_0099;
        instruction[10] <= 'hA000_00AA;
        instruction[11] <= 'hB000_00BB;
        instruction[12] <= 'hC000_00CC;
        instruction[13] <= 'hD000_00DD;
        instruction[14] <= 'hE000_00EE;
        instruction[15] <= 'hF000_00FF;
        
        // instruction[n]
        // . . .
        // instruction[127]
        
//        $readmemh("instructions.mem", instruction);     
    end
    
    always @(posedge clk) 
    begin
        if(rst)
            data <= 0;
        else
            data <= instruction[address];    
    end  
endmodule