`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/21 16:36:57
// Design Name: 
// Module Name: SltSrcA
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


module SltSrcA(shamt,ALUSrcA,SrcA,A

    );
    input [31:0]A;
    input ALUSrcA;
    input [4:0]shamt;
    output [31:0]SrcA;
    wire [31:0]Shamt;
    assign Shamt={27'b0,shamt};
   assign SrcA=({32{ALUSrcA}}&shamt)|(~{32{ALUSrcA}}&A);
endmodule
