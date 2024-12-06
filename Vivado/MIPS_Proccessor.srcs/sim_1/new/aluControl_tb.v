`timescale 1ns / 1ps

module aluControl_tb;
    reg [5:0] funct;
    reg [1:0] ALUOp;
    wire [2:0] ALUControl;

    // instantiate
    
    aluControl aluControl_uut(
        .funct(funct),          // input
        .ALUOp(ALUOp),          // control
        .ALUControl(ALUControl) // output
    );
    
    initial 
    begin
        // lw/sw instructions (ALUOp = 00)
        ALUOp = 2'b00; funct = 6'bxxxxxx; #10;  
        // Expected ALUControl = 010 (add)

        // beq instructions (ALUOp = 01)
        ALUOp = 2'b01; funct = 6'bxxxxxx; #10;  
        // Expected ALUControl = 110 (sub)

        // R-type instructions (ALUOp = 10)
        ALUOp = 2'b10; funct = 6'b100000; #10; // add: Expected ALUControl = 010
        ALUOp = 2'b10; funct = 6'b100010; #10; // sub: Expected ALUControl = 110
        ALUOp = 2'b10; funct = 6'b100100; #10; // and: Expected ALUControl = 000
        ALUOp = 2'b10; funct = 6'b100101; #10; // or:  Expected ALUControl = 001
        ALUOp = 2'b10; funct = 6'b101010; #10; // slt: Expected ALUControl = 111

        // unknown funct code
        ALUOp = 2'b10; funct = 6'b111111; #10; // Expected ALUControl = xxx
        ALUOp = 2'b10; funct = 6'b111111; #10; // Expected ALUControl = xxx
        
        // unknown ALUOp
        ALUOp = 2'b11; funct = 6'b100000; #10; // Expected ALUControl = xxx
        
        $finish;
    end
endmodule