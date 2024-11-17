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
        .addResult(addResult),
        .result(result),
        .readData_rt(readData_rt),                  // second register
        .RegDstMux(RegDstMux),
        // output
        .npcMEM(npcMEM),
        .addressMemory(addressMemory),
        .writeDataMemory(writeDataMemory),
        .writeRegister(writeRegister)
    );

    // clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 5 time units
    end
    
    initial 
    begin
        rst = 1; controlMEM = 3'b000; controlWB = 2'b00;
        zeroFlag = 0; addResult = 32'h0000_0000; result = 32'h0000_0000;
        readData_rt = 32'h0000_0000; RegDstMux = 5'b00000;
        
        // Apply reset
        #10 rst = 0;

        // Apply test case 1
        #10;
        controlMEM = 3'b101;      // Branch = 1, MemRead = 0, MemWrite = 1
        controlWB = 2'b10;        // RegWrite = 1, MemToReg = 0
        zeroFlag = 1;
        addResult = 32'h1234_5678;
        result = 32'hDEAD_BEEF;
        readData_rt = 32'h8765_4321;
        RegDstMux = 5'b10101;

        // Test case 2
        #10;
        controlMEM = 3'b011;      // Branch = 0, MemRead = 1, MemWrite = 1
        controlWB = 2'b01;        // RegWrite = 0, MemToReg = 1
        zeroFlag = 0;
        addResult = 32'hABCD_1234;
        result = 32'hCAFEBABE;
        readData_rt = 32'h1234_5678;
        RegDstMux = 5'b11011;

        // Test case 3: Reset during operation
        #10 rst = 1;
        #10 rst = 0;

        // End simulation
        #50;
        $stop;
    end

endmodule