`timescale 1ns / 1ps

module branch(
    // AND gate
    // y = a & b
    
    input wire a,
    input wire b,
    
    output wire y
    );
    
    assign y = a & b;
endmodule