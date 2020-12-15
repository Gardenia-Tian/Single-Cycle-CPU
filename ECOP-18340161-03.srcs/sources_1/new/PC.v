`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:21:22
// Design Name: 
// Module Name: PC
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


module PC(
    input [31:0] newPC,
    input CLK,
    input Reset,
    input PCWre,
    output reg [31:0] Instr_Addr
    );
    //Reset�Ǻ����ȵģ�ֻҪReset�����0��������
    always@(negedge Reset or negedge CLK)
    begin
        if(Reset==0)//���Ҫ����Ļ���PCֵȫ����Ϊ0
            Instr_Addr[31:0] = 32'h00000000;
        else
        begin
            if(PCWre==1)//���PC��дʹ��Ϊ�棬��ô��Ҫд���µ�PC
                Instr_Addr[31:0] = newPC;
        end   
    end

endmodule
