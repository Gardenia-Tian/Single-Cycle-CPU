`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:34:29
// Design Name: 
// Module Name: SingleCyleCPU
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


module SingleCyleCPU(
    input Reset,
    input CLK,
    output [31:0] Instr_Addr,//当前的PC值
    output [31:0] newPC,//下一条指令地址
    output [4:0] rs,//Rs寄存器
    output [4:0] rt,//Rt寄存器
    output [31:0] Read_Data1,//rs寄存器的值
    output [31:0] Read_Data2,//rt寄存器的值
    output [31:0] result,//ALU的运算结果
    output [31:0] Write_Data//DataMem数据通路
    );
    
        wire [4:0] rd;
        wire zero;
        wire sign;
        wire RegWre;
        wire RegDst;
        wire [2:0] ALUop;
        wire [1:0] PCSrc;
        wire ALUSrcA;
        wire ALUSrcB;
        wire DBDataSrc;
        wire mRD;
        wire mWR;
        wire Extop;
        wire PCWre;
        wire InsMemRw;
        wire [31:0] Instruction;
        wire [5:0] op;
        wire [5:0] sa;
        wire [5:0] func;
        wire [27:2] j_Addr;
        wire [4:0] Write_reg;
        wire [31:0] Data_out;
        wire [31:0] A;  
        wire [31:0] B;
        wire [15:0] imm;
        wire [31:0] imm_out;
        //wire [31:0] Data_out;
        
        
        PC myPC(.newPC(newPC),.CLK(CLK),.Reset(Reset),.PCWre(PCWre),.Instr_Addr(Instr_Addr));
        Instruction_Memory myInstruction_Memory(.Read_Address(Instr_Addr),.InsMemRw(InsMemRw),.Instruction(Instruction));
        Instruction_divid myInstruction_divid(.Instruction(Instruction),.op(op),.rs(rs),.rt(rt),.rd(rd),.sa(sa),.func(func),.imm(imm),.j_Addr(j_Addr));
        SelectRegDst mySelectRegDst(.RegDst(RegDst),.Rd(rd),.Rt(rt),.DstReg(Write_reg));
        Register_Files myRegister_Files(.Read_reg1(rs),.Read_reg2(rt),.Write_reg(Write_reg),.RegWre(RegWre),.CLK(CLK),.Write_Data(Write_Data),.Read_Data1(Read_Data1),.Read_Data2(Read_Data2));
        ALUSourcrA_Select myALUSourcrA_Select(.sa(sa),.Read_Data(Read_Data1),.ALUSrcA(ALUSrcA),.result(A));
        DataSelect ALUSourceB_Select(.Data1(Read_Data2),.Data2(imm_out),.Select(ALUSrcB),.Dataout(B));
        ALU myALU(.A(A),.B(B),.ALUop(ALUop),.zero(zero),.sign(sign),.result(result));
        Data_Memory myData_Memory(.CLK(CLK),.Data_in(Read_Data2),.Addr(result),.mRD(mRD),.mWR(mWR),.Data_out(Data_out));
        DataSelect DBDataSrc_Select(.Data1(result),.Data2(Data_out),.Select(DBDataSrc),.Dataout(Write_Data));
        SignZeroExtend mySignZeroExtend(.imm_in(imm),.Extop(Extop),.imm_out(imm_out));
        upDatePC myupDatePC(.oldPC(Instr_Addr),.PCSrc(PCSrc),.imm(imm_out),.j_Addr(j_Addr),.newPC(newPC));
        Control_Unit myControl_Unit(.op(op),.func(func),.zero(zero),.sign(sign),.RegWre(RegWre),.RegDst(RegDst),.ALUop(ALUop),.PCSrc(PCSrc),.ALUSrcA(ALUSrcA),.ALUSrcB(ALUSrcB),.DBDataSrc(DBDataSrc),.mRD(mRD),.mWR(mWR),.ExtSel(Extop),.PCWre(PCWre),.InsMemRw(InsMemRw));    
        
    
endmodule
