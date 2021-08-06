`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 17:47:24
// Design Name: 
// Module Name: WD3clk
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


module WD3clk(CLK,reset,WD3,toWD3);
input CLK,reset;
input [31:0]WD3;
output reg[31:0]toWD3;
always@(posedge CLK or negedge reset)
begin
if(!reset)
toWD3=32'b0;
else
toWD3=WD3;
end
endmodule
