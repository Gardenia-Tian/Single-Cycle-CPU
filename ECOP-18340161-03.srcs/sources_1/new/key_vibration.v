`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/19 17:59:27
// Design Name: 
// Module Name: key_vibration
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


module key_vibration(
    input CLK,
    input key,
    output reg key_en
    );
    //�趨����ÿ��DURATION��ô����ʱ���ȡһ��
    parameter DURATION = 5000;
    reg [15:0] cnt;//��������
    initial cnt = 16'b0;
    always@(posedge CLK)
    begin 
        if(key==1) begin//��ʾ�����������ȥ��
            if(cnt==DURATION) 
                cnt <= cnt;
            else 
                cnt <= cnt + 1;
        end
        else
            cnt <= 16'b0;
    end
    
    always@(posedge CLK) begin//ÿ��ʱ������ʱ���ж������Ƿ��ʹ����
        if(key) key_en <= (cnt==DURATION-1'b1)?1'b1:1'b0;
    end
    
endmodule