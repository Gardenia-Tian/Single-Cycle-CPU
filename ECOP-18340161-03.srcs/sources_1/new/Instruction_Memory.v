`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:22:39
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
    input [31:0] Read_Address,//��ʾָ��ĵ�ַ
    input InsMemRw,//дʹ���ź�
    output reg [31:0] Instruction//������ָ��
    );
    
    reg [7:0] memory[0:255];//һ���Ĵ������飬��ʾָ��memory���ʼ��ʱ������ʽΪ[255:0]��Ȼ��һֱ���������ĳ������ڵ���ʽ�Ͳ������ˣ����ǿ����ϵ����ϣ�Ҳ�кܶ�д����[255:0]���;�����������
   
   //���ļ��ж�ȡָ��
    initial
        begin
            $readmemh("E:/Instruction.txt",memory);
            //$display(memory[0]);
        end
    
    always@(*)
        begin
            //���ڴ��еĵ�ַ����
            if(InsMemRw)
                begin
                    Instruction[7:0] = memory[Read_Address + 3];
                    Instruction[15:8] = memory[Read_Address + 2];
                    Instruction[23:16] = memory[Read_Address + 1];
                    Instruction[31:24] = memory[Read_Address + 0];
                end
        end    
endmodule
