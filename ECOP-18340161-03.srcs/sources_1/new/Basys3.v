`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/19 13:38:46
// Design Name: 
// Module Name: Basys3
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


module Basys3(
    input Reset,
    input CLK,
    input BTNR,
    input [1:0] SW_in,
    output reg [3:0] AN,
    output [7:0] digital
    );
    //�����ļ��հ��ӣ�ֻ��Ҫ����ܵ���ʾ������ֻ��λѡ���������
    //��ΪReset���óɲ������أ�SW_inҲ���óɲ������أ����������������룬BTNR�����ǰ��İ�ť��CLK���Ӱ����Դ���ʱ��
    wire [31:0] Instr_Addr;//��ǰ��PCֵ
    wire [31:0] newPC;//��һ��PCֵ
    wire [4:0] rs;//RS�Ĵ������
    wire [4:0] rt;//RT�Ĵ������
    wire [31:0] Read_Data1;//RS�Ĵ��������ֵ
    wire [31:0] Read_Data2;//RT�Ĵ��������ֵ
    wire [31:0] result;//ALU������
    wire [31:0] Write_Data;//����д��register file�е�ֵ��Ҳ��������ͨ·������
    reg [3:0] display_data;//����LED��ֵ�������������һλҪ��ʾ�������Ƕ���
    reg [15:0] cnt;//�������������ڷ�Ƶ
    wire key_en;//��¼����֮�󣬲������ź�״̬�����Ǳ�ʾ������û�б�����
    parameter CLK_DIV = 10000;//��ʱ��Ƶ�ʷֳ�ԭ����1/CLK_DIV
    
   
    
    //ʵ����CPU~����������myCPU
    SingleCyleCPU myCPU(.Reset(Reset),.CLK(key_en),.Instr_Addr(Instr_Addr),.newPC(newPC),.rs(rs),.rt(rt),
    .Read_Data1(Read_Data1),.Read_Data2(Read_Data2),.result(result),.Write_Data(Write_Data));
    
    //ʵ������������
    key_vibration mykey_vibration(.CLK(CLK),.key(BTNR),.key_en(key_en));
    
    
    //Ϊcnt��λѡ�źŸ���ʼֵ
    initial begin
        cnt = 0;
        AN = 4'b0111;
    end
    
    //��һ������λѡ
    always@(negedge CLK) begin
        if(Reset==1) begin//������������ź�
            cnt <= cnt + 1;//��һ��CLK��һ����
            if(cnt==CLK_DIV) begin
                cnt <= 0; //��������CLK_DIV��ô���ʼ�յ�ʱ�򣬴���һ��λѡ�ĸı�
                case(AN)
                    4'b0111: AN <= 4'b1011;
                    4'b1011: AN <= 4'b1101;
                    4'b1101: AN <= 4'b1110;
                    4'b1110: AN <= 4'b0111;
                    default: AN <= 4'b1111;
                endcase
            end
        end
    end
    
    //�����������
    SegLED mySegLED(.display_data(display_data),.dispcode(digital));
    
    //��һ�����Ƿ���������Դ
    always@( key_en ) begin
        if(Reset==1) begin
            case(AN) 
                4'b0111:begin
                case(SW_in)
                    2'b00: display_data = Instr_Addr[7:4];
                    2'b01: display_data = {3'b000,rs[4]};
                    2'b10: display_data = {3'b000,rt[4]};
                    2'b11: display_data = result[7:4];
                endcase
                end
                4'b1011:begin
                case(SW_in)
                    2'b00: display_data = Instr_Addr[3:0];
                    2'b01: display_data = rs[3:0];
                    2'b10: display_data = rt[3:0];
                    2'b11: display_data = result[3:0];
                endcase
                end
                4'b1101:begin
                case(SW_in)
                    2'b00: display_data = newPC[7:4];
                    2'b01: display_data = Read_Data1[7:4];
                    2'b10: display_data = Read_Data2[7:4];
                    2'b11: display_data = result[7:4];
                endcase
                end
                4'b1110:begin
                case(SW_in)
                    2'b00: display_data = newPC[3:0];
                    2'b01: display_data = Read_Data1[3:0];
                    2'b10: display_data = Read_Data2[3:0];
                    2'b11: display_data = result[3:0];                                        
                endcase
                end
            endcase
            end
        end 
endmodule
