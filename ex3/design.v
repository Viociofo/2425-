module  Answer(
    input i_clk,
    input i_rst_n,
    input i_ask,
    input[2:0] i_ans,
    output reg[6:0]  o_seg,
    output reg o_buz
);

///////////////////////////
//5s计时,时钟频率为50MHz
//如果r_5en为1，则r_5cnt开始计时，当按下复位或者计时器满则使能和计数器都清零
reg[31:0] r_5cnt;
reg r_5en;
reg r_buz;
localparam DELAY_5S = 32'd500;
localparam DELAY_1S = 32'd100;

///////////////////////////
//5s计时开始
//i_ask为按钮，按下后记录其上升沿，并将r_5en置1，开始计时
reg[1:0] r_ask;
wire w_pos_en;
reg r_start;
always @(posedge i_clk)
	r_ask <= {r_ask[0],i_ask};

assign w_pos_en = ~r_ask[1] & r_ask[0]; //上升沿

always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        r_5cnt <= 32'd0;
        r_5en  <= 1'b0;
        r_start <= 1'b0;
    end
    else begin
        
        if (r_5cnt == DELAY_5S || (i_ans < 3'b111)) begin          // 完成5s计时
            r_5cnt <= 32'd0;
            r_5en  <= 1'b0;
        end
        else if (w_pos_en) begin               // 检测到按钮上升沿
            r_5en  <= 1'b1;                   // 启动计时
            r_5cnt <= 32'd0;                  // 清零计数器
            r_start <= 1'b1;
        end
        else if (r_5en) begin                 // 正在计时
            r_5cnt <= r_5cnt + 1'b1;
        end
        else begin                            // 空闲状态
            r_5cnt <= 32'd0;
        end
    end
end

///////////////////////////
//检测是否有人按下按钮
reg[2:0] r_ansnum;

always @(posedge i_clk or negedge i_rst_n)
    begin
        if(!i_rst_n) begin
            r_ansnum <= 3'd0;
            r_buz <= 1'b0;
        end
        else if(i_ans < 3'b111) begin
            if(r_start == 1'b1) begin
                r_ansnum <= ~i_ans;
            end
        
            else begin
                r_buz <= 1'b1;
            end
        end
    end

///////////////////////////
// 共阴数码管编码

reg[4:0] r_sec;//显示当前秒数
reg[4:0] r_seg;//数码管显示数

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_sec <= 5'b00000;  // 初始化为1秒
        r_seg <= 5'd0;
    end
    else if(r_5en == 1'b1) begin
            if((r_5cnt + 1 + DELAY_1S) % DELAY_1S == 0)begin
                if(r_sec == 5'd0)begin
                    r_sec <= 5'b10000;
                end
                else r_sec <= r_sec >> 1;
            end
            else r_sec <= r_sec;

            r_seg <= r_sec;
        end
        else if(r_ansnum > 3'd0)begin
            r_seg <= {1'b0,r_ansnum};
        end
end

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        o_seg <= 7'b111_1111;
    end
    
    else begin
        case (r_seg)
            5'b00001: o_seg <= 7'b1111001; // 1
            5'b00010: o_seg <= 7'b0100100; // 2
            5'b00100: o_seg <= 7'b0110000; // 3
            5'b01000: o_seg <= 7'b0011001; // 4
            5'b10000: o_seg <= 7'b0010010; // 5
            default:  o_seg <= 7'b1111111; // 默认全关
        endcase
    end
end

///////////////////////////
// 蜂鸣器

reg [14:0] r_buzcnt; // 15位计数器（0~24999）
reg square_wave;

always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin // 复位时初始化
        r_buzcnt     <= 15'd0;
        square_wave <= 1'b0;
    end else begin
        if (r_buzcnt == 15'd2) begin // 达到半周期时翻转
            r_buzcnt     <= 15'd0;
            square_wave <= ~square_wave;
        end else begin
            r_buzcnt <= r_buzcnt + 1'b1;
        end
    end
end

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        o_buz <= 1'b0;
    end
    else if(r_buz == 1'b1) begin
        o_buz <= square_wave;
    end
    else o_buz <= 1'b0;
end


endmodule       
