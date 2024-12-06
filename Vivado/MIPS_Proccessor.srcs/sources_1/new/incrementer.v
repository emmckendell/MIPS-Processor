`timescale 1ns / 1ps

module incrementer(
    input wire [31:0] ProgramCount,
    
    output wire [31:0] nextProgramCount
    );
    
    // for byte addressable
    // assign nextProgramCount = ProgramCount + 4;
    
    // for word addressable
    assign nextProgramCount = ProgramCount + 1;      
endmodule