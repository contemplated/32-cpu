`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 13:33:03
// Design Name: 
// Module Name: Controlunit
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


module Controlunit(CLK,reset,Op,Funct,
PCEn,InstrmemWr,IRWrite,RegDst,RegWrite,PCSrc,ALUSrcA,ALUSrcB,ALUControl,RD,WD,signext,MemOrReg);
input  [5:0]Op,Funct;
input CLK,reset;
output reg PCEn,InstrmemWr,IRWrite,RegDst,RegWrite,ALUSrcA,ALUSrcB,RD,WD,MemOrReg;
output wire signext;
output reg[1:0]PCSrc;
output reg [10:0]ALUControl;
wire R_type,is_add,is_sub,is_addu,is_subu,is_and,is_or;
wire is_xor,is_nor,is_ori,is_lw,is_sw,is_beq,is_j;
wire is_sll,is_srl,is_sra,is_sllv,is_srlv,is_srav;
/** R_type **/

assign 
R_type=~|Op, //~| is reduction NOR, that is, all the bits are NOR together. When Op=000000, the result is 1, that is, R-type. The circuit and performance are the same with Op==000000
is_add=R_type&Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&~Funct[1]&~Funct[0],  //add: R_type and Funct=100000
is_sub=R_type&Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&Funct[1]&~Funct[0], //sub: R_type and Funct=100010
is_addu=R_type&Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&~Funct[1]&Funct[0],  //addu: R_type and Funct=100001
is_subu=R_type&Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&Funct[1]&Funct[0],    //subu: R_type and Funct=100011
is_and=R_type&Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&~Funct[1]&~Funct[0],   //and: R_type and Funct=100100
is_or=R_type&Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&~Funct[1]&Funct[0],    //or: R_type and Funct=100101
//wire is_addi=~Op[5]&~Op[4]&Op[3]&~Op[2]&~Op[1]&~Op[0];
//wire is_andi=~Op[5]&~Op[4]&Op[3]&Op[2]&~Op[1]&~Op[0];
is_xor=R_type&Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&Funct[1]&~Funct[0],   //xor: R_type and Funct=100110
is_nor=R_type&Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&Funct[1]&Funct[0],   //nor: R_type and Funct=100111

/** I_type **/
is_ori=~Op[5]&~Op[4]&Op[3]&Op[2]&~Op[1]&Op[0],  //ori: Op=001101 
is_lw=Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0],  //lw: Op=100011
is_sw=Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&Op[0],   //sw: Op=101011
is_beq=~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&~Op[0],    //beq: Op=000100

/** J_type **/
//wire is_bne=~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&Op[0];
signext=is_lw|is_sw,
is_j=~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&~Op[0],//j: Op=000010

is_sll=R_type&~Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&~Funct[1]&~Funct[0],//000000
is_srl=R_type&~Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&Funct[1]&~Funct[0],//000010
is_sra=R_type&~Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&Funct[1]&Funct[0],//000011
is_sllv=R_type&~Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&~Funct[1]&~Funct[0],//000100
is_srlv=R_type&~Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&Funct[1]&~Funct[0],//000110
is_srav=R_type&~Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&Funct[1]&Funct[0];//000111

 
always@ (posedge CLK or negedge reset)
begin
if(!reset)
 begin
PCEn=1'b0;
InstrmemWr=1'b0;
IRWrite=1'b0;
RegDst=1'b0;
RegWrite=1'b0;
PCSrc=2'b00;
ALUSrcA=1'b0;
ALUSrcB=1'b0;
ALUControl=32'b00000_100000;
RD=1'b0;
WD=1'b0;
MemOrReg=1'b0;
 end
else
begin
PCEn=1'b1;
InstrmemWr=1'b1;
IRWrite=1'b1;
RegDst=R_type;
RegWrite=R_type|is_ori|is_lw;
PCSrc=({2{R_type|is_ori|is_lw|is_sw}}&2'b00)|({2{is_beq}}&2'b01)|({2{is_j}}&2'b11);
ALUSrcB=is_ori|is_lw|is_sw;
ALUSrcA=is_sll|is_srl|is_sra;
ALUControl={5'b00000,is_add|is_sub|is_addu|is_subu|is_and|is_or|is_xor|is_nor|is_ori|is_lw|is_sw|is_beq|is_j,
2'b00,is_and|is_or|is_xor|is_nor|is_ori|is_sllv|is_srlv|is_srav,is_srl|is_sra||is_srlv|is_srav|is_sub|is_subu|
is_xor|is_nor|is_beq,is_addu|is_subu|is_or|is_nor|is_ori|is_beq|is_lw|is_sw|is_sra|is_srav};
RD=is_lw|is_sw;
WD=is_sw;
MemOrReg=is_lw;
end
end
endmodule
