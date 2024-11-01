`timescale 1ns / 1ps

module INSTRUCTION_DECODE(
    input clk,
    input rst,
    input [31:0] IF_ID_instruction,
    input [4:0] MEM_WB_writeRegister,
    input [31:0] MEM_WB_writeData,
    input MEM_WB_writeBack,
    input [31:0] IF_ID_npc,
    
    output [3:0] controlEX,
    output [2:0] controlMEM,
    output [3:0] controlWB,
    output [31:0] ID_EX_npc,
    output [31:0] ID_EX_readData_rsOut,
    output [31:0] ID_EX_readData_rtOut,
    output [31:0] ID_EX_signExtend,
    output [4:0] ID_EX_instruction_20_16,
    output [4:0] ID_EX_instruction_15_11
    );
    
    wire [31:0] readDataA, readDataB;
    wire [31:0] ID_EX_instructionExtend;
    wire [31:0] instructionSignExtend_15_0;
    
    // instantiations
    control control_INST(
        // input
        .opcode(IF_ID_instruction[31:26]),
        // outputs
        .controlEX(controlEX),
        .controlMEM(controlMEM),
        .controlWB(controlWB)
        );
    
    registers registers_INST(
        .clk(clk),
        .rst(rst),
        // inputs
        .rs(IF_ID_instruction[25:21]),
        .rt(IF_ID_instruction[20:16]),
        .rd(MEM_WB_writeRegister),
        .writeData(MEM_WB_writeData),
        // control
        .regWrite(MEM_WB_writeBack),
        // outputs
        .A(readDataA),
        .B(readDataB)
        );
    
    signExtend signExtend_INST(
        inUnextend_16b(IF_ID_instruction[15:0]),    // input
        outExtend_32b(ID_EX_instructionExtend),     // output
        );
        
    ID_EX ID_EX_INST(
        .clk(clk),
        // control inputs
        .controlEX(controlEX),
        .controlMEM(controlMEM),
        .controlWB(controlWB),
        
        // control outputs
        .controlEXOut(ID_EX_controlEX),
        .controlMEMOut(ID_EX_controlMEM),
        .controlWB_RegDst(ID_EX_controlWB_RegDst),  // controlWB[3]
        .controlWB_ALUOp(ID_EX_controlWB_ALUOp),    // controlWB[2:1]
        .controlWB_ALUSrc(ID_EX_controlWB_ALUSrc),  // controlWB[0]
        
        // inputs
        .npc(IF_ID_npc),
        .readData_rs(readDataA),
        .readData_rt(readDataB),
        .signExtend(instructionSignExtend_15_0),        // 32 bits
        .instruction_20_16(IF_ID_instruction[20:16]),
        .instruction_15_11(IF_ID_instruction[15:11]),
        
        //outputs
        .npcOut(ID_EX_npc),
        .readData_rsOut(ID_EX_readData_rsOut),
        .readData_rtOut(ID_EX_readData_rtOut),
        .signExtendOut(ID_EX_signExtend),
        .instruction_20_16_Out(ID_EX_instruction_20_16),
        .instruction_15_11_Out(ID_EX_instruction_15_11)
        );
             
endmodule
