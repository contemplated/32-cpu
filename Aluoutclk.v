`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 21:22:23
// Design Name: 
// Module Name: Aluoutclk
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


module Aluoutclk(CLK,reset,shamt,fromshamt);
    input CLK,reset;
    input [4:0]shamt;
    output reg [4:0]fromshamt;
    always@(posedge CLK or negedge reset)
    begin
    if(!reset)
    begin
    fromshamt=5'b0;
    end
    else
    begin
    fromshamt=shamt;
    end
    end
endmodule
