`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 17:24:36
// Design Name: 
// Module Name: Choosepc
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


module Choosepc(Outimm,JPC,PCPlus4,PCIn,PCSrc,RD1,zero);
input [31:0]Outimm,JPC,PCPlus4,RD1;
input wire zero;
input wire[1:0]PCSrc;
output reg[31:0] PCIn;
always@ (*)
    begin
case(PCSrc)
2'b00:
begin
PCIn=PCPlus4;
end
2'b01://beq
begin
PCIn=({32{zero}}&(PCPlus4+(Outimm<<2)))|(~{32{zero}}&PCPlus4);
end
2'b10:
begin
PCIn=RD1;
end
2'b11:
begin
 PCIn=JPC;
end
endcase
end
endmodule