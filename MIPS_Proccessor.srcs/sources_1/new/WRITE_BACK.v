`timescale 1ns / 1ps

module WRITE_BACK(
    input clk,
    input rst,
    
    input wire MEM_WB_controlWB_RegWrite,       // controlWB[1]
    input wire MEM_WB_controlWB_MemToReg,       // controlWB[0]
       
    input wire [31:0] MEM_WB_readData_mem,
    input wire [31:0] MEM_WB_addressMemory,
    input wire [4:0] MEM_WB_writeRegister,
    
    output wire WB_controlWB_RegWrite,
    
    output wire [4:0] WB_writeRegister,
    output wire [31:0] WB_writeDataRegister
    );
    
    assign WB_controlWB_RegWrite = MEM_WB_controlWB_RegWrite;   // controlWB[1]
    assign WB_writeRegister = MEM_WB_writeRegister;
    
    // instantiations
    
    mux_32bit mux_32bit_ALUSrc_INST(
        // input: a = 1, b = 0
        
        // input
        .a(MEM_WB_readData_mem),
        .b(MEM_WB_addressMemory),
        // control
        .sel(MEM_WB_controlWB_MemToReg),    // controlWB[0]
        // output
        .y(WB_writeDataRegister)
        );
endmodule