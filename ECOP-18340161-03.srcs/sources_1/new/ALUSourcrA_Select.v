`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:26:27
// Design Name: 
// Module Name: ALUSourcrA_Select
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

//ѡ��ALU��������������Դ
module ALUSourcrA_Select(
    input [4:0] sa,
    input [31:0] Read_Data,
    input ALUSrcA,
    output reg [31:0] result
    );
    
    always@(*)
    begin
        if(ALUSrcA==1)
        begin
        //��һ���־��Ǹ��ֶ�������һ����չ����û��������չ��������ȥ
            result[4:0] = sa;
            result[31:5] = 27'b000000000000000000000000000;
        end
        else
            result = Read_Data;
     end
endmodule
