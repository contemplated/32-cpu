`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 22:54:18
// Design Name: 
// Module Name: Instrmemory
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


module Instrmemory(PC,Instr,InstrmemWr
);

input [31:0] PC;
input InstrmemWr;
    output [31:0] Instr;
wire[31:0]Rom[15:0];

assign Rom[32'h0]=32'b000000_00001_00010_00011_00000_100000;
//add $3=$2+$1 0
assign Rom[32'h1]=32'b000000_00001_00010_00011_00000_100001;
//addu $3=$2+$1 4
assign Rom[32'h2]=32'b000000_00001_00010_00011_00000_100010;
//sub $3=$2-$1 8
assign Rom[32'h3]=32'b000000_00001_00010_00011_00000_100011;
//subu $3=$2+$1 c
assign Rom[32'h4]=32'b000000_00001_00010_00011_00000_100100;
//and $3=$2&$1 10
assign Rom[32'h5]=32'b001101_00001_00010_0000000000000111;
//ori $2=$1|7 14
assign Rom[32'h6]=32'b100011_00001_00010_0000000000001110;
//lw $2,14($1) 18
assign Rom[32'h7]=32'b101011_00001_00010_0000000000000111;
//sw $2,7($1) 1c
assign Rom[32'hE]=32'b000100_00001_00010_0000000000001010;
//beq $2,$1,10 在译码时当前流水线上指令再变化指令
//j 在执行阶段取当前指令再变化指令加入流水线，
assign Rom[32'h8]=32'b000000_00000_00010_00011_00011_000000;//sll 
assign Rom[32'h9]=32'b000000_00000_00010_00011_00011_000010;//srl 
assign Rom[32'hA]=32'b000000_00000_00010_00011_00011_000011;//sra 
assign Rom[4'hB]=32'b000000_00001_00010_00011_00011_000100;//sllv 
assign Rom[4'hC]=32'b000000_00001_00010_00011_00011_000110;//srlv 
assign Rom[4'hD]=32'b000000_00001_00010_00011_00011_000111;//srav 
assign Rom[32'hF]=32'b000010_00000000000000000000000100;//j

assign Instr=({32{InstrmemWr}}&Rom[PC[5:2]]);

endmodule
