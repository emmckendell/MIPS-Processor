`timescale 1ns / 1ps

module control_tb;    
    reg [5:0] opcode;
    
    wire [3:0] controlEX;   // [regDst, aluOp[1:0], aluSrc]
    wire [2:0] controlMEM;  // [Branch, MemRead, MemWrite]
    wire [1:0] controlWB;   // [RegWrite, MemToReg]
    
    // instantiate
    
    control control_uut(
        // input
        .opcode(opcode),
        // output
        .controlEX(controlEX),
        .controlMEM(controlMEM),
        .controlWB(controlWB)
    );

    initial 
    begin        
        // R-type instruction (opcode 0)
        opcode = 6'b000000; #10;
        // expected: controlEX = 4'b1100, controlMEM = 3'b000, controlWB = 2'b10

        // lw (load word) instruction (opcode 35)
        opcode = 6'b100011; #10;
        // Expected: controlEX = 4'b0001, controlMEM = 3'b010, controlWB = 2'b11

        // sw (store word) instruction (opcode 43)
        opcode = 6'b101011; #10;
        // Expected: controlEX = 4'bx001, controlMEM = 3'b001, controlWB = 2'b0x

        // beq (branch if equal) instruction (opcode 4)
        opcode = 6'b000100; #10;
        // Expected: controlEX = 4'bx010, controlMEM = 3'b100, controlWB = 2'b0x

        // unsupported opcode
        opcode = 6'b111111; #10;
        // Expected: controlEX = 4'bxxxx, controlMEM = 3'bxxx, controlWB = 2'bxx
        
        $finish;
    end
endmodule