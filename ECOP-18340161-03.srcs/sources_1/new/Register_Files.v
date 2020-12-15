`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:25:21
// Design Name: 
// Module Name: Register_Files
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


module Register_Files(
    input [4:0] Read_reg1,
    input [4:0] Read_reg2,
    input [4:0] Write_reg,
    input RegWre,
    input CLK,
    input [31:0] Write_Data,
    output [31:0] Read_Data1,
    output [31:0] Read_Data2
    );
        //����һ��λ����32�ļĴ�����
        reg [31:0] registers[0:31];
        integer index;//ѭ�����Ʊ���
    
        //�ѼĴ����ĳ�ʼֵ����Ϊ��
        initial
        begin
            for(index = 0;index<32;index = index + 1)
                registers[index] <= 0;
        end
    
        //���õ��źţ�����ֱ�Ӷ�
        assign Read_Data1 = Read_reg1?registers[Read_reg1]:0;
        assign Read_Data2 = Read_reg2?registers[Read_reg2]:0;
        

        //���Ҫд�Ļ���Ҫ��ʱ���źţ�������ʱ�ӵ��½���
        always@(negedge CLK)
        begin
            if(RegWre && Write_reg )//Ҫע����żĴ����ǲ���д�ģ����������жϵĵط�Ҫ����Write_reg���ж�Ŀ�ļĴ����Ƿ�Ϊ��żĴ���
                registers[Write_reg] <= Write_Data;//���Ŀ�ļĴ���������żĴ���������ʱ�ӵ�����ʱ�򣬰�����д���Ĵ���
        end    
        
endmodule
