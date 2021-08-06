`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 18:33:56
// Design Name: 
// Module Name: Registerfile
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


module Registerfile(WE3,A1,A2,A3, WD3,RD1,RD2);
    input WE3;                      
    input  [4:0] A1,A2,A3;           
    input [31:0] WD3;               
    output [31:0] RD1,RD2;       

    reg [31:0] rf[31:0];             
     integer i;
    initial begin
    for (i = 0; i < 32; i = i+1) rf[i] = 32'h0;
    rf[1] = 32'h1;
    rf[4] = 32'h2;
    end
always@(*)  rf[A3] =({32{WE3}}&WD3)|(~{32{WE3}}&rf[A3]);          
    assign RD1 = rf[A1];
    assign RD2 = rf[A2];
endmodule
