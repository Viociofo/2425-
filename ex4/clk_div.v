module clk_div(
    input i_clk,
    input i_rst_n,
    output reg o_clk
);

reg [32:0] cnt;
//parameter DIV_CNT = 32'd25_000;//每秒1000个周期，翻转2000次，每次翻转为50M/2000=25K
parameter DIV_CNT = 32'd25;

always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        cnt <= 32'd0;
        o_clk <= 1'b0;
    end else if((cnt + 'd1) == DIV_CNT) begin
        o_clk <= ~o_clk;
        cnt <= 32'd0;
    end else begin
        cnt <= cnt + 1'b1;
    end
end



endmodule       
