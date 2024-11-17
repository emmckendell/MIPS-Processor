`timescale 1ns / 1ps

module dataMemory(
    input clk,
    input rst,
    
    input wire MemWrite,
    input wire MemRead,
    
    input wire [31:0] addressMemory,
    input wire [31:0] writeDataMemory,
    
    output reg [31:0] readData_mem
    );
    
    // add stuff
    
endmodule