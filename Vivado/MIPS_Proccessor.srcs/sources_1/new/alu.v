`timescale 1ns / 1ps

module alu(
	input wire [2:0] ALUControl,
	input wire [31:0] A, B,
	
	output wire zero,
	output reg [31:0] ALUResult
	);

    // zero flag
	assign zero = (ALUResult == 32'b0);
    
    always @(ALUControl, A, B)
    begin
		case (ALUControl)
			3'b010: ALUResult = A + B;                      // add
            3'b110: ALUResult = A - B;                      // sub
            3'b000: ALUResult = A & B;                      // and
            3'b001: ALUResult = A | B;                      // or
            3'b111: ALUResult = (A < B) ? 32'b1 : 32'b0;    // slt (Set Less Than), true = HIGH, false = LOW
            default: ALUResult = 32'b0;
        endcase
    end
endmodule