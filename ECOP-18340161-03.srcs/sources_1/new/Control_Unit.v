`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:32:07
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input [5:0] op,
    input [5:0] func,
    input zero,
    input sign,
    output reg RegWre,
    output reg RegDst,
    output reg [2:0] ALUop,
    output reg [1:0] PCSrc,
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg DBDataSrc,
    output reg mRD,
    output reg mWR,
    output reg ExtSel,
    output reg PCWre,
    output reg InsMemRw
    );
    
        //定义了一些常量，增加程序的可读性
        parameter ADD = 6'b100000;
        parameter SUB = 6'b100010;
        parameter AND = 6'b100100;
        parameter OR = 6'b100101;
        parameter SLL = 6'b000000;
        parameter ADDIU = 6'b001001;
        parameter ANDI = 6'b001100;
        parameter ORI = 6'b001101;
        parameter SLTI = 6'b001010;
        parameter SW = 6'b101011;
        parameter LW = 6'b100011;
        parameter BEQ = 6'b000100;
        parameter BNE = 6'b000101;
        parameter BLTZ = 6'b000001;
        parameter J = 6'b000010;
        parameter HALT = 6'b111111;
    
        //这里！！！！一定要给赋初值，要不然程序时不能正确进行的！！！
        //因为在最开始的时候PC是没有内容可以给我们译码的，那么有一些控制型号不能自动生成，所以有一些控制信号最开始一定要赋初始值，这样程序才能启动
        initial begin
            InsMemRw = 1;
            PCWre = 1;
            RegDst = 1;
            ALUop = 3'b000;
        end    
    
        //这一部分就是根据真值表写控制信号了
        always@(*)
        begin
            if(op == 6'b000000)
            begin
                PCWre = 1;
                ALUSrcA = (func==SLL)?1:0;
                ALUSrcB = 0;
                DBDataSrc = 0;
                RegWre = 1;
                InsMemRw = 1;
                mRD = 0;
                mWR = 0;
                RegDst = 1;
                ExtSel = (func==SLL)?0:1;
                PCSrc = 2'b00;
                ALUop[2] = (func==AND)?1:0;
                ALUop[1] = (func==OR||func==SLL)?1:0;
                ALUop[0] = (func==SUB||func==OR)?1:0;
            end
            else
            begin
                PCWre = (op==HALT)?0:1;
                ALUSrcA = 0;
                ALUSrcB =(op==BEQ||op==BNE||op==BLTZ)?0:1;
                DBDataSrc = (op==LW)?1:0;
                RegWre = (op==ADDIU||op==ANDI||op==ORI||op==SLTI||op==LW)?1:0;
                InsMemRw = 1'b1;
                mRD = (op==LW)?1:0;
                mWR = (op==SW)?1:0;
                RegDst = 1'b0;
                ExtSel = (op==ANDI||op==ORI)?0:1;
                PCSrc = (op==J)? 2'b10 :(op==BEQ&&zero==1'b1)? 2'b01:(op==BNE&&zero==1'b0)?2'b01:(op==BLTZ&&sign==1'b1)?2'b01:2'b00;
                ALUop[2] = (op==ANDI||op==SLTI||op==BLTZ)?1:0;
                ALUop[1] = (op==ORI||op==SLTI||op==BLTZ)?1:0;
                ALUop[0] = (op==ORI||op==BEQ||op==BNE)?1:0;
            end
        end    
endmodule
