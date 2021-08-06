`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 21:23:01
// Design Name: 
// Module Name: Resultorout
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


module Resultorout(
ALUResult,DataOut,MemOrReg,WD3
    );
    input MemOrReg;
    input [31:0]ALUResult,DataOut;
    output [31:0]WD3;
    assign WD3=({32{MemOrReg}}&DataOut)|(~{32{MemOrReg}}&ALUResult);
endmodule
