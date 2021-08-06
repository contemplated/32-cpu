`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 20:53:47
// Design Name: 
// Module Name: Signextend
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


module Signextend(imm,SignImm,signext);
 input [15:0]imm; 
 input signext;
 output [31:0] SignImm; 
 assign SignImm = (signext == 1'b0)?{16'b0,imm} : {{16{imm[15]}}, imm};

 
endmodule

