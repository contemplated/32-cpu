`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 17:12:37
// Design Name: 
// Module Name: Jpc
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


module Jpc(PCPlus4,j_imm,JPC);
    input[31:0]PCPlus4;
    input[25:0]j_imm;
    output[31:0]JPC;
    assign JPC={PCPlus4[31:28],j_imm,2'b00};
endmodule
