`timescale 1ns / 1ps

/*
Determines 9 control bits dependent on opcode (
*/

module control(
    input wire [5:0] opcode,        // instruction[31:26]
    
    output reg [3:0] controlEX,     // [regDst, aluOp[1:0], aluSrc]
    output reg [2:0] controlMEM,    // [Branch, MemRead, MemWrite]
    output reg [1:0] controlWB      // [RegWrite, MemToReg]
    );
    
    parameter r_type = 6'b000000;
    parameter lw     = 6'b100011;
    parameter sw     = 6'b101011;
    parameter beq    = 6'b100100;
    parameter nop    = 6'b100000;
    
    initial
    begin
        controlEX = 0;
        controlMEM = 0;
        controlWB = 0;
    end
    
    // Control signals:
    // {controlEX, controlMEM, controlWB}
    
    // EX signals
    // controlEX[3] - RegDst
    // controlEX[2:1] - ALUOp[1:0]
    // controlEX[0] - ALUSrc
    
    // MEM signals
    // controlMEM[2] - Branch
    // controlMEM[1] - MemRead
    // controlMEM[0] - MemWrite
    
    // WB signals
    // controlWB[1] - MemToReg
    // controlWB[0] - RegWrite
    
    always @(opcode) begin
        case (opcode)
            r_type: begin // R-type instruction (funct - instruction[6:0]) (opcode 0)
                controlEX  = 4'b1100; // RegDst = 1, ALUOp = 10, ALUSrc = 0
                controlMEM = 3'b000;  // Branch = 0, MemRead = 0, MemWrite = 0
                controlWB  = 2'b10;   // RegWrite = 1, MemToReg = 0
            end
            lw: begin // lw (load word) instruction (opcode 35)
                controlEX  = 4'b0001; // RegDst = 0, ALUOp = 00 (add), ALUSrc = 1
                controlMEM = 3'b010;  // Branch = 0, MemRead = 1, MemWrite = 0
                controlWB  = 2'b11;   // RegWrite = 1, MemToReg = 1
            end
            sw: begin // sw (store word) instruction (opcode 43)
                controlEX  = 4'b0001; // RegDst = x, ALUOp = 00 (add), ALUSrc = 1
                controlMEM = 3'b001;  // Branch = 0, MemRead = 0, MemWrite = 1
                controlWB  = 2'b00;   // RegWrite = 0, MemToReg = x
            end
            beq: begin // beq (branch if equal) instruction (opcode 4)
                controlEX  = 4'b0010; // RegDst = x, ALUOp = 01 (sub), ALUSrc = 0
                controlMEM = 3'b100;  // Branch = 1, MemRead = 0, MemWrite = 0
                controlWB  = 2'b00;   // RegWrite = 0, MemToReg = x
            end
            nop: begin // nop (no operation) instruction (opcode 32)
                controlEX  = 4'b0000; // RegDst = 0, ALUOp = 00 (add), ALUSrc = 0
                controlMEM = 3'b000;  // Branch = 0, MemRead = 0, MemWrite = 0
                controlWB  = 2'b00;   // RegWrite = 0, MemToReg = 0
            end
            default: begin // unsupported opcodes
                controlEX  = 4'b0000;
                controlMEM = 3'b000;
                controlWB  = 2'b00;
            end
        endcase
    end
endmodule