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
        //定义一个位宽是32的寄存器堆
        reg [31:0] registers[0:31];
        integer index;//循环控制变量
    
        //把寄存器的初始值都赋为零
        initial
        begin
            for(index = 0;index<32;index = index + 1)
                registers[index] <= 0;
        end
    
        //不用等信号，可以直接读
        assign Read_Data1 = Read_reg1?registers[Read_reg1]:0;
        assign Read_Data2 = Read_reg2?registers[Read_reg2]:0;
        

        //如果要写的话，要等时钟信号，这里用时钟的下降沿
        always@(negedge CLK)
        begin
            if(RegWre && Write_reg )//要注意零号寄存器是不能写的，所以条件判断的地方要加上Write_reg来判断目的寄存器是否为零号寄存器
                registers[Write_reg] <= Write_Data;//如果目的寄存器不是零号寄存器，就在时钟到来的时候，把数据写进寄存器
        end    
        
endmodule
