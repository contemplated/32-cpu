`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 22:16:30
// Design Name: 
// Module Name: tb_cpu4
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


module tb_cpu4(

    );
    reg CLK,reset;
    wire [31:0]PC,Instr,toWD3,SrcB,SrcA,ALUResult,DataOut,Outimm;
    wire [5:0]Op,Funct;
    wire PCEn,InstrmemWr,IRWrite,foreRegDst,zero,foreRegWrite,ALUSrcA,ALUSrcB,RD,WD,signext,MemOrReg;
    wire[10:0]ALUControl;
    wire [1:0]PCSrc;
    initial
    begin
    CLK=0;
    reset=0;
    #5
    reset=1;
    end
    always#26
    CLK=~CLK;
    cpu4 u_cpu4(CLK,reset,PC,Instr,toWD3,SrcB,SrcA,ALUResult,DataOut,Op,Funct,PCEn,InstrmemWr,IRWrite,
foreRegDst,zero,foreRegWrite,ALUSrcA,ALUSrcB,RD,WD,signext,MemOrReg,ALUControl,PCSrc,Outimm
    );
endmodule
