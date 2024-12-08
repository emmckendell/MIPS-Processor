`timescale 1ns / 1ps

module INSTRUCTION_DECODE(
    input clk,
    input rst,
    
    input wire [31:0] IF_ID_npc,
    input wire [31:0] IF_ID_instruction,
    input wire [4:0] WB_writeRegister,
    input wire [31:0] WB_writeDataRegister,
    input wire WB_controlWB_RegWrite,           // control
    
    output wire ID_EX_controlEX_RegDst,         // controlEX[3] (RegDst)
    output wire [1:0] ID_EX_controlEX_ALUOp,    // controlEX[2:1] (ALUOp[1:0])
    output wire ID_EX_controlEX_ALUSrc,         // controlEX[0] (ALUSrc)
    output wire [2:0] ID_EX_controlMEM,         // [Branch, MemRead, MemWrite]
    output wire [1:0] ID_EX_controlWB,          // [RegWrite, MemToReg]
    
    output wire [31:0] ID_EX_npc,
    output wire [31:0] ID_EX_readData_rs,       // first (source) register
    output wire [31:0] ID_EX_readData_rt,       // second register
    output wire [31:0] ID_EX_signExtend,
    output wire [4:0] ID_EX_instruction_20_16,
    output wire [4:0] ID_EX_instruction_15_11,
    
    output wire [31:0] register0,  register1,  register2,  register3,
                       register4,  register5,  register6,  register7,
                       register8,  register9,  register10, register11,
                       register12, register13, register14, register15,
                       register16, register17, register18, register19,
                       register20, register21, register22, register23,
                       register24, register25, register26, register27,
                       register28, register29, register30, register31
    );
    
    wire [3:0] controlEX;           // [regDst, aluOp[1:0], aluSrc]
    wire [2:0] controlMEM;          // [Branch, MemRead, MemWrite]
    wire [1:0] controlWB;           // [RegWrite, MemToReg]
    
    wire controlEX_RegDst;          // controlEX[3] (RegDst)
    wire [1:0] controlEX_ALUOp;     // controlEX[2:1] (ALUOp[1:0])
    wire controlEX_ALUSrc;          // controlEX[0] (ALUSrc)
    
    wire [31:0] readData_rs, readData_rt;
    wire [31:0] ID_EX_instructionExtend;
    wire [31:0] instructionSignExtend_15_0;
    
    // instantiations
       
//    IF_ID INSTRUCTION_DECODE_INST(   
//        .clk(clk),
//        .rst(rst),
//        //input
//        .npc(npc),
//        .instruction(dataOut),
//        // output
//        .npcOut(IF_ID_npc),
//        .instructionOut(IF_ID_instruction)
//        );
    
    control control_INST(
        // input
        .opcode(IF_ID_instruction[31:26]),
        // output
        .controlEX(controlEX),      // [regDst, aluOp[1:0], aluSrc]
        .controlMEM(controlMEM),    // [Branch, MemRead, MemWrite]
        .controlWB(controlWB)       // [RegWrite, MemToReg]
        );
    
    registers registers_INST(
        .clk(clk),
        .rst(rst),
        // input
        .rs(IF_ID_instruction[25:21]),  // register source
        .rt(IF_ID_instruction[20:16]),  // register target
        .rd(WB_writeRegister),          // register destination
        .writeDataRegister(WB_writeDataRegister),
        // control
        .RegWrite(WB_controlWB_RegWrite),
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
    
    signExtend signExtend_INST(
        .inUnextend_16b(IF_ID_instruction[15:0]),   // input
        .outExtend_32b(instructionSignExtend_15_0)  // output
        );
        
    ID_EX ID_EX_INST(
        .clk(clk),
        .rst(rst),
        
        // control input
        .controlEX(controlEX),                      // split into three signals, used in EX stage
        .controlMEM(controlMEM),                    // [Branch, MemRead, MemWrite]
        .controlWB(controlWB),                      // [RegWrite, MemToReg]
        
        // control output
        .controlEX_RegDst(ID_EX_controlEX_RegDst),  // controlEX[3] (RegDst)
        .controlEX_ALUOp(ID_EX_controlEX_ALUOp),    // controlEX[2:1] (ALUOp[1:0])
        .controlEX_ALUSrc(ID_EX_controlEX_ALUSrc),  // controlEX[0] (ALUSrc)
         
        .controlMEMOut(ID_EX_controlMEM),           // [Branch, MemRead, MemWrite]
        .controlWBOut(ID_EX_controlWB),             // [RegWrite, MemToReg]
        
        // input
        .nextProgramCount(IF_ID_npc),
        .readData_rs(readData_rs),                  // register source
        .readData_rt(readData_rt),                  // register target
        .instructionSignExtend_15_0(instructionSignExtend_15_0), // 32 bits
        .instruction_20_16(IF_ID_instruction[20:16]),
        .instruction_15_11(IF_ID_instruction[15:11]),
        
        // output
        .npcEXOut(ID_EX_npc),
        .readData_rsOut(ID_EX_readData_rs),                 // register source
        .readData_rtOut(ID_EX_readData_rt),                 // register target
        .instructionSignExtend_15_0_Out(ID_EX_signExtend),  // 32'hFFFF_xxxx OR 32'h0000_xxxx
        .instruction_20_16_Out(ID_EX_instruction_20_16),
        .instruction_15_11_Out(ID_EX_instruction_15_11)
        );            
endmodule