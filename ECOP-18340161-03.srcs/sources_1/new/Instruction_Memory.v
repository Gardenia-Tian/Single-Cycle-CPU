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
    input [31:0] Read_Address,//表示指令的地址
    input InsMemRw,//写使能信号
    output reg [31:0] Instruction//读到的指令
    );
    
    reg [7:0] memory[0:255];//一个寄存器数组，表示指令memory。最开始的时候定义形式为[255:0]，然后一直报错，后来改成了现在的形式就不报错了，但是看网上的资料，也有很多写的是[255:0]，就觉得这里很奇怪
   
   //从文件中读取指令
    initial
        begin
            $readmemh("E:/Instruction.txt",memory);
            //$display(memory[0]);
        end
    
    always@(*)
        begin
            //将内存中的地址读出
            if(InsMemRw)
                begin
                    Instruction[7:0] = memory[Read_Address + 3];
                    Instruction[15:8] = memory[Read_Address + 2];
                    Instruction[23:16] = memory[Read_Address + 1];
                    Instruction[31:24] = memory[Read_Address + 0];
                end
        end    
endmodule
