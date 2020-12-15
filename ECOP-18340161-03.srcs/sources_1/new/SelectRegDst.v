`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:24:39
// Design Name: 
// Module Name: SelectRegDst
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

//这个其实就是一个五路二选一数据选择器
module SelectRegDst(
    input RegDst,
    input [4:0] Rd,
    input [4:0] Rt,
    output reg [4:0] DstReg
    );
    always@(*)
        begin
            if(RegDst)
                DstReg[4:0] = Rd[4:0];
            else
                DstReg[4:0] = Rt[4:0];
        end    
endmodule
