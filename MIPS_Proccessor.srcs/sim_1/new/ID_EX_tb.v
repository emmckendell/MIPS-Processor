`timescale 1ns / 1ps

module ID_EX_tb;
    reg clk;
    reg rst;
    
    reg [3:0] controlEX;
    reg [2:0] controlMEM;
    reg [1:0] controlWB;
    
    wire controlEX_RegDst;
    wire [1:0] controlEX_ALUOp;
    wire controlEX_ALUSrc;
    
    wire [2:0] controlMEMOut;
    wire [1:0] controlWBOut;
    
    reg [31:0] nextProgramCount;
    reg [31:0] readData_rs, readData_rt;
    reg [31:0] instructionSignExtend_15_0;
    reg [5:0] instruction_20_16, instruction_15_11;
    
    wire [31:0] npcEXOut;
    wire [31:0] readData_rsOut, readData_rtOut;
    wire [31:0] instructionSignExtend_15_0_Out;
    wire [5:0] instruction_20_16_Out, instruction_15_11_Out;
    
    // instantiate
    
    ID_EX ID_EX_uut(
        .clk(clk),
        .rst(rst),
        // control input
        .controlEX(controlEX),                  // spilt into 3 for EX stage
        .controlMEM(controlMEM),
        .controlWB(controlWB),
        // control output
        .controlEX_RegDst(controlEX_RegDst),    // controlEX[3]
        .controlEX_ALUOp(controlEX_ALUOp),      // controlEX[2:1]
        .controlEX_ALUSrc(controlEX_ALUSrc),    // controlEX[0]
        .controlMEMOut(controlMEMOut),          // [Branch, MemRead, MemWrite]
        .controlWBOut(controlWBOut),            // [RegWrite, MemToReg]
        // input
        .nextProgramCount(nextProgramCount),
        .readData_rs(readData_rs),
        .readData_rt(readData_rt),
        .instructionSignExtend_15_0(instructionSignExtend_15_0),
        .instruction_20_16(instruction_20_16),
        .instruction_15_11(instruction_15_11),
        // output
        .npcEXOut(npcEXOut),
        .readData_rsOut(readData_rsOut),
        .readData_rtOut(readData_rtOut),
        .instructionSignExtend_15_0_Out(instructionSignExtend_15_0_Out),
        .instruction_20_16_Out(instruction_20_16_Out),
        .instruction_15_11_Out(instruction_15_11_Out)
    );

    // clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 5 time units
    end
    
    initial 
    begin      
        rst = 1; 
        controlEX = 4'b0000;
        controlMEM = 4'b000;
        controlWB = 4'b00;
        
        nextProgramCount = 32'h0000_0000; 
        readData_rs = 32'h0000_0000; 
        readData_rt = 32'h0000_0000;
        instructionSignExtend_15_0 = 32'h0000_0000; 
        instruction_20_16 = 6'b000000; 
        instruction_15_11 = 6'b000000;
        #10;
        
        rst = 0; #10;
        
        // R-type instruction (e.g., add, sub) (opcode 0)
        controlEX = 4'b1100;
        controlMEM = 3'b000;
        controlWB = 2'b10;
        
        nextProgramCount = 32'hA000_000A; 
        readData_rs = 32'h1111_1111; 
        readData_rt = 32'h2222_2222;
        
        // only 32'hFFFF_xxxx OR 32'h0000_xxxx
        instructionSignExtend_15_0 = 32'hFFFF_8000;
        
        instruction_20_16 = 6'b101101; 
        instruction_15_11 = 6'b010010;
        #10;
        
        // lw (load word) instruction (opcode 35)
        controlEX = 4'b0001;
        controlMEM = 3'b010;
        controlWB = 2'b11;
        
        nextProgramCount = 32'hC000_000C; 
        readData_rs = 32'h1000_0001; 
        readData_rt = 32'h2000_0002;
        
        // only 32'hFFFF_xxxx OR 32'h0000_xxxx
        instructionSignExtend_15_0 = 32'h0000_EFFF;
        
        instruction_20_16 = 6'b010010; 
        instruction_15_11 = 6'b101101;
        #10;
        
        // sw (store word) instruction (opcode 43)
        controlEX = 4'bx001;
        controlMEM = 3'b001;
        controlWB = 2'b0x;
        #10;
        
        // beq (branch if equal) instruction (opcode 4)
        controlEX = 4'bx010;
        controlMEM = 3'b100;
        controlWB = 2'b0x;
        #10;
        
        $finish;
    end
endmodule