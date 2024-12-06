`timescale 1ns / 1ps

module mux_32bit(
    input wire [31:0] a, b,
    input wire sel,
    output wire [31:0] y
    );
    
    // if sel = 1, then y = a
    // if sel = 0, then y = b
    
    assign y = sel ? a : b;  // must use WIRE assignment in instantiations
endmodule
