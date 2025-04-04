module seg_num(
    input i_clk,
    input i_rst_n,
    input i_en,
    output reg[7:0] o_xx,
    output reg[7:0] o_ss,
    output reg[7:0] o_mm,
    output reg[7:0] o_hh
);

parameter CNT_100 = 8'd100 - 'd1;
parameter CNT_60 = 8'd60 - 'd1;

reg[7:0] r_xcnt;
reg[7:0] r_scnt;
reg[7:0] r_mcnt;
reg[7:0] r_hcnt;

always @(posedge i_clk or negedge i_rst_n)begin

    if(!i_rst_n)begin
        r_xcnt <= 0;
    end
    else if(i_en)begin
        r_xcnt <= (r_xcnt >= CNT_100) ? r_xcnt <= 'd0 : r_xcnt + 'd1;
    end
    else begin
        r_xcnt <= r_xcnt;
    end

end

always @(posedge i_clk or negedge i_rst_n)begin

    if(!i_rst_n)begin
        r_scnt <= 0;
    end
    else if(i_en)begin
        r_scnt <= (r_scnt >= CNT_60 && r_xcnt == CNT_100) ? 
                    'd0 : ((r_xcnt == CNT_100) ? r_scnt + 'd1 : r_scnt);
    end
    else begin
        r_scnt <= r_scnt;
    end

end

always @(posedge i_clk or negedge i_rst_n)begin

    if(!i_rst_n)begin
        r_mcnt <= 0;
    end
    else if(i_en)begin
        r_mcnt <= (r_mcnt >= CNT_60 && r_xcnt == CNT_100 && r_scnt == CNT_60) ? 
                    'd0 : ((r_xcnt == CNT_100 && r_scnt == CNT_60) ? r_mcnt + 'd1 : r_mcnt);
    end
    else begin
        r_mcnt <= r_mcnt;
    end

end
always @(posedge i_clk or negedge i_rst_n)begin

    if(!i_rst_n)begin
        r_hcnt <= 0;
    end
    else if(i_en)begin
        r_hcnt <= (r_hcnt >= CNT_100 && r_mcnt == CNT_60 && r_xcnt == CNT_100 && r_scnt == CNT_60) 
                    ? 'd0 : ((r_mcnt == CNT_60 && r_xcnt == CNT_100 && r_scnt == CNT_60) ? 
                                r_hcnt + 'd1 : r_hcnt);
    end
    else begin
        r_hcnt <= r_hcnt;
    end

end


always @(posedge i_clk or negedge i_rst_n)begin
    if(!i_rst_n)begin
        o_xx <= 'd0;
        o_ss <= 'd0;
        o_mm <= 'd0;
        o_hh <= 'd0;
    end
    else begin
        o_xx[3:0] <= r_xcnt % 10;
        o_ss[3:0] <= r_scnt % 10;
        o_mm[3:0] <= r_mcnt % 10;
        o_hh[3:0] <= r_hcnt % 10;
        o_xx[7:4] <= r_xcnt / 10;
        o_ss[7:4] <= r_scnt / 10;
        o_mm[7:4] <= r_mcnt / 10;
        o_hh[7:4] <= r_hcnt / 10;
    end
end

endmodule
