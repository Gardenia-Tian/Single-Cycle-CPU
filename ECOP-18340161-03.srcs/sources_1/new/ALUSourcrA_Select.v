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

//选择ALU操作数的数据来源
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
        //这一部分就是给手动进行了一下扩展，而没有连到扩展部件里面去
            result[4:0] = sa;
            result[31:5] = 27'b000000000000000000000000000;
        end
        else
            result = Read_Data;
     end
endmodule
