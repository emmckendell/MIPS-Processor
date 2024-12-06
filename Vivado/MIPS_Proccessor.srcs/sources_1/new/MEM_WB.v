`timescale 1ns / 1ps

module MEM_WB(
    input clk,
    input rst,
    
    // control input
    input wire [1:0] controlWB,     // [RegWrite, MemToReg]
    
    // control output
    output reg controlWB_RegWrite,  // control[1]
    output reg controlWB_MemToReg,  // contro[0]
    
    // input
    input wire [31:0] readData_mem,
    input wire [31:0] addressMemory,
    input wire [4:0] writeRegister,
    
    // output
    output reg [31:0] readData_memOut,
    output reg [31:0] addressMemoryOut,
    output reg [4:0] writeRegisterOut
    );
    
    initial
    begin
        controlWB_RegWrite <= 0;
        controlWB_MemToReg <= 0;
        
        readData_memOut <= 0;
        addressMemoryOut <= 0;
        writeRegisterOut <= 0;
    end
    
    always @(posedge clk)
    begin
        if(rst)
        begin
            controlWB_RegWrite <= 0;    // control[1]
            controlWB_MemToReg <= 0;    // control[0]
            
            readData_memOut <= 0;
            addressMemoryOut <= 0;
            writeRegisterOut <= 0;
        end
        else
        begin
            controlWB_RegWrite <= controlWB[1];
            controlWB_MemToReg <= controlWB[0];
            
            readData_memOut <= readData_mem;
            addressMemoryOut <= addressMemory;
            writeRegisterOut <= writeRegister;       
        end
    end
endmodule