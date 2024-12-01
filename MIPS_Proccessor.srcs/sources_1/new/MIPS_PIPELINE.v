`timescale 1ns / 1ps

module MIPS_PIPELINE(
    input clk,
    input rst,
    
    output wire [31:0] IF_ID_npc,
    output wire [31:0] IF_ID_instruction,
    
    output wire [31:0] register0, register1, register2, register3,
                       register4, register5, register6, register7,
                       register8, register9, register10, register11,
                       register12,register13, register14, register15,
                       register16, register17, register18, register19,
                       register20, register21, register22, register23,
                       register24, register25, register26, register27,
                       register28, register29, register30, register31,
                       
    output wire [31:0] memory0,   memory1,   memory2,   memory3,   memory4,   memory5,   memory6,   memory7,
                       memory8,   memory9,   memory10,  memory11,  memory12,  memory13,  memory14,  memory15,
                       memory16,  memory17,  memory18,  memory19,  memory20,  memory21,  memory22,  memory23,
                       memory24,  memory25,  memory26,  memory27,  memory28,  memory29,  memory30,  memory31,
                       memory32,  memory33,  memory34,  memory35,  memory36,  memory37,  memory38,  memory39,
                       memory40,  memory41,  memory42,  memory43,  memory44,  memory45,  memory46,  memory47,
                       memory48,  memory49,  memory50,  memory51,  memory52,  memory53,  memory54,  memory55,
                       memory56,  memory57,  memory58,  memory59,  memory60,  memory61,  memory62,  memory63,
                       memory64,  memory65,  memory66,  memory67,  memory68,  memory69,  memory70,  memory71,
                       memory72,  memory73,  memory74,  memory75,  memory76,  memory77,  memory78,  memory79,
                       memory80,  memory81,  memory82,  memory83,  memory84,  memory85,  memory86,  memory87,
                       memory88,  memory89,  memory90,  memory91,  memory92,  memory93,  memory94,  memory95,
                       memory96,  memory97,  memory98,  memory99,  memory100, memory101, memory102, memory103,
                       memory104, memory105, memory106, memory107, memory108, memory109, memory110, memory111,
                       memory112, memory113, memory114, memory115, memory116, memory117, memory118, memory119,
                       memory120, memory121, memory122, memory123, memory124, memory125, memory126, memory127,
                       memory128, memory129, memory130, memory131, memory132, memory133, memory134, memory135,
                       memory136, memory137, memory138, memory139, memory140, memory141, memory142, memory143,
                       memory144, memory145, memory146, memory147, memory148, memory149, memory150, memory151,
                       memory152, memory153, memory154, memory155, memory156, memory157, memory158, memory159,
                       memory160, memory161, memory162, memory163, memory164, memory165, memory166, memory167,
                       memory168, memory169, memory170, memory171, memory172, memory173, memory174, memory175,
                       memory176, memory177, memory178, memory179, memory180, memory181, memory182, memory183,
                       memory184, memory185, memory186, memory187, memory188, memory189, memory190, memory191,
                       memory192, memory193, memory194, memory195, memory196, memory197, memory198, memory199,
                       memory200, memory201, memory202, memory203, memory204, memory205, memory206, memory207,
                       memory208, memory209, memory210, memory211, memory212, memory213, memory214, memory215,
                       memory216, memory217, memory218, memory219, memory220, memory221, memory222, memory223,
                       memory224, memory225, memory226, memory227, memory228, memory229, memory230, memory231,
                       memory232, memory233, memory234, memory235, memory236, memory237, memory238, memory239,
                       memory240, memory241, memory242, memory243, memory244, memory245, memory246, memory247,
                       memory248, memory249, memory250, memory251, memory252, memory253, memory254, memory255
    );
    
    INSTRUCTION_FETCH INSTRUCTION_FETCH_uut(
        .clk(clk),
        .rst(rst),
        // input
        .MEM_PCSrc(MEM_PCSrc),
        .MEM_npc(MEM_npc),
        // output
        .IF_ID_npc(IF_ID_npc),
        .IF_ID_instruction(IF_ID_instruction)
    );
    
//    wire [31:0] IF_ID_npc;
//    wire [31:0] IF_ID_instruction;
    
    INSTRUCTION_DECODE INSTRUCTION_DECODE_uut(
        .clk(clk),
        .rst(rst),
        // input
        .IF_ID_npc(IF_ID_npc),
        .IF_ID_instruction(IF_ID_instruction),
        .WB_writeRegister(WB_writeRegister),
        .WB_writeDataRegister(WB_writeDataRegister),
        .WB_controlWB_RegWrite(WB_controlWB_RegWrite),
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
        .ID_EX_instruction_15_11(ID_EX_instruction_15_11),
        
        .register0(register0), .register1(register1), .register2(register2), .register3(register3),
        .register4(register4), .register5(register5), .register6(register6), .register7(register7),
        .register8(register8), .register9(register9), .register10(register10), .register11(register11),
        .register12(register12), .register13(register13), .register14(register14), .register15(register15),
        .register16(register16), .register17(register17), .register18(register18), .register19(register19),
        .register20(register20), .register21(register21), .register22(register22), .register23(register23),
        .register24(register24), .register25(register25), .register26(register26), .register27(register27),
        .register28(register28), .register29(register29), .register30(register30), .register31(register31)
    );
    
//    wire ID_EX_controlEX_RegDst;
//    wire [1:0] ID_EX_controlEX_ALUOp;
//    wire ID_EX_controlEX_ALUSrc;
    
//    wire [2:0] ID_EX_controlMEM;
//    wire [1:0] ID_EX_controlWB;
    
//    wire [31:0] ID_EX_npc;
//    wire [4:0] ID_EX_readData_rs;
//    wire [4:0] ID_EX_readData_rt;
//    wire [31:0] ID_EX_signExtend;
//    wire [4:0] ID_EX_instruction_20_16;
//    wire [4:0] ID_EX_instruction_15_11;
    
    EXECUTE EXECUTE_uut(
        .clk(clk),
        .rst(rst),
        // control input
        .ID_EX_controlEX_RegDst(ID_EX_controlEX_RegDst),    // controlEX[3] (RegDst)
        .ID_EX_controlEX_ALUOp(ID_EX_controlEX_ALUOp),      // controlEX[2:1] (ALUOp[1:0])
        .ID_EX_controlEX_ALUSrc(ID_EX_controlEX_ALUSrc),    // controlEX[0] (ALUSrc)
        .ID_EX_controlMEM(ID_EX_controlMEM),                // [Branch, MemRead, MemWrite]
        .ID_EX_controlWB(ID_EX_controlWB),                  // [RegWrite, MemToReg]
        // control output
        .EX_MEM_controlMEM_Branch(EX_MEM_controlMEM_Branch),        // controlMEM[2]
        .EX_MEM_controlMEM_MemRead(EX_MEM_controlMEM_MemRead),      // controlMEM[1]
        .EX_MEM_controlMEM_MemWrite(EX_MEM_controlMEM_MemWrite),    // controlMEM[0]
        .EX_MEM_controlWB(EX_MEM_controlWB),                        // [RegWrite, MemToReg]
        .EX_MEM_zeroFlag(EX_MEM_zeroFlag),
        // input
        .ID_EX_npc(ID_EX_npc),
        .ID_EX_readData_rs(ID_EX_readData_rs),      // first (source) register
        .ID_EX_readData_rt(ID_EX_readData_rt),      // second register
        .ID_EX_signExtend(ID_EX_signExtend),
        .ID_EX_instruction_20_16(ID_EX_instruction_20_16),
        .ID_EX_instruction_15_11(ID_EX_instruction_15_11),
        // output
        .EX_MEM_npc(EX_MEM_npc),
        .EX_MEM_addressMemory(EX_MEM_addressMemory),
        .EX_MEM_writeDataMemory(EX_MEM_writeDataMemory),
        .EX_MEM_writeRegister(EX_MEM_writeRegister)
    );
    
//    wire EX_MEM_controlMEM_Branch;
//    wire EX_MEM_controlMEM_MemRead;
//    wire EX_MEM_controlMEM_MemWrite;
    
//    wire [1:0] EX_MEM_controlWB;
    
//    wire EX_MEM_zeroFlag;
    
//    wire [31:0] EX_MEM_npc;
//    wire [31:0] EX_MEM_addressMemory;
//    wire [31:0] EX_MEM_writeDataMemory;
//    wire [4:0] EX_MEM_writeRegister;
    
    MEMORY MEMORY_uut(
        .clk(clk),
        .rst(rst),
        // control input
        .EX_MEM_controlMEM_Branch(EX_MEM_controlMEM_Branch),        // controlMEM[2]
        .EX_MEM_controlMEM_MemRead(EX_MEM_controlMEM_MemRead),      // controlMEM[1]
        .EX_MEM_controlMEM_MemWrite(EX_MEM_controlMEM_MemWrite),    // controlMEM[0]
        .EX_MEM_controlWB(EX_MEM_controlWB),                        // [RegWrite, MemToReg]
        .EX_MEM_zeroFlag(EX_MEM_zeroFlag),                          // ALU_result = 0
        // control output
        .MEM_WB_controlWB_RegWrite(MEM_WB_controlWB_RegWrite),      // controlWB[1]
        .MEM_WB_controlWB_MemToReg(MEM_WB_controlWB_MemToReg),      // controlWB[0]
        .MEM_PCSrc(MEM_PCSrc),
        // input
        .EX_MEM_npc(EX_MEM_npc),
        .EX_MEM_addressMemory(EX_MEM_addressMemory),
        .EX_MEM_writeDataMemory(EX_MEM_writeDataMemory),
        .EX_MEM_writeRegister(EX_MEM_writeRegister),
        // output
        .MEM_WB_readData_mem(MEM_WB_readData_mem),
        .MEM_WB_addressMemory(MEM_WB_addressMemory),
        .MEM_WB_writeRegister(MEM_WB_writeRegister),
        .MEM_npc(MEM_npc),
        
        .memory0(memory0),     .memory1(memory1),     .memory2(memory2),     .memory3(memory3),
        .memory4(memory4),     .memory5(memory5),     .memory6(memory6),     .memory7(memory7),
        .memory8(memory8),     .memory9(memory9),     .memory10(memory10),   .memory11(memory11),
        .memory12(memory12),   .memory13(memory13),   .memory14(memory14),   .memory15(memory15),
        .memory16(memory16),   .memory17(memory17),   .memory18(memory18),   .memory19(memory19),
        .memory20(memory20),   .memory21(memory21),   .memory22(memory22),   .memory23(memory23),
        .memory24(memory24),   .memory25(memory25),   .memory26(memory26),   .memory27(memory27),
        .memory28(memory28),   .memory29(memory29),   .memory30(memory30),   .memory31(memory31),
        .memory32(memory32),   .memory33(memory33),   .memory34(memory34),   .memory35(memory35),
        .memory36(memory36),   .memory37(memory37),   .memory38(memory38),   .memory39(memory39),
        .memory40(memory40),   .memory41(memory41),   .memory42(memory42),   .memory43(memory43),
        .memory44(memory44),   .memory45(memory45),   .memory46(memory46),   .memory47(memory47),
        .memory48(memory48),   .memory49(memory49),   .memory50(memory50),   .memory51(memory51),
        .memory52(memory52),   .memory53(memory53),   .memory54(memory54),   .memory55(memory55),
        .memory56(memory56),   .memory57(memory57),   .memory58(memory58),   .memory59(memory59),
        .memory60(memory60),   .memory61(memory61),   .memory62(memory62),   .memory63(memory63),
        .memory64(memory64),   .memory65(memory65),   .memory66(memory66),   .memory67(memory67),
        .memory68(memory68),   .memory69(memory69),   .memory70(memory70),   .memory71(memory71),
        .memory72(memory72),   .memory73(memory73),   .memory74(memory74),   .memory75(memory75),
        .memory76(memory76),   .memory77(memory77),   .memory78(memory78),   .memory79(memory79),
        .memory80(memory80),   .memory81(memory81),   .memory82(memory82),   .memory83(memory83),
        .memory84(memory84),   .memory85(memory85),   .memory86(memory86),   .memory87(memory87),
        .memory88(memory88),   .memory89(memory89),   .memory90(memory90),   .memory91(memory91),
        .memory92(memory92),   .memory93(memory93),   .memory94(memory94),   .memory95(memory95),
        .memory96(memory96),   .memory97(memory97),   .memory98(memory98),   .memory99(memory99),
        .memory100(memory100), .memory101(memory101), .memory102(memory102), .memory103(memory103),
        .memory104(memory104), .memory105(memory105), .memory106(memory106), .memory107(memory107),
        .memory108(memory108), .memory109(memory109), .memory110(memory110), .memory111(memory111),
        .memory112(memory112), .memory113(memory113), .memory114(memory114), .memory115(memory115),
        .memory116(memory116), .memory117(memory117), .memory118(memory118), .memory119(memory119),
        .memory120(memory120), .memory121(memory121), .memory122(memory122), .memory123(memory123),
        .memory124(memory124), .memory125(memory125), .memory126(memory126), .memory127(memory127),
        .memory128(memory128), .memory129(memory129), .memory130(memory130), .memory131(memory131),
        .memory132(memory132), .memory133(memory133), .memory134(memory134), .memory135(memory135),
        .memory136(memory136), .memory137(memory137), .memory138(memory138), .memory139(memory139),
        .memory140(memory140), .memory141(memory141), .memory142(memory142), .memory143(memory143),
        .memory144(memory144), .memory145(memory145), .memory146(memory146), .memory147(memory147),
        .memory148(memory148), .memory149(memory149), .memory150(memory150), .memory151(memory151),
        .memory152(memory152), .memory153(memory153), .memory154(memory154), .memory155(memory155),
        .memory156(memory156), .memory157(memory157), .memory158(memory158), .memory159(memory159),
        .memory160(memory160), .memory161(memory161), .memory162(memory162), .memory163(memory163),
        .memory164(memory164), .memory165(memory165), .memory166(memory166), .memory167(memory167),
        .memory168(memory168), .memory169(memory169), .memory170(memory170), .memory171(memory171),
        .memory172(memory172), .memory173(memory173), .memory174(memory174), .memory175(memory175),
        .memory176(memory176), .memory177(memory177), .memory178(memory178), .memory179(memory179),
        .memory180(memory180), .memory181(memory181), .memory182(memory182), .memory183(memory183),
        .memory184(memory184), .memory185(memory185), .memory186(memory186), .memory187(memory187),
        .memory188(memory188), .memory189(memory189), .memory190(memory190), .memory191(memory191),
        .memory192(memory192), .memory193(memory193), .memory194(memory194), .memory195(memory195),
        .memory196(memory196), .memory197(memory197), .memory198(memory198), .memory199(memory199),
        .memory200(memory200), .memory201(memory201), .memory202(memory202), .memory203(memory203),
        .memory204(memory204), .memory205(memory205), .memory206(memory206), .memory207(memory207),
        .memory208(memory208), .memory209(memory209), .memory210(memory210), .memory211(memory211),
        .memory212(memory212), .memory213(memory213), .memory214(memory214), .memory215(memory215),
        .memory216(memory216), .memory217(memory217), .memory218(memory218), .memory219(memory219),
        .memory220(memory220), .memory221(memory221), .memory222(memory222), .memory223(memory223),
        .memory224(memory224), .memory225(memory225), .memory226(memory226), .memory227(memory227),
        .memory228(memory228), .memory229(memory229), .memory230(memory230), .memory231(memory231),
        .memory232(memory232), .memory233(memory233), .memory234(memory234), .memory235(memory235),
        .memory236(memory236), .memory237(memory237), .memory238(memory238), .memory239(memory239),
        .memory240(memory240), .memory241(memory241), .memory242(memory242), .memory243(memory243),
        .memory244(memory244), .memory245(memory245), .memory246(memory246), .memory247(memory247),
        .memory248(memory248), .memory249(memory249), .memory250(memory250), .memory251(memory251),
        .memory252(memory252), .memory253(memory253), .memory254(memory254), .memory255(memory255)
    );
    
//    wire MEM_WB_controlWB_RegWrite;
//    wire MEM_WB_controlWB_MemToReg;
    
//    wire MEM_PCSrc;
    
//    wire [31:0] MEM_WB_readData_mem;
//    wire [31:0] MEM_WB_addressMemory;
//    wire [4:0] MEM_WB_writeRegister;
    
    WRITE_BACK WRITE_BACK_uut (
        .clk(clk),
        .rst(rst),
        // control input
        .MEM_WB_controlWB_RegWrite(MEM_WB_controlWB_RegWrite),
        .MEM_WB_controlWB_MemToReg(MEM_WB_controlWB_MemToReg),
        // control output
        .WB_controlWB_RegWrite(WB_controlWB_RegWrite),
        // input
        .MEM_WB_readData_mem(MEM_WB_readData_mem),
        .MEM_WB_addressMemory(MEM_WB_addressMemory),
        .MEM_WB_writeRegister(MEM_WB_writeRegister),
        // output
        .WB_writeRegister(WB_writeRegister),
        .WB_writeDataRegister(WB_writeDataRegister)
    );
    
//    wire WB_controlWB_RegWrite;
    
//    wire [4:0] WB_writeRegister;
//    wire [31:0] WB_writeDataRegister;
    
endmodule