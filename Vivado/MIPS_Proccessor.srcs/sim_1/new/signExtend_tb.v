`timescale 1ns / 1ps

module signExtend_tb;
    reg [15:0] inUnextend_16b;  
    wire [31:0] outExtend_32b;
    
    // instantiate
    
    signExtend signExtend_uut(
        .inUnextend_16b(inUnextend_16b),    // input
        .outExtend_32b(outExtend_32b)       // output
    );
    
    initial 
    begin
        $monitor("Time = %0t, inUnextend_16b = %b, outExtend_32b = %b", 
        $time, inUnextend_16b, outExtend_32b);
        
        // extend 0's
        inUnextend_16b = 16'b0111_1111_1111_1111; #10;
//   32'b0000_0000_0000_0000_0111_1111_1111_1111;
        
        // extend 1's
        inUnextend_16b = 16'b1000_0000_0000_0000; #10;
//   32'b1111_1111_1111_1111_1000_0000_0000_0000;
        
        $finish;
    end
endmodule