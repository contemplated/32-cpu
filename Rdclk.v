`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 21:15:00
// Design Name: 
// Module Name: Rdclk
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


module Rdclk(CLK,reset,RD1,RD2,A,B

    );
    input CLK,reset;
    input [31:0]RD1,RD2;
    output reg [31:0]A,B;
    always@(posedge CLK or negedge reset)
    begin
    if(!reset)
    begin
    A=32'b0;
    B=32'b0;
    end
    else
    begin
    A=RD1;
    B=RD2;
    end
    end
endmodule
