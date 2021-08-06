`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 21:21:57
// Design Name: 
// Module Name: Sltsrcb
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


module Sltsrcb(ALUSrcB,B,Outimm,SrcB);
    input [31:0]B,Outimm;
    input ALUSrcB;
    output [31:0]SrcB;
    assign SrcB=({32{ALUSrcB}}&Outimm)|(~{32{ALUSrcB}}&B);
endmodule
