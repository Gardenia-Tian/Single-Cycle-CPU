`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:30:27
// Design Name: 
// Module Name: SignZeroExtend
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

//��չ����������������򵥵�һ��ģ����
module SignZeroExtend(
    input [15:0] imm_in,
    input Extop,
    output reg [31:0] imm_out
    );
   // reg [31:0] imm_out;

    always@(*)
    begin
        imm_out[15:0] = imm_in;
        imm_out[31:16] = Extop?(imm_in[15]?16'hffff:16'h0000):16'h0000;
    end
    
endmodule
