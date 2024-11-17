`timescale 1ns / 1ps

module INSTRUCTION_DECODE_tb;
    reg clk;
    reg rst;
    
    reg [31:0] IF_ID_npc;
    reg [31:0] IF_ID_instruction;
    reg [4:0] WB_writeRegister;
    reg [31:0] WB_writeDataRegister;
    reg WB_controlWB_RegWrite;
    
    wire ID_EX_controlEX_RegDst;
    wire [1:0] ID_EX_controlEX_ALUOp;
    wire ID_EX_controlEX_ALUSrc;
    
    wire [2:0] ID_EX_controlMEM;
    wire [1:0] ID_EX_controlWB;
    
    wire [31:0] ID_EX_npc;
    wire [31:0] ID_EX_readData_rs;
    wire [31:0] ID_EX_readData_rt;
    wire [31:0] ID_EX_signExtend;
    wire [4:0] ID_EX_instruction_20_16;
    wire [4:0] ID_EX_instruction_15_11;
    
    // instantiate
    
    INSTRUCTION_DECODE INSTRUCTION_DECODE_uut(
        .clk(clk),
        .rst(rst),
        // input
        .IF_ID_npc(IF_ID_npc),
        .IF_ID_instruction(IF_ID_instruction),
        .WB_writeRegister(WB_writeRegister),
        .WB_writeDataRegister(WB_writeDataRegister),
        .WB_RegWrite(WB_RegWrite),
        // control output
        .ID_EX_controlEX_RegDst(ID_EX_controlEX_RegDst),    // controlEX[3] (RegDst)
        .ID_EX_controlEX_ALUOp(ID_EX_controlEX_ALUOp),      // controlEX[2:1] (ALUOp[1:0])
        .ID_EX_controlEX_ALUSrc(ID_EX_controlEX_ALUSrc),    // controlEX[0] (ALUSrc)
        .ID_EX_controlMEM(ID_EX_controlMEM),                // [Branch, MemRead, MemWrite
        .ID_EX_controlWB(ID_EX_controlWB),                  // [RegWrite, MemToReg]
        // output
        .ID_EX_npc(ID_EX_npc),
        .ID_EX_readData_rs(ID_EX_readData_rs),
        .ID_EX_readData_rt(ID_EX_readData_rt),
        .ID_EX_signExtend(ID_EX_signExtend),
        .ID_EX_instruction_20_16(ID_EX_instruction_20_16),
        .ID_EX_instruction_15_11(ID_EX_instruction_15_11)
    );

    // clock
    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk;  // 5 time units
    end
    
    initial 
    begin
        rst = 1;
        
        // i-format: opcode(0)_rs_rt_rd_shamt_funct
        // j-format: opcode(35/43)_rs_rt_address
        // r-format: opcode(4)_rs_rt_address
                     
        IF_ID_instruction = 32'b000000_00000_00000_0000_0000_0000_0000;
        WB_writeRegister = 5'd0;
        WB_writeDataRegister = 32'h0000_0000;
        WB_RegWrite = 0;
        IF_ID_npc = 32'h0000_0000;
        #10;
        
        rst = 0;
        
        
                          
        $finish;
    end
endmodule
             
//        // $s0 = 0 + 3
//        // addi $s0, $zero, 3 | opcode=001000, rs=00000, rt=10000, immediate=0000_0000_0000_0011
//        IF_ID_npc = 32'h0000_0001;
//        IF_ID_instruction = 32'b001000_00000_10000_0000000000000011;
//        #50;

//        // write to register $s0(register 16)
//        WB_writeRegister = 5'd16; #10;
//        WB_writeDataRegister = 32'h0000_0003;
//        WB_RegWrite = 1;
//        #50;

//        // $s1 = 0 + 2
//        // addi $s1, $zero, 2 | opcode=001000, rs=00000, rt=10001, immediate=0000_0000_0000_0010
//        IF_ID_npc = 32'h0000_0002;
//        IF_ID_instruction = 32'b001000_00000_10001_00000_00000_000010;
//        #50;

//        // write to register $s1 (register 17)
//        WB_writeRegister = 5'd17; #10;
//        WB_writeDataRegister = 32'h0000_0002;
//        WB_RegWrite = 1;
//        #50;

//        // $s2 = $s1 + $s0
//        // add $s2, $s1, $s1 | opcode=000000, rs=10000, rt=10001, rd=10010, shamt=00000, funct=100000
//        IF_ID_npc = 32'h0000_0003;
//        IF_ID_instruction = 32'b000000_10000_10001_10010_00000_100000;
//        #50;

//        // write to register $s2 (register 18)
//        WB_writeRegister = 5'd18; #10;
//        WB_writeDataRegister = 32'h0000_0005;
//        WB_RegWrite = 1;
//        #50;

//        // store $s2(32'h5) to memory[$s0 + 3](3+3=6)
//        // sw $s2, 2($s0) | opcode=101011, rs=10000, rt=10010, offset=0000_0000_0000_0011
//        IF_ID_npc = 32'h0000_0004;
//        IF_ID_instruction = 32'b101011_10000_10010_0000000000000011;
//        #50;
        
//        // no write to register needed
//        WB_RegWrite = 0; #50;

//        // load from memory[$s0 + 3](3+3=6) to $s3
//        // lw $s3, 2($s0) | opcode=100011, rs=10000, rt=10011, offset=0000_0000_0000_0010
//        IF_ID_npc = 32'h0000_0005;
//        IF_ID_instruction = 32'b100011_10000_10011_0000000000000011;
//        #50;

//        // write to register $s3 (register 19)
//        WB_writeRegister = 5'd19; #10;
//        WB_writeDataRegister = 32'h0000_0005;  // assuming memory[$s0 + 3](3+3=6) contains 5
//        WB_RegWrite = 1;
//        #50;
        
//        // read register 16 (3) register 17 (2)
//        IF_ID_npc = 32'h0000_0006;
//        IF_ID_instruction = 32'bxxxxxx_10000_10001_xxxxxxxxxxxxxxxx;
//        #50;
        
//        // read register 18 (5) register 19 (5)
//        IF_ID_npc = 32'h0000_0007;
//        IF_ID_instruction = 32'bxxxxxx_10010_10011_xxxxxxxxxxxxxxxx;
//        #50;