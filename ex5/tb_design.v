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
wire[6:0] seg0;
wire[6:0] seg1;
wire[2:0] led_ns;
wire[2:0] led_ew;

// 实例化顶层模块
traffic #(  .CLK_1K(32'd25 - 'd1),
            .CLK_2(32'd12_500 - 'd1)) 
    uut (
    .i_clk(clk),
    .i_rst_n(rst_n),
    .o_seg0(seg0),
    .o_seg1(seg1),
    .o_ledns(led_ns),
    .o_ledew(led_ew)
);

always #(`CLK_PERIORD/2) clk = ~clk;

// 测试序列生成
initial begin
    // 初始状态：使能关闭
    clk = 0;
    rst_n =0;
    #100;
    rst_n = 1;
    
    #60_000_000;
    $stop;
end


endmodule






