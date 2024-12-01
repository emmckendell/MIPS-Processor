`timescale 1ns / 1ps

module dataMemory(
    input clk,
    input rst,
    
    input wire [31:0] addressMemory,
    input wire [31:0] writeDataMemory,
    input wire MemWrite,
    input wire MemRead,
    
    output reg [31:0] readData_mem,
    
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
    
    // internal 256 memory addresses that each contain 32-bits
    reg [31:0] memory [0:255];
    
    integer i;
    
    // initialize all memory addresses to 0
    initial 
    begin
        for (i = 0; i < 256; i = i + 1) 
            memory[i] = 32'd0;
    end
    
    always @(posedge clk) 
    begin
        if (rst) 
        begin
            for (i = 0; i < 256; i = i + 1)
                memory[i] <= 32'b0;
        end 
        else 
        begin
            // Write data to memory if MemWrite is enabled
            if (MemWrite)
                memory[addressMemory[7:0]] <= writeDataMemory;
            // Read data from memory if MemRead is enabled
            if (MemRead)
                readData_mem <= memory[addressMemory[7:0]];
            else
                readData_mem <= 32'h0000_0000;
        end
    end 
    
    assign memory0  = memory[0];
	assign memory1  = memory[1];
	assign memory2  = memory[2];
	assign memory3  = memory[3];
	assign memory4  = memory[4];
	assign memory5  = memory[5];
	assign memory6  = memory[6];
	assign memory7  = memory[7];
	assign memory8  = memory[8];
	assign memory9  = memory[9];
	assign memory10 = memory[10];
	assign memory11 = memory[11];
	assign memory12 = memory[12];
	assign memory13 = memory[13];
	assign memory14 = memory[14];
	assign memory15 = memory[15];
	assign memory16 = memory[16];
	assign memory17 = memory[17];
	assign memory18 = memory[18];
	assign memory19 = memory[19];
	assign memory20 = memory[20];
	assign memory21 = memory[21];
	assign memory22 = memory[22];
	assign memory23 = memory[23];
	assign memory24 = memory[24];
	assign memory25 = memory[25];
	assign memory26 = memory[26];
	assign memory27 = memory[27];
	assign memory28 = memory[28];
	assign memory29 = memory[29];
	assign memory30 = memory[30];
	assign memory31 = memory[31];
	assign memory32 = memory[32];
	assign memory33 = memory[33];
	assign memory34 = memory[34];
	assign memory35 = memory[35];
	assign memory36 = memory[36];
	assign memory37 = memory[37];
	assign memory38 = memory[38];
	assign memory39 = memory[39];
	assign memory40 = memory[40];
	assign memory41 = memory[41];
	assign memory42 = memory[42];
	assign memory43 = memory[43];
	assign memory44 = memory[44];
	assign memory45 = memory[45];
	assign memory46 = memory[46];
	assign memory47 = memory[47];
	assign memory48 = memory[48];
	assign memory49 = memory[49];
	assign memory50 = memory[50];
	assign memory51 = memory[51];
	assign memory52 = memory[52];
	assign memory53 = memory[53];
	assign memory54 = memory[54];
	assign memory55 = memory[55];
	assign memory56 = memory[56];
	assign memory57 = memory[57];
	assign memory58 = memory[58];
	assign memory59 = memory[59];
	assign memory60 = memory[60];
	assign memory61 = memory[61];
	assign memory62 = memory[62];
	assign memory63 = memory[63];
	assign memory64 = memory[64];
	assign memory65 = memory[65];
	assign memory66 = memory[66];
	assign memory67 = memory[67];
	assign memory68 = memory[68];
	assign memory69 = memory[69];
	assign memory70 = memory[70];
	assign memory71 = memory[71];
	assign memory72 = memory[72];
	assign memory73 = memory[73];
	assign memory74 = memory[74];
	assign memory75 = memory[75];
	assign memory76 = memory[76];
	assign memory77 = memory[77];
	assign memory78 = memory[78];
	assign memory79 = memory[79];
	assign memory80 = memory[80];
	assign memory81 = memory[81];
	assign memory82 = memory[82];
	assign memory83 = memory[83];
	assign memory84 = memory[84];
	assign memory85 = memory[85];
	assign memory86 = memory[86];
	assign memory87 = memory[87];
	assign memory88 = memory[88];
	assign memory89 = memory[89];
	assign memory90 = memory[90];
	assign memory91 = memory[91];
	assign memory92 = memory[92];
	assign memory93 = memory[93];
	assign memory94 = memory[94];
	assign memory95 = memory[95];
	assign memory96 = memory[96];
	assign memory97 = memory[97];
	assign memory98 = memory[98];
	assign memory99 = memory[99];
	assign memory100 = memory[100];
	assign memory101 = memory[101];
	assign memory102 = memory[102];
	assign memory103 = memory[103];
	assign memory104 = memory[104];
	assign memory105 = memory[105];
	assign memory106 = memory[106];
	assign memory107 = memory[107];
	assign memory108 = memory[108];
	assign memory109 = memory[109];
	assign memory110 = memory[110];
	assign memory111 = memory[111];
	assign memory112 = memory[112];
	assign memory113 = memory[113];
	assign memory114 = memory[114];
	assign memory115 = memory[115];
	assign memory116 = memory[116];
	assign memory117 = memory[117];
	assign memory118 = memory[118];
	assign memory119 = memory[119];
	assign memory120 = memory[120];
	assign memory121 = memory[121];
	assign memory122 = memory[122];
	assign memory123 = memory[123];
	assign memory124 = memory[124];
	assign memory125 = memory[125];
	assign memory126 = memory[126];
	assign memory127 = memory[127];
	assign memory128 = memory[128];
	assign memory129 = memory[129];
	assign memory130 = memory[130];
	assign memory131 = memory[131];
	assign memory132 = memory[132];
	assign memory133 = memory[133];
	assign memory134 = memory[134];
	assign memory135 = memory[135];
	assign memory136 = memory[136];
	assign memory137 = memory[137];
	assign memory138 = memory[138];
	assign memory139 = memory[139];
	assign memory140 = memory[140];
	assign memory141 = memory[141];
	assign memory142 = memory[142];
	assign memory143 = memory[143];
	assign memory144 = memory[144];
	assign memory145 = memory[145];
	assign memory146 = memory[146];
	assign memory147 = memory[147];
	assign memory148 = memory[148];
	assign memory149 = memory[149];
	assign memory150 = memory[150];
	assign memory151 = memory[151];
	assign memory152 = memory[152];
	assign memory153 = memory[153];
	assign memory154 = memory[154];
	assign memory155 = memory[155];
	assign memory156 = memory[156];
	assign memory157 = memory[157];
	assign memory158 = memory[158];
	assign memory159 = memory[159];
	assign memory160 = memory[160];
	assign memory161 = memory[161];
	assign memory162 = memory[162];
	assign memory163 = memory[163];
	assign memory164 = memory[164];
	assign memory165 = memory[165];
	assign memory166 = memory[166];
	assign memory167 = memory[167];
	assign memory168 = memory[168];
	assign memory169 = memory[169];
	assign memory170 = memory[170];
	assign memory171 = memory[171];
	assign memory172 = memory[172];
	assign memory173 = memory[173];
	assign memory174 = memory[174];
	assign memory175 = memory[175];
	assign memory176 = memory[176];
	assign memory177 = memory[177];
	assign memory178 = memory[178];
	assign memory179 = memory[179];
	assign memory180 = memory[180];
	assign memory181 = memory[181];
	assign memory182 = memory[182];
	assign memory183 = memory[183];
	assign memory184 = memory[184];
	assign memory185 = memory[185];
	assign memory186 = memory[186];
	assign memory187 = memory[187];
	assign memory188 = memory[188];
	assign memory189 = memory[189];
	assign memory190 = memory[190];
	assign memory191 = memory[191];
	assign memory192 = memory[192];
	assign memory193 = memory[193];
	assign memory194 = memory[194];
	assign memory195 = memory[195];
	assign memory196 = memory[196];
	assign memory197 = memory[197];
	assign memory198 = memory[198];
	assign memory199 = memory[199];
	assign memory200 = memory[200];
	assign memory201 = memory[201];
	assign memory202 = memory[202];
	assign memory203 = memory[203];
	assign memory204 = memory[204];
	assign memory205 = memory[205];
	assign memory206 = memory[206];
	assign memory207 = memory[207];
	assign memory208 = memory[208];
	assign memory209 = memory[209];
	assign memory210 = memory[210];
	assign memory211 = memory[211];
	assign memory212 = memory[212];
	assign memory213 = memory[213];
	assign memory214 = memory[214];
	assign memory215 = memory[215];
	assign memory216 = memory[216];
	assign memory217 = memory[217];
	assign memory218 = memory[218];
	assign memory219 = memory[219];
	assign memory220 = memory[220];
	assign memory221 = memory[221];
	assign memory222 = memory[222];
	assign memory223 = memory[223];
	assign memory224 = memory[224];
	assign memory225 = memory[225];
	assign memory226 = memory[226];
	assign memory227 = memory[227];
	assign memory228 = memory[228];
	assign memory229 = memory[229];
	assign memory230 = memory[230];
	assign memory231 = memory[231];
	assign memory232 = memory[232];
	assign memory233 = memory[233];
	assign memory234 = memory[234];
	assign memory235 = memory[235];
	assign memory236 = memory[236];
	assign memory237 = memory[237];
	assign memory238 = memory[238];
	assign memory239 = memory[239];
	assign memory240 = memory[240];
	assign memory241 = memory[241];
	assign memory242 = memory[242];
	assign memory243 = memory[243];
	assign memory244 = memory[244];
	assign memory245 = memory[245];
	assign memory246 = memory[246];
	assign memory247 = memory[247];
	assign memory248 = memory[248];
	assign memory249 = memory[249];
	assign memory250 = memory[250];
	assign memory251 = memory[251];
	assign memory252 = memory[252];
	assign memory253 = memory[253];
	assign memory254 = memory[254];
	assign memory255 = memory[255];
      
endmodule