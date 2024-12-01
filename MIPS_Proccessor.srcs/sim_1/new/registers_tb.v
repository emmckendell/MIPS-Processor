`timescale 1ns / 1ps

module registers_tb;
    reg clk;
    reg rst;
    reg [4:0] rs, rt, rd;
    reg [31:0] writeDataRegister;
    reg RegWrite;
    
    wire [31:0] readData_rs;
    wire [31:0] readData_rt;
    
    wire [31:0] register0,  register1,  register2,  register3,
                register4,  register5,  register6,  register7,
                register8,  register9,  register10, register11,
                register12, register13, register14, register15, 
                register16, register17, register18, register19,
                register20, register21, register22, register23,
                register24, register25, register26, register27,
                register28, register29, register30, register31;
    
    // instantiate
    
    registers registers_uut(
        .clk(clk),
        .rst(rst),
        // input
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .writeDataRegister(writeDataRegister),
        // control
        .RegWrite(RegWrite),
        // output
        .readData_rs(readData_rs),
        .readData_rt(readData_rt),
        
        .register0(register0), .register1(register1), .register2(register2), .register3(register3),
        .register4(register4), .register5(register5), .register6(register6), .register7(register7),
        .register8(register8), .register9(register9), .register10(register10), .register11(register11),
        .register12(register12), .register13(register13), .register14(register14), .register15(register15),
        .register16(register16), .register17(register17), .register18(register18), .register19(register19),
        .register20(register20), .register21(register21), .register22(register22), .register23(register23),
        .register24(register24), .register25(register25), .register26(register26), .register27(register27),
        .register28(register28), .register29(register29), .register30(register30), .register31(register31)
    );

    // clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 5 time units
    end
    
    initial 
    begin        
        rst = 1;
        rs = 5'd0; 
        rt = 5'd0; 
        rd = 5'd0;
        writeDataRegister = 32'h0000_0000;
        RegWrite = 1; 
        #10;
        
        rst = 0; #10;

        // write to register1 ($r1) (rd = 1)
        rd = 5'd1; 
        writeDataRegister = 32'hA5A5_A5A5; 
        RegWrite = 1; 
        #10;

        // read value from register1 ($r1) to rs and rt
        rs = 5'd1; 
        rt = 5'd1; 
        #10;
        // Expected readData_rs = A5A5_A5A5, readData_rt = A5A5_A5A5

        // write to register2 (rd = 2)
        rd = 5'd2; 
        writeDataRegister = 32'hF0F0_F0F0; 
        RegWrite = 1; 
        #10;

        // read value from register2 ($r2) to rs and register 1 to rt
        rs = 5'd2; 
        rt = 5'd1; 
        #10;
        // Expected readData_rs = F0F0_F0F0, readData_rt = A5A5_A5A5
        
        // read value from register1 ($r1) to rs and register 2 to rt
        rs = 5'd1; 
        rt = 5'd2;
        // Expected readData_rs = A5A5_A5A5, readData_rt = F0F0_F0F0
        #10;
        
        // stop reading data, register value won't change
        RegWrite = 0;
        writeDataRegister = 32'hFFFF_FFFF; 
        rd = 5'd1; #10;
        rd = 5'd2; #10;
        rs = 5'd2;
        rd = 5'd3; #10;
        rs = 5'd3;
        rd = 5'd0; #10;
        rs = 5'd0;
        rd = 5'd1; #10;
        rs = 5'd1; #10;
        
        // clear data by writing 0000_0000 to register 1 and 2
        writeDataRegister = 32'h0000_0000;
        RegWrite = 1;
        rd = 5'd1; #10;
        rd = 5'd2; #20;
        
        $finish;
    end
endmodule