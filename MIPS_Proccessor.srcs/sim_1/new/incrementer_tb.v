`timescale 1ns / 1ps

module incrementer_tb;
    
    reg [31:0] pc;          // input
    wire [31:0] next_pc;    // output

    // instantiate
    incrementer incrementer_uut(
        .pc(pc),
        .next_pc(next_pc)
    );

    initial 
    begin
        $monitor("time = %t, pc = %h, next_pc = %h", $time, pc, next_pc);
        
        pc = 32'h0000_0000; #10; // npc = 0000_0001       
        pc = 32'h0000_0001; #10; // npc = 0000_0002      
        pc = 32'h0000_000A; #10; // npc = 0000_000B      
        pc = 32'hFFFF_FFFE; #10; // npc = FFFF_FFFF
        pc = 32'hFFFF_FFFF; #10; // npc = 0000_0000
               
        $finish;
    end

endmodule
