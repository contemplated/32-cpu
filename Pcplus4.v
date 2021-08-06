`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 17:04:52
// Design Name: 
// Module Name: Pcplus4
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


module Pcplus4(PC,PCPlus4);
input [31:0]PC;
output [31:0]PCPlus4;
assign PCPlus4=PC+32'h4;
endmodule
