/////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module tb_design();
	
////////////////////////////////////////////////////////////
//参数定义

`define CLK_PERIORD		10		//时钟周期设置为10ns（100MHz）	

////////////////////////////////////////////////////////////
//接口申明

reg [3:0] SW;
wire [7:0] LEDR;
wire [6:0] HEX0;

// 实例化顶层模块
Decoder uut (
    .A(SW[2:0]),      // 地址输入
    .G(SW[3]),            // 使能控制端（高电平有效）
    .seg(HEX0), // 七段码输出（a-g）
    .Y(LEDR)  // 低有效输出
);

// 测试序列生成
initial begin
    // 初始状态：使能关闭
    SW = 4'b0000;
    #10;
    
    // 使能有效，遍历所有输入组合
    SW[3] = 1; // G=1
    SW[2:0] = 3'b000; #10; // Y0 亮
    SW[2:0] = 3'b001; #10; // Y1 亮
    SW[2:0] = 3'b010; #10; // Y2 亮
    SW[2:0] = 3'b011; #10; // Y3 亮
    SW[2:0] = 3'b100; #10; // Y4 亮
    SW[2:0] = 3'b101; #10; // Y5 亮
    SW[2:0] = 3'b110; #10; // Y6 亮
    SW[2:0] = 3'b111; #10; // Y7 亮
    
    // 使能无效
    SW[3] = 0;
    #10;
    $stop;
end


endmodule






