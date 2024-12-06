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
        
//        instruction[0]  <= 32'h0000_0000;
//        instruction[1]  <= 32'h1000_0001;
//        instruction[2]  <= 32'h2000_0002;
//        instruction[3]  <= 32'h3000_0003;
//        instruction[4]  <= 32'h4000_0004;
//        instruction[5]  <= 32'h5000_0005;
//        instruction[6]  <= 32'h6000_0006;
//        instruction[7]  <= 32'h7000_0007;
//        instruction[8]  <= 32'h8000_0008;
//        instruction[9]  <= 32'h9000_0009;
//        instruction[10] <= 32'hA000_000A;
//        instruction[11] <= 32'hB000_000B;
//        instruction[12] <= 32'hC000_000C;
//        instruction[13] <= 32'hD000_000D;
//        instruction[14] <= 32'hE000_000E;
//        instruction[15] <= 32'hF000_000F;
        
        // instruction[n]
        // . . .
        // instruction[127]
        
        // $readmemh("instructionSet1.mem", instruction);
        $readmemb("instructionSet2.mem", instruction);     
    end
    
    always @(posedge clk) 
    begin
        if(rst)
            data <= 0;
        else
            data <= instruction[address[7:0]];    
    end  
endmodule