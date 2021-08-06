`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 18:37:58
// Design Name: 
// Module Name: Alu
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


module Alu(put0,put1,op,overflow,zero,carryout,sign,out,remd);
    parameter bit_width = 32;   //32bit ALU
    input wire[bit_width-1:0]put0,put1;
    input wire [10:0] op;   //11bit op
    reg cin,cin0,cin1;
    reg cout0,cout1;
    output reg overflow,zero,carryout,sign;    //1bit flag
    output reg [31:0]remd;
    output reg [bit_width-1:0] out;
    reg [bit_width-1:0] put1_tmp;
    wire [31:0]p,g,c;
    
    initial
    begin
    cin0<=1'b0;
    cin1<=1'b0;
    remd<=1'b0;
    end  
    
    task addu;
    input wire [31:0] add1;
    input  wire [31:0] add2;
    input  wire cin0;
    output  reg[31:0] sum;
    output reg cout0;
    reg[31:0] p,g,c;
    begin
    c[0]=cin0;
    p=add1^add2;
    g=add1&add2;
  c[0] = g[0] | (p[0] & c[0]);
   c[1] = g[1] | (p[1] & (g[0] | (p[0] & c[0])));
    c[2] = g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))));
    c[3] = g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))));
    c[4] = g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))));
     c[5] = g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))));
     c[6] = g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))));
     c[7] = g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))));
     c[8] = g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))));
       c[9] =g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))));
       c[10] =g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))));
      c[11]=g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))));
      c[12]=g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))));
        c[13]=g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))));
         c[14]=g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))));
          c[15]=g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))));
          c[16]=g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))));
         c[17]=g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))));
        c[18]=g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))));
          c[19]=g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))));
          c[20]=g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))));
          c[21]=g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))));
           c[22]=g[22]|(p[22]&(g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))))));
            c[23]=g[23]|(p[23]&(g[22]|(p[22]&(g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))))))));
           c[24]=g[24]|(p[24]&(g[23]|(p[23]&(g[22]|(p[22]&(g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))))))))));
            c[25]=g[25]|(p[25]&(g[24]|(p[24]&(g[23]|(p[23]&(g[22]|(p[22]&(g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))))))))))));
            c[26]=g[26]|(p[26]&(g[25]|(p[25]&(g[24]|(p[24]&(g[23]|(p[23]&(g[22]|(p[22]&(g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))))))))))))));
             c[27]=g[27]|(p[27]&(g[26]|(p[26]&(g[25]|(p[25]&(g[24]|(p[24]&(g[23]|(p[23]&(g[22]|(p[22]&(g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))))))))))))))));
             c[28]=g[28]|(p[28]&(g[27]|(p[27]&(g[26]|(p[26]&(g[25]|(p[25]&(g[24]|(p[24]&(g[23]|(p[23]&(g[22]|(p[22]&(g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))))))))))))))))));
              c[29]=g[29]|(p[29]&(g[28]|(p[28]&(g[27]|(p[27]&(g[26]|(p[26]&(g[25]|(p[25]&(g[24]|(p[24]&(g[23]|(p[23]&(g[22]|(p[22]&(g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
               c[30]=g[30]|(p[30]&(g[29]|(p[29]&(g[28]|(p[28]&(g[27]|(p[27]&(g[26]|(p[26]&(g[25]|(p[25]&(g[24]|(p[24]&(g[23]|(p[23]&(g[22]|(p[22]&(g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
                c[31]=g[31]|(p[31]&(g[30]|(p[30]&(g[29]|(p[29]&(g[28]|(p[28]&(g[27]|(p[27]&(g[26]|(p[26]&(g[25]|(p[25]&(g[24]|(p[24]&(g[23]|(p[23]&(g[22]|(p[22]&(g[21]|(p[21]&(g[20]|(p[20]&(g[19]|(p[19]&(g[18]|(p[18]&(g[17]|(p[17]&(g[16]|(p[16]&(g[15]|(p[15]&(g[14]|(p[14]&(g[13]|(p[13]&(g[12]|(p[12]&(g[11]|(p[11]&(g[10]|(p[10]&(g[9] |(p[9]&(g[8]|(p[8]&(g[7] | (p[7] & (g[6] | (p[6] & (g[5] | (p[5] & (g[4] | (p[4] & (g[3] | (p[3] & (g[2] | (p[2] & (g[1] | (p[1] & (g[0] | (p[0] & c[0])))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
     sum=p^{c[30:0],cin0};
     cout0=c[31];
  end
endtask

task add;
input reg signed [31:0] add1;
input reg signed [31:0] add2;
input reg signed cin0;
output reg signed [31:0]  sum;
output reg signed cout0;
begin
    addu(add1,add2,cin0,sum,cout0);
    end
    endtask
    
task sub;
input reg signed [31:0] sub1;
input reg signed [31:0] sub2;
output reg signed [31:0]  cha;
output reg cin;
begin
    subn(sub1,sub2,cha,cin);
    end
    endtask

task subn;
parameter n=32;
 input wire[n-1:0] x; 
 input wire [n-1:0] y; 
 output reg[n-1:0] d;
 output reg cin; //diff output reg cin; //borrow from high bit 
 reg [n:0] c; 
 integer k; 
 begin 
 c[0] = 1'b0; 	
  for(k = 0; k < n; k = k + 1)
   begin 	 d[k] = x[k]^y[k]^c[k]; 		
   c[k+1] = (~x[k]&(y[k]^c[k]))|(y[k]&c[k]); 	
    end 	 
    cin = c[n];
    end
     endtask
     
    task mult32;
    reg [63:0] pv;
    reg [63:0] ap;
    integer i;
    input  wire [31:0] a;
    input  wire[31:0] b;
    output reg  [63:0]p;
        begin
            pv=64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
            ap={32'b0000_0000_0000_0000_0000_0000_0000_0000,a};
            for(i=0;i<=31;i=i+1)
                begin
                    if(b[i]==1)
                        pv=pv+ap;
                        ap={ap[62:0],1'b0};
                end
            p=pv;
        end
endtask




task div;  
    input reg[31:0] tempa;  
     input reg[31:0] tempb;  
    output reg[63:0] temp_a;  
    output reg[63:0] temp_b;  
    integer i;  
    begin  
        temp_a = {32'h00000000,tempa};  
        temp_b = {tempb,32'h00000000};   
        for(i = 0;i < 32;i = i + 1)  
            begin  
                temp_a = {temp_a[62:0],1'b0};  
                if(temp_a[63:32] >= tempb)  
                    temp_a = temp_a - temp_b + 1'b1;  
                else  
                    temp_a = temp_a;  
            end  
    
        out <= temp_a[31:0];  
        remd <= temp_a[63:32];  
    end  
    
endtask
    always@ (*)
    begin
        case (op)
            11'b00000_100000:   //add
            begin
                add (put0,put1,cin0,out,cout0);
                if (put0[bit_width-1] == put1[bit_width-1])
                begin
                     overflow = put1[bit_width-1]^out[bit_width-1];
                end
                else
                begin
                     overflow = 0;
                end
                zero = ~(|out);
                carryout=0;
                 
                //carryout undefined
            end
            
            11'b00000_100001:   //addu
            begin
          addu (put0,put1,cin0,out,cout1);
             carryout=cout1;
                zero= ~(|out);
                //overflow undefined
            end
            
            11'b00000_100010:   //sub
            begin
          sub(put0,put1,out,cin);
                put1_tmp = -put1;
                if (put0[bit_width-1] == put1_tmp[bit_width-1])
                begin
                    overflow = put1_tmp[bit_width-1]^out[bit_width-1];
                end
                else
                begin
                    overflow = 0;
                end
                zero = ~(|out);
                //carryout undefined
            end
            
            11'b00000_100011:   //subu
            begin
            subn(put0,put1,out,cin1);
                zero= ~(|out);
                //overflow undefined
            end
            
            11'b00000_100100:   //and
            begin
                out      = put0&put1;
                carryout = 0;
                overflow = 0;
                zero     = ~(|out);
            end
            
            11'b00000_100101:   //or
            begin
                out      = put0|put1;
                carryout = 0;
                overflow = 0;
                zero     = ~(|out);
            end
            
            11'b00000_100110:   //xor
            begin
                out      = put0^put1;
                carryout = 0;
                overflow = 0;
                zero     = ~(|out);
            end
            
            11'b00000_100111:   //nor
            begin
                out      = ~(put0|put1);
                carryout = 0;
                overflow = 0;
                zero     = ~(|out);
            end
            
            11'b00000_101010:   //slt:if rs<rt then rd=1
            begin
                put1_tmp = -put1;
                out     = put0+put1_tmp;
                if (put0[bit_width-1] == put1_tmp[bit_width-1])
                begin
                    overflow = put1_tmp[bit_width-1]^out[bit_width-1];
                end
                else
                begin
                    overflow = 0;
                end
                out = $signed(put0)<$signed(put1);
                if (put0 == put1)
                    zero = 1;
                else
                    zero = 0;
                    //carryout undefined
            end
            
            11'b00000_101011:   //sltu
            begin
                out = put0<put1;
                if (put0 == put1)
                    zero = 1;
                else
                    zero = 0;
                    //carryout and overflow undefined
            end
            
            11'b00000_000000:    //sll shift left logically:<-shamt
            begin
                carryout = put0[bit_width-2];
                out      = put1<<put0;
                // overflow undefined
                zero = ~(|out);
            end
            
            11'b00000_000010:    //srl shift right logically:->shamt
            begin
                carryout = put0[1];
                out      = put1>>put0;
                // overflow undefined
                zero = ~(|out);
            end
            
            11'b00000_000011:    //sra shift right arithmetically:????????->shamt
            begin
                carryout = put0[1];
                out      = ($signed(put1))>>>put0;
                // overflow undefined
                zero = ~(|out);
            end
            
            11'b00000_000100:   //sllv shift left logically value:rd <- rt << rs
            begin
                out      = put1<<(put0-1);
                carryout = out[bit_width-1];
                out      = out<<1;
                if (put0 == 1) begin
                    if (out[bit_width-1] == carryout)
                    begin
                        overflow = 0;
                    end
                    else begin
                        overflow = 1;
                    end
                    // else overflow undefined
                end
                zero = ~(|out);
            end
            
            11'b00000_000110:   //srlv shift right logically value:rd <- rt >> rs
            begin
                
                if (put0 == 1) begin
                    overflow = put1[bit_width-1];
                end
                // else overflow undefined
                out      = put1>>(put0-1);
                carryout = out[0];
                out      = out>>1;
                zero     = ~(|out);
            end
            
            11'b00000_000111:   //srav shift right arithmetically valuez;rd <- rt >> rs
            begin
                out      = ($signed(put1))>>>(put0-1);
                carryout = out[0];
                out      = ($signed(out))>>>1;
                overflow = 0;
                zero     = ~(|out);
            end
            
            11'b00000_001000:   
           //mult
     begin
   mult32(put0,put1,out);
     overflow=0;
     carryout=0;
     end
     
      11'b00000_001001:   //div
     begin
  div(put0,put1,out,remd);
     overflow=0;
     carryout=0;
     end
            default:    //do nothing
            begin
                out      = 0;
                carryout = 0;
                overflow = 0;
                zero     = ~(|out);
            end
        endcase
        sign = out[bit_width-1];
    end
endmodule
