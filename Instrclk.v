`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 19:13:15
// Design Name: 
// Module Name: Instrclk
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


module Instrclk(IRWrite,Instr,CLK,Op,reset,
rs,rt,rd,shamt,imm,Funct,j_imm);
    input IRWrite,CLK,reset;
    input [31:0]Instr;
    output reg[5:0] Op;
    output reg[4:0] rs,rt,rd,shamt;
    output reg[15:0] imm;
    output reg[5:0] Funct;
    output reg[25:0]j_imm;
wire[31:0]instruction;
assign instruction=Instr;

always@(posedge CLK or negedge reset)
begin
if(!reset)
begin
Op=6'b0;
rs=5'b0;
rt=5'b0;
rd=5'b0;
shamt=5'b0;
imm=16'b0;
Funct=6'b0;
j_imm=26'b0;
end
else
begin
if(IRWrite)
begin
 Op =instruction[31:26];
 rs =instruction[25:21];
 rt =instruction[20:16];
 rd =instruction[15:11];
 shamt =instruction[10:6];
 Funct =instruction[5:0];
 imm =instruction[15:0];
 j_imm=instruction[25:0];
 end
else
begin
Op=Op;
rs=rs;
rt=rt;
rd=rd;
shamt=shamt;
Funct=Funct;
imm=imm;
j_imm=j_imm;
end
end
end
endmodule