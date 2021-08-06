`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/19 10:27:20
// Design Name: 
// Module Name: Storeimm
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


module Storeimm(Signimm,CLK,Outimm,reset

    );
    input [31:0]Signimm;
    input CLK,reset;
    output reg[31:0]Outimm;
    always@(posedge CLK or negedge reset)
    begin
    if(!reset)
    begin
    Outimm=32'b0;
    end
    else begin
    Outimm=Signimm;
    end
    end
endmodule
