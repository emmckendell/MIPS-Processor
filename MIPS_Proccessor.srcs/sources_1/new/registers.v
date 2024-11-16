`timescale 1ns / 1ps

module registers(
    input clk,
    input rst,
     
    input wire [4:0] rs, rt, rd,
    input wire [31:0] writeDataRegister,
    input wire regWrite,
    
    output wire [31:0] readData_rs, readData_rt,
    
    // 32 registers that each contain 32-bits
    output wire [31:0] register0, register1, register2, register3,
    output wire [31:0] register4, register5, register6, register7,
    output wire [31:0] register8, register9, register10, register11,
    output wire [31:0] register12, register13, register14, register15,
    output wire [31:0] register16, register17, register18, register19,
    output wire [31:0] register20, register21, register22, register23,
    output wire [31:0] register24, register25, register26, register27,
    output wire [31:0] register28, register29, register30, register31
    );
    
    // rs: first (source) register - always read
    // rt: second register - read, except for load
    // rd: destination register - write for R-type, load, and store

    // internal 32 registers that each contain 32-bits
    reg [31:0] registers [31:0];

    integer i;
    
    // initialize all registers to 0
    initial 
    begin
        for (i = 0; i < 32; i = i + 1) 
            registers[i] = 32'd0;
    end
    
    // On every clock cycle, update registers, readData_rs, and readData_rt
    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
            // Reset all registers to 0
            for (i = 0; i < 32; i = i + 1) 
                registers[i] <= 32'd0;
        end
        else 
        begin
            // Write data to register if regWrite is enabled and rd is not $zero
            if (regWrite && rd != 5'd0)
                registers[rd] <= writeDataRegister;
        end
    end

    assign readData_rs = registers[rs];
    assign readData_rt = registers[rt];
    
    // 32 registers that each contain 32-bits
    assign register0 = registers[0];
    assign register1 = registers[1];
    assign register2 = registers[2];
    assign register3 = registers[3];
    assign register4 = registers[4];
    assign register5 = registers[5];
    assign register6 = registers[6];
    assign register7 = registers[7];
    assign register8 = registers[8];
    assign register9 = registers[9];
    assign register10 = registers[10];
    assign register11 = registers[11];
    assign register12 = registers[12];
    assign register13 = registers[13];
    assign register14 = registers[14];
    assign register15 = registers[15];
    assign register16 = registers[16];
    assign register17 = registers[17];
    assign register18 = registers[18];
    assign register19 = registers[19];
    assign register20 = registers[20];
    assign register21 = registers[21];
    assign register22 = registers[22];
    assign register23 = registers[23];
    assign register24 = registers[24];
    assign register25 = registers[25];
    assign register26 = registers[26];
    assign register27 = registers[27];
    assign register28 = registers[28];
    assign register29 = registers[29];
    assign register30 = registers[30];
    assign register31 = registers[31];
   
endmodule