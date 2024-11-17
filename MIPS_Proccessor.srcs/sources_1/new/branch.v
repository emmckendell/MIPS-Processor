`timescale 1ns / 1ps

module branch(
    input wire a,
    input wire b,
    
    output wire y
    );
    
    // and gate: (y = a & b)
    and (y, a, b);
endmodule