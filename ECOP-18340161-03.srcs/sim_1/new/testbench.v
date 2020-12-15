`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:33:51
// Design Name: 
// Module Name: testbench
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


module testbench();

    reg CLK;
    reg Reset;
    wire [31:0] Instr_Addr;//��ǰ��PCֵ
    wire [31:0] result;//ALU��������
    wire [4:0] rs;//Rs�Ĵ���
    wire [4:0] rt;//Rt�Ĵ���
    wire [31:0] Write_Data;//DataMem����ͨ·
    wire [31:0] newPC;//��һ��ָ���ַ 
    wire [31:0] Read_Data1;
    wire [31:0] Read_Data2;

    
    SingleCyleCPU utt(.Reset(Reset),.CLK(CLK),.Instr_Addr(Instr_Addr),.newPC(newPC),.rs(rs),.rt(rt),.Read_Data1(Read_Data1),.Read_Data2(Read_Data2),.result(result),
            .Write_Data(Write_Data));
     initial begin
                 CLK = 0;
                 Reset = 0;
                 #10 Reset=1;
               end
               
           always #5 CLK=~CLK;
        
endmodule
