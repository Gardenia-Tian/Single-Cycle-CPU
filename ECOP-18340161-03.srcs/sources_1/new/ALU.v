`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:28:26
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUop,
    output  zero,
    output  sign,
    output reg [31:0] result
    );
       assign zero = (result==0);//零标志位标志结果是否为零
       assign sign = result[0];//这个标志位真的好坑人啊！！！！
       //sign标志为标志的是A-B的符号，也就是若A<B，那么A-B<0，sign应该为1，同时result的比较结果也为1
       //  A>B，那么A-B>0，sign应该为0，同时result的比较结果也为零
       //sign应该取的是result的最低为而不是最高位。其实sign也是可以没有的，但是因为写时候是后来才发现的，就也没再删
       
       always@(*)
       begin
           case(ALUop)
               3'b000 : result = A + B;
               3'b001 : result = A - B;
               3'b010 : result = B << A;
               3'b011 : result = A | B;
               3'b100 : result = A & B;
               3'b101 : result = (A<B) ? 1 : 0;
               3'b110 : result = (((A[31]==B[31])&&(A<B))||(A[31]==1&&B[31]==0))?1:0;
               3'b111 : result = A ^ B;
               default: result = 32'h00000000;
           endcase
       end    
    
endmodule
