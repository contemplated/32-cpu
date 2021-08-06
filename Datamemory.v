`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 22:54:39
// Design Name: 
// Module Name: Datamemory
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


module Datamemory(Addr,DataIn,RD,WD,DataOut);
input RD,WD;
     input [31:0] Addr, DataIn;
     output reg[31:0] DataOut;
     reg [31:0] Memory[31:0];
    integer i;
     initial begin
     for (i = 0; i < 32; i = i+1)
     begin
     Memory[i]=32'b1;
     end
     end
  always@(*)
  begin
      Memory[Addr] = ({32{WD}}&DataIn)|(~{32{WD}}&Memory[Addr]);
    DataOut = ({32{RD}}&Memory[Addr]);
    end
endmodule
