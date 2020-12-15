`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:27:29
// Design Name: 
// Module Name: DataSelect
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

//32路的二选一数据选择器
module DataSelect(
    input [31:0] Data1,
    input [31:0] Data2,
    input Select,
    output reg [31:0] Dataout
    );
    
    always@(*)
    begin
        if(Select==0)
            Dataout[31:0] <= Data1[31:0];
        else
            Dataout[31:0] <= Data2[31:0];
    end    
endmodule
