`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:31:21
// Design Name: 
// Module Name: upDatePC
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

//更新PC
module upDatePC(
    input [31:0] oldPC,//输入的旧的PC
    input [1:0] PCSrc,//PC的来源
    input [31:0] imm,//立即数，要做计算的
    input [27:2] j_Addr,//跳转地址
    output reg [31:0] newPC//输出的新的PC
    );
    always@(*)
    begin
        if(PCSrc==2'b00)
            newPC[31:0] = oldPC + 4;
        else if(PCSrc==2'b01)
            newPC[31:0] = oldPC + 4 + (imm<<2);
        else
            newPC[31:0] = {oldPC[31:28],j_Addr[27:2],2'b00};
    end     
    
endmodule
