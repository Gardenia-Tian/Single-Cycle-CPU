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
       assign zero = (result==0);//���־λ��־����Ƿ�Ϊ��
       assign sign = result[0];//�����־λ��ĺÿ��˰���������
       //sign��־Ϊ��־����A-B�ķ��ţ�Ҳ������A<B����ôA-B<0��signӦ��Ϊ1��ͬʱresult�ıȽϽ��ҲΪ1
       //  A>B����ôA-B>0��signӦ��Ϊ0��ͬʱresult�ıȽϽ��ҲΪ��
       //signӦ��ȡ����result�����Ϊ���������λ����ʵsignҲ�ǿ���û�еģ�������Ϊдʱ���Ǻ����ŷ��ֵģ���Ҳû��ɾ
       
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
