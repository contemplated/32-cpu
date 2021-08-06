`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 18:58:33
// Design Name: 
// Module Name: Pcclk
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


module Pcclk(PCIn,CLK,PCEn,PC,reset

    );
    input CLK,reset,PCEn;
    input [31:0]PCIn;
    output reg[31:0]PC;
    always@(posedge CLK or negedge reset)
    begin
    if(!reset)
    PC=32'b0;
    else
    begin
    if(PCEn)
    PC=PCIn;
    end
    end
endmodule
