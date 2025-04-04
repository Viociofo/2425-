/////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module tb_design();
	
////////////////////////////////////////////////////////////
//参数定义

`define CLK_PERIORD		20		//时钟周期设置为20ns（50MHz）
	

////////////////////////////////////////////////////////////
//接口申明

reg clk;
reg rst_n;
reg en;
wire[6:0] seg0;
wire[6:0] seg1;
wire[6:0] seg2;
wire[6:0] seg3;
wire[6:0] seg4;
wire[6:0] seg5;

// 实例化顶层模块
Clock uut (
    .i_clk(clk),
    .i_rst_n(rst_n),
    .i_en(en),
    .o_seg0(seg0),
    .o_seg1(seg1),
    .o_seg2(seg2),
    .o_seg3(seg3),
    .o_seg4(seg4),
    .o_seg5(seg5)

);


always #(`CLK_PERIORD/2) clk = ~clk;


// 测试序列生成
initial begin
    clk = 0;
    rst_n = 0;
    en = 1;
    #100;
    rst_n = 1;

    #11_000_000;
    en = 0;
    #1_00_000;
    en = 1;

    #50_000_000;
    $stop;
end


endmodule






