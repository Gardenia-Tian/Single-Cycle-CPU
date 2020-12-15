`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:29:17
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input CLK,
    input [31:0] Data_in,//要写入的数据
    input [31:0] Addr,//要写入的地址
    input mRD,//读使能
    input mWR,//写使能
    output reg [31:0] Data_out//读出的数据
    );
 
    integer index;
    reg[7:0] dataMemory [0:255];//数组代表存储器


    //初始的时候，把内存的值全部赋为零
    initial begin
	for(index = 0;index<256;index = index + 1)
	    dataMemory[index] = 0;
    end

    //把读出的数据赋值为0，这样如果不读的话就是零
    initial begin
        Data_out = 0;
    end

    //我们规定如果是写的话要等时钟，大端方式哦
    always@(negedge CLK)
    begin
        if(mWR==1)
        begin
        dataMemory[Addr+3] <=Data_in[7:0];
        dataMemory[Addr+2] <=Data_in[15:8]; 
        dataMemory[Addr+1] <=Data_in[23:16];
        dataMemory[Addr+0] <=Data_in[31:24]; 
        end
    end

    //如果是读的话不需要等时钟，只要地址和读使能有效就可以读
    always@(*)
    begin
        if(mRD==1)
        begin
            Data_out[7:0] <= dataMemory[Addr + 3];
            Data_out[15:8] <= dataMemory[Addr + 2];
            Data_out[23:16] <= dataMemory[Addr + 1];
            Data_out[31:24] <= dataMemory[Addr + 0];
        end
    end      
endmodule
