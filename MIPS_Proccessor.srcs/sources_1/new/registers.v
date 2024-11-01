`timescale 1ns / 1ps

module registers(
    input clk,
    input rst,
    input wire [4:0] rs, rt, rd,
    input wire [31:0] writeData,
    input wire regWrite,
    output wire [31:0] readData_rs, readData_rt
    );

    // 32 registers that each contain 32-bits
    reg [31:0] registers [31:0];
    
    assign readData_rs = registers[rs];
    assign readData_rt = registers[rt];
    
    always @(posedge clk or posedge rst) 
    begin
        if (rst)
        begin
            integer i;
            for (i = 0; i < 32; i = i + 1) 
            begin
                registers[i] <= 32'b0; // Initialize all registers to 0 on rst
            end
        end
        else if (regWrite && rd != 0) 
        begin
            // Write to the register (if regWrite is enabled and register is not $zero)
            registers[rd] <= writeData;
        end
    end
    
endmodule