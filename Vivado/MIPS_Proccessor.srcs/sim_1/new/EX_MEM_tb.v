`timescale 1ns / 1ps

module EX_MEM_tb;
    reg clk;
    reg rst;
    
    reg [2:0] controlMEM;
    reg [1:0] controlWB;
    reg zeroFlag;
    
    wire controlMEM_Branch;
    wire controlMEM_MemRead;
    wire controlMEM_MemWrite;
    wire [1:0] controlWBOut;
    wire zeroFlagOut;
    
    reg [31:0] addResult;
    reg [31:0] result;
    reg [31:0] readData_rt;
    reg [4:0] RegDstMux;
    
    wire [31:0] npcMEM;
    wire [31:0] addressMemory;
    wire [31:0] writeDataMemory;
    wire [4:0] writeRegister;

    // instantiate
    
    EX_MEM EX_MEM_uut(
        .clk(clk),
        .rst(rst),
        // control input
        .controlMEM(controlMEM),                    // spilt into 3 for MEM stage
        .controlWB(controlWB),
        .zeroFlag(zeroFlag),
        // control output
        .controlMEM_Branch(controlMEM_Branch),      // controlMEM[2]
        .controlMEM_MemRead(controlMEM_MemRead),    // controlMEM[1]
        .controlMEM_MemWrite(controlMEM_MemWrite),  // controlMEM[0]
        .controlWBOut(controlWBOut),                // [RegWrite, MemToReg]
        .zeroFlagOut(zeroFlagOut),
        // input
        .addResult(addResult),                      // EX_MEM_npc
        .result(result),                            // EX_MEM_addressMemory
        .readData_rt(readData_rt),                  // EX_MEM_writeDataMemory
        .RegDstMux(RegDstMux),                      // EX_MEM_writeRegister
        // output
        .npcMEM(npcMEM),
        .addressMemory(addressMemory),
        .writeDataMemory(writeDataMemory),
        .writeRegister(writeRegister)
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
        controlMEM = 3'b000;
        controlWB = 2'b00;
        zeroFlag = 0;
        
        addResult = 32'h0000_0000;
        result = 32'h0000_0000;
        readData_rt = 32'h0000_0000;    
        RegDstMux = 5'b00000;
        
        rst = 0; #10;
        
        controlMEM = 3'b010;
        controlWB = 2'b11;
        zeroFlag = 0;
        
        addResult = 32'hA5A5_A5A5;
        result = 32'hFFFF_FFFF;
        readData_rt = 32'hC3C3_C3C3;
        RegDstMux = 5'b10100;
        #10;
        
        controlMEM = 3'b001;
        controlWB = 2'b0x;
        zeroFlag = 1;
        
        addResult = 32'hD4D4_D4D4;
        result = 32'h0000_0000;
        readData_rt = 32'hB2_B2B2;
        RegDstMux = 5'b01011;
        #10;
               
        $finish;
    end
endmodule