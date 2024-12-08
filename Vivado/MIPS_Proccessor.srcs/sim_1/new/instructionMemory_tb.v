`timescale 1ns / 1ps

module instructionMemory_tb;
    reg clk;
    reg rst;
    reg [31:0] address;
    
    wire [31:0] data;

    // instantiate
    instructionMemory instructionMemory_uut (
        .clk(clk),
        .rst(rst),
        .address(address),  // input
        .data(data)         // output
    );

    // clock
    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk;  // 5 time units
    end

    initial 
    begin
        $monitor("Time = %0t, clk = %b, rst = %b, address = %h, data = %h", 
        $time, clk, rst, address, data);
        
        rst = 1;
        address = 0;
        #10;

        rst = 0;

        address = 0; #20;  
        address = 1; #20;
        address = 2; #20;
        address = 3; #20;
        address = 4; #20;

        rst = 1; #20; 
        
        $finish;
    end
endmodule