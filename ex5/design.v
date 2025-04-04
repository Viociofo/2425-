module traffic (
    input i_clk,
    input i_rst_n,
    output [6:0] o_seg0,
    output [6:0] o_seg1,
    output [2:0] o_ledns,
    output [2:0] o_ledew

);
//////////////////////////////////////////////////////
//生成1khz、2hz的时钟
parameter CLK_1K = 32'd25_000 - 'd1;
parameter CLK_2 = 32'd12_500_000 - 'd1;

wire w_clk_1k;
wire w_clk_2;

clk_div #(.DIV_CNT(CLK_1K))
    uut1(.i_clk(i_clk),.i_rst_n(i_rst_n),.o_clk(w_clk_1k));

clk_div #(.DIV_CNT(CLK_2))
    uut2(.i_clk(i_clk),.i_rst_n(i_rst_n),.o_clk(w_clk_2));

///////////////////////////////////////////////////////
//

localparam CNT_DOWN = 5'd19;
localparam CNT_1S = 32'd1000 - 'd1;

reg r_flag;//控制南北/东西灯是否亮 0南北黄绿东西红
reg[4:0] r_cntdn;
reg[31:0] r_cnt;

always @(posedge w_clk_1k or negedge i_rst_n)begin
    if(!i_rst_n)begin
        r_cnt <= 'd0;
        r_cntdn <= CNT_DOWN;
        r_flag <= 0;
    end    
    else if(r_cnt == CNT_1S)begin
        r_cnt <= 'd0;
        if(r_cntdn == 'd0)begin
            r_cntdn <= CNT_DOWN;
            r_flag <= ~r_flag;
        end
        else begin
            r_cntdn <= r_cntdn - 'd1;
        end
    end
    else begin
        r_cnt <= r_cnt + 'd1;
    end
end

///////////////////////////////////////////////////////
//
localparam CNT_YELLOW = 5'd3 - 5'd1;

reg[2:0] r_leden;//控制什么灯亮

always @(posedge w_clk_1k or negedge i_rst_n)begin
    if(!i_rst_n)begin
        r_leden <= 'd0;
    end
    else if(r_cntdn <= CNT_YELLOW)begin
        r_leden <= 3'b110;//红黄灯亮
    end
    else begin
        r_leden <= 3'b101;//红绿灯亮
    end
end

//r_flag = 0 时南北黄绿灯可亮 r_flag = 1时红灯亮
assign o_ledns = {  (r_flag)&&r_leden[2],
                    (!r_flag)&&r_leden[1]&&w_clk_2,
                    (!r_flag)&&r_leden[0]   };

//r_flag = 1 时东西黄绿灯可亮 r_flag = 0时红灯亮
assign o_ledew = {  (!r_flag)&&r_leden[2],
                    (r_flag)&&r_leden[1]&&w_clk_2,
                    (r_flag)&&r_leden[0]   };

///////////////////////////////////////////////////////
//
wire[7:0] r_seg;
assign r_seg[7:4] = r_cntdn / 10;
assign r_seg[3:0] = r_cntdn % 10;

seg_one uut3(.i_clk(w_clk_1k),.i_rst_n(i_rst_n),.i_data(r_seg[7:4]),.o_seg(o_seg1));
seg_one uut4(.i_clk(w_clk_1k),.i_rst_n(i_rst_n),.i_data(r_seg[3:0]),.o_seg(o_seg0));

endmodule       
