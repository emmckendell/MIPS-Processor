`timescale 1ns / 1ps

module MEM_WB_tb;
    reg clk;
    reg rst;
    
    reg [1:0] controlWB;
    
    wire controlWB_RegWrite;
    wire controlWB_MemToReg;
    
    reg [31:0] readData_mem;
    reg [31:0] addressMemory;
    reg [4:0] writeRegister;

    wire [31:0] readData_memOut;
    wire [31:0] addressMemoryOut;
    wire [4:0] writeRegisterOut;

    // instantiate
    
    MEM_WB MEM_WB_uut (
        .clk(clk),
        .rst(rst),
        .controlWB(controlWB),                      // [RegWrite, MemToReg]
        .controlWB_RegWrite(controlWB_RegWrite),    // controlWB[1]
        .controlWB_MemToReg(controlWB_MemToReg),    //control[0]
        .readData_mem(readData_mem),
        .addressMemory(addressMemory),
        .writeRegister(writeRegister),
        .readData_memOut(readData_memOut),
        .addressMemoryOut(addressMemoryOut),
        .writeRegisterOut(writeRegisterOut)
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
        controlWB = 2'b00;
        readData_mem = 32'h0000_0000;
        addressMemory = 32'h0000_00000;
        writeRegister = 5'd0;       
        #10;
        
        rst = 0; #10;
        
        controlWB = 2'b10;
        readData_mem = 32'hA5A5_A5A5;
        addressMemory = 32'hC3C3_C3C3;
        writeRegister = 5'd1;       
        #10;
        
        controlWB = 2'b11;
        readData_mem = 32'hB2B2_B2B2;
        addressMemory = 32'hD4D4_D4D4;
        writeRegister = 5'd2;       
        #10;
        
        $finish;
    end
endmodule

