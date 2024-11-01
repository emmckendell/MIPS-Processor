`timescale 1ns / 1ps

/*
Implements a multiplexer that selects from two inputs
a and b, based on the sel input.
*/

module mux(
    input wire [31:0] a, b, // input a = 1'b1, b = 1'b0
    input wire sel,         // select, single bit
    output wire [31:0] y    // output of mux
    );
    
    // if sel = 1, then y = a
    // if sel = 0, then y = b
    assign y = sel ? a : b;  // the type after assign must be WIRE
endmodule