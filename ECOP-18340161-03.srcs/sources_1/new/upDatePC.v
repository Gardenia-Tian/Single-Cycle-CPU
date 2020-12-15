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

//����PC
module upDatePC(
    input [31:0] oldPC,//����ľɵ�PC
    input [1:0] PCSrc,//PC����Դ
    input [31:0] imm,//��������Ҫ�������
    input [27:2] j_Addr,//��ת��ַ
    output reg [31:0] newPC//������µ�PC
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
