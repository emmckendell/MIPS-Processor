`timescale 1ns / 1ps

module WRITE_BACK_tb;
    reg clk;
    reg rst;
    reg MEM_WB_controlWB_RegWrite;
    reg MEM_WB_controlWB_MemToReg;
    
    wire WB_controlWB_RegWrite;
    
    reg [31:0] MEM_WB_readData_mem;
    reg [31:0] MEM_WB_addressMemory;
    reg [4:0] MEM_WB_writeRegister;
    
    wire [4:0] WB_writeRegister;
    wire [31:0] WB_writeDataRegister;

    // instantiate
    
    WRITE_BACK WRITE_BACK_uut (
        .clk(clk),
        .rst(rst),
        // control input
        .MEM_WB_controlWB_RegWrite(MEM_WB_controlWB_RegWrite),
        .MEM_WB_controlWB_MemToReg(MEM_WB_controlWB_MemToReg),
        // control output
        .WB_controlWB_RegWrite(WB_controlWB_RegWrite),
        // input
        .MEM_WB_readData_mem(MEM_WB_readData_mem),
        .MEM_WB_addressMemory(MEM_WB_addressMemory),
        .MEM_WB_writeRegister(MEM_WB_writeRegister),
        // output
        .WB_writeRegister(WB_writeRegister),
        .WB_writeDataRegister(WB_writeDataRegister)
    );

    // clock
    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk;  // 5 time units
    end
    
    initial 
    begin
        rst = 1;
        MEM_WB_controlWB_RegWrite = 0;
        MEM_WB_controlWB_MemToReg = 0;
        MEM_WB_readData_mem = 32'h0000_0000;
        MEM_WB_addressMemory = 32'h0000_0000;
        MEM_WB_writeRegister = 5'd0;
        #10;
        
        rst = 0; #10;
        
        // r-type (e.g add, sub) instruction
        MEM_WB_controlWB_RegWrite = 1;
        MEM_WB_controlWB_MemToReg = 0;
        MEM_WB_readData_mem = 32'hA5A5_A5A5;
        MEM_WB_addressMemory = 32'hB4B4_B4B4;
        MEM_WB_writeRegister = 5'd1;
        #10;
        
        // load (lw) instruction
        MEM_WB_controlWB_RegWrite = 1;
        MEM_WB_controlWB_MemToReg = 1;
        MEM_WB_readData_mem = 32'hC3C3_C3C3;
        MEM_WB_addressMemory = 32'hD2D2_D2D2;
        MEM_WB_writeRegister = 5'd2;
        #10;
        
        // store (sw) instruction / branch (beq) instruction
        MEM_WB_controlWB_RegWrite = 0;
        MEM_WB_controlWB_MemToReg = 0;
        MEM_WB_readData_mem = 32'hE1E1_E1E1;
        MEM_WB_addressMemory = 32'hF0F0_F0F0;
        MEM_WB_writeRegister = 5'd3;
        #10;
        
        $finish;
    end
endmodule