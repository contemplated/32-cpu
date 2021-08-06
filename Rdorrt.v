`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 19:38:43
// Design Name: 
// Module Name: Rdorrt
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


module Rdorrt(rt,rd,RegDst,A3);
    input RegDst;
    input [4:0]rt,rd;
    output [4:0]A3;
    wire [4:0]extenedRegDst={{4{RegDst}}, RegDst};
    assign A3 = (rt&~extenedRegDst)|(rd&extenedRegDst);    
endmodule
