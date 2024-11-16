`timescale 1ns / 1ps

module aluControl(
    input [5:0] funct,
    input [1:0] ALUOp,
    output reg [2:0] ALUControl
    );
    
    // Instructions ALU Control Signals:
    // ALUOp, funct, ALUControl
    
    // lw,      lw, add:    00_xxxxxx_010
    // sw,      sw, add:    00_xxxxxx_010
    
    // beq,    beq, sub:    01_xxxxxx_110
    
    // R-type, add, add:    10_100000_010
    // R-type, sub, sub:    10_100010_110
    // R-type, and, and:    10_100100_000
    // R-type,  or,  or:    10_100101_001
    // R-type, slt, slt:    10_101010_111

    always @(funct, ALUOp) 
    begin
        case (ALUOp)
            2'b00: ALUControl = 3'b010; // lw/sw instructions (add)
            2'b01: ALUControl = 3'b110; // beq instructions (sub)
            2'b10: 
            begin                // R-type instructions
                case (funct)
                    6'b100000: ALUControl = 3'b010;  // add
                    6'b100010: ALUControl = 3'b110;  // sub
                    6'b100100: ALUControl = 3'b000;  // and
                    6'b100101: ALUControl = 3'b001;  // or
                    6'b101010: ALUControl = 3'b111;  // slt (Set Less Than), (A < B)
                    default:   ALUControl = 3'bxxx;
                endcase
            end
            default: ALUControl = 3'bxxx;
        endcase
    end
endmodule