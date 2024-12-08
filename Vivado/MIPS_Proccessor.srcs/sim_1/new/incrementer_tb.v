`timescale 1ns / 1ps

module incrementer_tb;    
    reg [31:0] ProgramCount;
    wire [31:0] nextProgramCount;

    // instantiate
    incrementer incrementer_uut(
        // input
        .ProgramCount(ProgramCount),
        // output
        .nextProgramCount(nextProgramCount)
    );

    initial
    begin
        $monitor("Time = %0t, ProgramCount = %h, nextProgramCount = %h", 
        $time, ProgramCount, nextProgramCount);
        
        ProgramCount = 32'h0000_0000; #10;
        // Expected: nextProgramCount = 0000_0001
               
        ProgramCount = 32'h0000_0001; #10;
        // Expected: nextProgramCount = 0000_0002
              
        ProgramCount = 32'h0000_000A; #10;
        // Expected: nextProgramCount = 0000_000B
        
        ProgramCount = 32'h0000_000F; #10;
        // Expected: nextProgramCount = 0000_0010
        
        ProgramCount = 32'hFFFF_FFFE; #10;
        // Expected: nextProgramCount = FFFF_FFFF
        
        ProgramCount = 32'hFFFF_FFFF; #10;
        // Expected: nextProgramCount = 0000_0000
               
        $finish;
    end
endmodule