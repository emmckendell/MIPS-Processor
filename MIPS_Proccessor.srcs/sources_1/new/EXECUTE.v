`timescale 1ns / 1ps

module EXECUTE(
    input clk,
    input rst,
    
    input wire ID_EX_controlEX_RegDst,         // controlEX[3] (RegDst)
    input wire [1:0] ID_EX_controlEX_ALUOp,    // controlEX[2:1] (ALUOp[1:0])
    input wire ID_EX_controlEX_ALUSrc,         // controlEX[0] (ALUSrc)
    input wire [2:0] ID_EX_controlMEM,         // [Branch, MemRead, MemWrite]
    input wire [1:0] ID_EX_controlWB,          // [RegWrite, MemToReg]

    input wire [31:0] ID_EX_npc,
    input wire [31:0] ID_EX_readData_rs,        // first (source) register
    input wire [31:0] ID_EX_readData_rt,        // second register
    input wire [31:0] ID_EX_signExtend,
    input wire [4:0] ID_EX_instruction_20_16,
    input wire [4:0] ID_EX_instruction_15_11,
    
    output wire EX_MEM_controlMEM_Branch,       // controlMEM[2] (Branch)
    output wire EX_MEM_controlMEM_MemRead,      // controlMEM[1] (MemRead)
    output wire EX_MEM_controlMEM_MemWrite,     // controlMEM[0] (MemWrite)
    output wire [1:0] EX_MEM_controlWB,
    
    output wire EX_MEM_zeroFlag, 
    
    output wire [31:0] EX_MEM_npc,   
    output wire [31:0] EX_MEM_address,
    output wire [31:0] EX_MEM_writeDataMemory,
    output wire [4:0] EX_MEM_writeRegister
    );
    
    wire zeroFlag;
    
    wire [31:0] ALUSrcMux;
    wire [2:0] ALUSelect;
    
    wire [31:0] ALU_addResult;
    wire [31:0] ALU_result;
    wire [4:0] RegDstMux;
        
    // instantiations
    
    alu aluAdder_INST(
        // control
        .ALUControl(3'b010),        // tied ALUControl to add
        // input
        .A(ID_EX_npc),
        .B(ID_EX_signExtend),
        // output
        .zero(),                    // *UNUSED*
        .ALUResult(ALU_addResult)
        );
    
    aluControl aluControl_INST(
        .funct(ID_EX_signExtend[5:0]),  // input
        .ALUOp(ID_EX_controlEX_ALUOp),  // control
        .ALUControl(ALUSelect)          // output
        );
    
    mux mux_ALUSrc_INST(
        // input: a = 1, b = 0
        
        // input
        .a(ID_EX_signExtend),
        .b(ID_EX_readData_rt),      // seond register
        // control
        .sel(ID_EX_controlEX_ALUSrc),
        // output
        .y(ALUSrcMux)
        );
    
    alu alu_INST(
        // control
        .ALUControl(ALUSelect),
        // input
        .A(ID_EX_readData_rs),      // first (source) register
        .B(ALUSrcMux),
        // output
        .zero(ALU_zero),
        .ALUResult(ALU_result)
        );
    
    mux mux_RegDst_INST(
         // input: a = 1, b = 0
        
        // input
        .a(ID_EX_instruction_15_11),
        .b(ID_EX_instruction_20_16),
        // control
        .sel(ID_EX_controlEX_RegDst),
        // output
        .y(RegDstMux)
        );
    
    EX_MEM EX_MEM_INST(
        .clk(clk),
        .rst(rst),
        
        // control input
        .controlMEM(ID_EX_controlMEM),  // split into three signals, used in MEM stage           
        .controlWB(ID_EX_controlWB),
        .zeroFlag(zeroFlag),
        
        // control output
        .controlMEM_Branch(EX_MEM_controlMEM_Branch),       // controlMEM[2] (Branch)
        .controlMEM_MemRead(EX_MEM_controlMEM_MemRead),     // controlMEM[1] (MemRead)
        .controlMEM_MemWrite(EX_MEM_controlMEM_MemWrite),   // controlMEM[0] (MemWrite)
        .controlWBOut(EX_MEM_controlWB),
        .zeroFlagOut(EX_MEM_zeroFlag),
        
        // input
        .addResult(ALU_addResult),
        .result(ALU_result),
        .readData_rt(ID_EX_readData_rt),
        .RegDstMux(RegDstMux),
        
        // output
        .npcMEM(EX_MEM_npc),
        .address(EX_MEM_address),
        .writeDataMemory(EX_MEM_writeDataMemory),
        .writeRegister(EX_MEM_writeRegister)
        );
      
endmodule