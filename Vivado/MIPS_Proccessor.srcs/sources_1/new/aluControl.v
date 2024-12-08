`timescale 1ns / 1ps

module aluControl(
    input wire[5:0] funct,
    input wire [1:0] ALUOp,
    
    output reg [2:0] ALUControl
    );
    
    // instruction types
    parameter LW_SW = 2'b00;
    parameter BEQ   = 2'b01;
    parameter Rtype = 2'b10;

    always @(funct, ALUOp)
    begin
        case (ALUOp)
            // lw/sw, beq instructions (funct - xxxxxx)
            LW_SW: ALUControl = 3'b010; // lw/sw instructions (add)
            BEQ: ALUControl = 3'b110; // beq instructions (sub)
            
            // r-type instruction (funct - instruction[6:0])
            Rtype:
            begin
                case (funct)
                    6'b100000: ALUControl = 3'b010;  // add
                    6'b100010: ALUControl = 3'b110;  // sub
                    6'b100100: ALUControl = 3'b000;  // and
                    6'b100101: ALUControl = 3'b001;  // or
                    6'b101010: ALUControl = 3'b111;  // slt (Set Less Than), (A < B)
                    default:   ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end
endmodule