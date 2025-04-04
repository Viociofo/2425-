`timescale 1ns / 1ps

module tb_design();

    // 输入信号
    reg i_clk;
    reg i_rst_n;
    reg i_ask;
    reg [2:0] i_ans;
    
    // 输出信号
    wire [6:0] o_seg;
    wire o_buz;
    
    // 实例化被测模块
    Answer uut (
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_ask(i_ask),
        .i_ans(i_ans),
        .o_seg(o_seg),
        .o_buz(o_buz)
    );
    
    // 生成50MHz时钟
    initial begin
        i_clk = 0;
        forever #10 i_clk = ~i_clk;  // 20ns周期 -> 50MHz
    end
    
    // 测试流程
    initial begin
        // 初始化信号
        i_rst_n = 0;
        i_ask = 0;
        i_ans = 3'b111;
        #20;
        
        // 释放复位
        i_rst_n = 1;
        #100;
        
        #200;
        
        i_ans = 3'b110;
        #1000;
        #40
        $stop;
    end
    
endmodule