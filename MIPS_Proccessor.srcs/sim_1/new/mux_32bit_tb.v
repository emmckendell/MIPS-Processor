`timescale 1ns / 1ps

module mux_32bit_tb;
    reg [31:0] a, b;
    reg sel;
    
    wire [31:0] y;
    
    // instantiate
    
    mux mux_uut(
        // input
        .a(a),
        .b(b),
        // control
        .sel(sel),
        // output
        .y(y)
        );
    
    initial
    begin
        a = 32'hAAAA_AAAA;
        b = 32'hBBBB_BBBB;
        sel = 1'b1;
        #10;
        
        a = 32'h0000_0000;  #10;
        // Expected: y = a = 32'h0000_0000
        
        sel = 1'b0; #10;
        // Expected y = b = 32'hBBBB_BBBB
        
        b = 32'hFFFF_FFFF; #10;
        // Expected y = b = 32'hFFFF_FFFF
        
        a = 32'hA5A5_A5A5; #10;
        // Expected y = b = 32'hFFFF_FFFF
        
        sel = 1'b0;
        b = 32'hDDDD_DDDD; #10;
        // Expected y = b = 32'hDDDD_DDDD       
        
        sel = 1'bx; #10;
        // Expected y = x = 32'hxxxx_xxxx
        
        $finish;
    end 
endmodule
