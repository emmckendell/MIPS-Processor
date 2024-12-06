`timescale 1ns / 1ps

module alu_tb;
    reg [2:0] ALUControl;
    reg [31:0] A;
    reg [31:0] B;
    
    wire zero;
    wire [31:0] ALUResult;
    
    // instantiate
    alu alu_uut(
        // input
        .ALUControl(ALUControl),
        .A(A),
        .B(B),
        // control
        .zero(zero),
        // output
        .ALUResult(ALUResult)
    );
    
    initial 
        begin       
        // add
        A = 32'd5; B = 32'd4; ALUControl = 3'b010; #10;
        
        // add (Zero Result)
        A = 32'd0; B = 32'd0; ALUControl = 3'b010; #10;
        
        // sub (Positive Result)
        A = 32'd5; B = 32'd4; ALUControl = 3'b110; #10;
        
        // sub (Negative Result)
        A = 32'd4; B = 32'd5; ALUControl = 3'b110; #10;
        
        // sub (Zero Result), check zero flag
        A = 32'd10; B = 32'd10; ALUControl = 3'b110; #10; // A - B = 0
        
        // and
        A = 32'hFFFF_0F00; B = 32'hFFFF_F000; ALUControl = 3'b000; #10;
        
        // or
        A = 32'hFFFF_0F00; B = 32'hFFFF_F000; ALUControl = 3'b001; #10;
            
        // slt: set less than
        // slt (A < B)? (A less than B), false
        A = 32'd6; B = 32'd8; ALUControl = 3'b111; #10;

        // slt (A < B)? (A greater than B), true
        A = 32'd8; B = 32'd6; ALUControl = 3'b111; #10;
        
        // slt (A < B)? (A equal to B), true
        A = 32'd6; B = 32'd6; ALUControl = 3'b111; #10;
        $finish;
    end
endmodule