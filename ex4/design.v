module Clock(
    input i_clk,
    input i_rst_n,
    input i_en,
    output[6:0] o_seg0,
    output[6:0] o_seg1,
    output[6:0] o_seg2,
    output[6:0] o_seg3,
    output[6:0] o_seg4,
    output[6:0] o_seg5
    );

////////////////////////////////////////////////////////////////
//产生1khz和100hz的时钟

//localparam CLK_100HZ = 32'd250_000;    //每秒100个周期，翻转200次，每次翻转为50M/200=25K
localparam CLK_100HZ = 32'd50;          //仿真用
//localparam CLK_1kHZ = 32'd25_000;    //每秒1000个周期，翻转2000次，每次翻转为50M/2000=25K
localparam CLK_1kHZ = 32'd5;          //仿真用

wire w_clk_100;
wire w_clk_1k;

clk_div #(.DIV_CNT(CLK_100HZ))
    uut1(.i_clk(i_clk),.i_rst_n(i_rst_n),.o_clk(w_clk_100));

clk_div #(.DIV_CNT(CLK_1kHZ))
    uut2(.i_clk(i_clk),.i_rst_n(i_rst_n),.o_clk(w_clk_1k));


////////////////////////////////////////////////////////////////
//产生显示信号,分别为xx,ss,mm,hh

wire[7:0] w_xx;
wire[7:0] w_ss;
wire[7:0] w_mm;
wire[7:0] w_hh;

seg_num uut3 (.i_clk(w_clk_100),.i_rst_n(i_rst_n),.i_en(i_en),
            .o_xx(w_xx),.o_ss(w_ss),.o_mm(w_mm),.o_hh(w_hh));


////////////////////////////////////////////////////////////////
//显示

seg_show uut7(.i_clk(w_clk_1k),.i_rst_n(i_rst_n),
    .i_xx(w_xx),.i_ss(w_ss),.i_mm(w_mm),.i_hh(w_hh),
    .o_seg0(o_seg0),.o_seg1(o_seg1),.o_seg2(o_seg2),.o_seg3(o_seg3),.o_seg4(o_seg4),.o_seg5(o_seg5));



endmodule       
