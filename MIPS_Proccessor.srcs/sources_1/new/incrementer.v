`timescale 1ns / 1ps

module incrementer(
    input [31:0] ProgramCount,
    output [31:0] nextProgramCount
    );
    
    // for byte addressable
    // assign nextProgramCount = ProgramCount + 4;
    
    // for word addressable
    assign nextProgramCount = ProgramCount + 1;
       
endmodule