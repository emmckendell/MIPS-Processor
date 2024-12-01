`timescale 1ns / 1ps

module branch_tb;
    // AND gate
    // y = a & b
    reg a;
    reg b;
    
    wire y;
    
    branch branch_INST(
        .a(a), 
        .b(b), 
        .y(y)
    );
    
    initial
    begin
        $monitor("Time = %0t, a = %b, b = %b, y = %b", 
        $time, a, b, y);
        
        // y = a & b
        a = 0; b = 0; #10;  // y = 0 & 0 = 0
        a = 0; b = 1; #10;  // y = 0 & 1 = 0
        a = 1; b = 0; #10;  // y = 1 & 0 = 0
        a = 1; b = 1; #10;  // y = 1 & 1 = 1
        
        $finish;
    end
endmodule