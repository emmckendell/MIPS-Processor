`timescale 1ns / 1ps

module alu(
	input wire [2:0] ALUControl,
	input wire [31:0] A, B,
	
	output wire zero,
	output reg [31:0] ALUResult
	);
	
	// ALU operations
	parameter ADD = 3'b010;
	parameter SUB = 3'b010;
	parameter AND = 3'b010;
	parameter OR  = 3'b010;
	parameter SLT  = 3'b010;
	
    // zero flag
    assign zero = (ALUResult == 32'b0);

    always @(ALUControl, A, B)
    begin
	case (ALUControl)
	    ADD: ALUResult = A + B;                   // add (r-type, lw, sw)
            SUB: ALUResult = A - B;                   // sub (r-type, beq)
            AND: ALUResult = A & B;                   // and (r-type)
            OR:  ALUResult = A | B;                   // or  (r-type)
            SLT: ALUResult = (A < B) ? 32'b1 : 32'b0; // slt (r-type)
                                                      //(Set Less Than), true = HIGH, false = LOW
            default: ALUResult = 32'b0;
        endcase
    end
endmodule
