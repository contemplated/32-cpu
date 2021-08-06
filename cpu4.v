`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 21:43:32
// Design Name: 
// Module Name: cpu4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu4(CLK,reset,PC,Instr,toWD3,SrcB,SrcA,ALUResult,DataOut,Op,Funct,PCEn,InstrmemWr,IRWrite,
foreRegDst,zero,foreRegWrite,ALUSrcA,ALUSrcB,RD,WD,signext,MemOrReg,ALUControl,PCSrc,Outimm
    );
    input CLK,reset;
    output [31:0]PC,Instr,SrcB,SrcA,ALUResult,DataOut,Outimm,toWD3;
    output [5:0]Op,Funct;
    output PCEn,InstrmemWr,IRWrite,foreRegDst,zero,foreRegWrite,ALUSrcA,ALUSrcB,RD,WD,signext,MemOrReg;
    output[10:0]ALUControl;
    output [1:0]PCSrc;
    wire [31:0]PCIn,PCPlus4,JPC,RD1,RD2,WD3,Signimm,A,B;
    wire overflow,carryout,sign,remd,RegWrite,RegDst;
    wire [4:0]rs,rt,rd,shamt,A3,fromshamt;
    wire [15:0]imm;
    wire [25:0]j_imm,forej_imm;
    Pcclk pcclk(PCIn,CLK,PCEn,PC,reset);
    Pcplus4 pcplus4(PC,PCPlus4);
Instrmemory instrmemory(PC,Instr,InstrmemWr); 
Instrclk instrclk(IRWrite,Instr,CLK,Op,reset,rs,rt,rd,shamt,imm,Funct,j_imm);
Jpc jpc(PCPlus4,forej_imm,JPC);
Rdorrt rdorrt(rt,rd,foreRegDst,A3);
Controlunit controlunit(CLK,reset,Op,Funct,PCEn,InstrmemWr,IRWrite,RegDst,RegWrite,PCSrc,ALUSrcA,ALUSrcB,ALUControl,RD,WD,signext,MemOrReg);
Registerfile registerfile(foreRegWrite,rs,rt,A3,toWD3,RD1,RD2);
Rdclk rdclk(CLK,reset,RD1,RD2,A,B);
Choosepc choosepc(Outimm,JPC,PCPlus4,PCIn,PCSrc,RD1,zero);
Sltsrcb sltsrcb(ALUSrcB,B,Outimm,SrcB);
SltSrcA sltsrca(fromshamt,ALUSrcA,SrcA,A);
Alu alu(SrcA,SrcB,ALUControl,overflow,zero,carryout,sign,ALUResult,remd);
Aluoutclk aluoutclk(CLK,reset,shamt,fromshamt);
Datamemory datamemory(ALUResult,(~{32{foreRegWrite&~foreRegDst}}&B)|({32{foreRegWrite&~foreRegDst}}&toWD3),RD,WD,DataOut);
    Signextend signextend(imm,Signimm,signext);
    Storeimm storeimm(Signimm,CLK,Outimm,reset);
    Storeimm storej_imm(j_imm,CLK,forej_imm,reset);
    Storeimm storeregwrite(RegWrite,CLK,foreRegWrite,reset);
    Storeimm storeregdst(RegDst,CLK,foreRegDst,reset);
    Resultorout resultorout(ALUResult,DataOut,MemOrReg,WD3);
   WD3clk wd3clk(CLK,reset,WD3,toWD3);
endmodule
