`timescale 1ns / 1ps

module incrementer(
    input [31:0] pc,
    output [31:0] next_pc
    );
    
    // assign next_pc = pc + 4; // for byte addressable
    assign next_pc = pc + 1;    // for word addressable
endmodule
