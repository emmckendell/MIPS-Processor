`timescale 1ns / 1ps

/*
Test the mux module, refer to mux.v
*/

module mux_tb;
    // inputs
    reg [31:0] a, b;
    reg sel;
    
    wire [31:0] y;  // output
    
    // instantiate the Unit Under Test (UUT)
    mux mux_uut(
        .y(y),  //.UUT_var(Testbench_var), Testbench_var PASS the values into the UUT_var
        .a(a),
        .b(b),
        .sel(sel)
        );
        
    // initial is typically for testbenches
    initial 
    // initialize inputs, all inputs must be REGISTERS!
    begin
        a = 32'hAAAA_AAAA;  // time = 1
        b = 32'h5555_5555;
        sel = 1'b1;         // at time = 1 y should be AAAA_AAAA
        #10;                // delay 10 ticks on clock, "increase time by 10 ticks"
                            // time = 11
        a = 32'h0000_0000;  // sel has not changed; at time = 11 y should be = a = 0000_0000
        #10;                // time = 21
        
        sel = 1'b1;         // sel = 1, same value as a
        #10;                // time = 21
        
        b = 32'hFFFF_FFFF;
        #5;                 // time 36
        
        a = 32'hA5A5_A5A5;  // at time = 36, y = A5A5_A5A5
        #5;                 // time = 41
        
        sel = 1'b0;         // sel = 0;
        b = 32'hDDDD_DDDD;  // at time = 41, y = DDDD_DDDD, 
                            // so tricky run lines, wipe data until delay
        #5;                 // time = 46
        
        sel = 1'bx; #20;    // x exists in hex, and deci as well; x indicates don't care condition
        $finish;
    end
    
    always @(a or b or sel)
        #1 $display("t = %0d, sel = %b, a = %h, b = %h, y = %h",
        $time, sel, a, b, y);   
endmodule
