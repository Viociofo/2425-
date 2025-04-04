// module seg_out(
//     input i_clk,
//     input i_rst_n,
//     input i_carry,
//     input i_en,
//     output[3:0] o_hseg,
//     output[3:0] o_lseg,
//     output o_carry
// );

// //均显示两位，十位显示在o_hseg，个位显示在o_lseg,范围均为0~9
// //当输出1111时表示不显示


// parameter CNT_MAX = 8'd100;//分、秒为0~59，时，百分之一秒为0~99

// reg[3:0] r_hseg;
// reg[3:0] r_lseg;
// reg r_carry;

// reg[7:0] r_cnt;

// always @(posedge i_clk or negedge i_rst_n) begin
//     if (!i_rst_n) begin
//         r_cnt <= 0;
//     end
//     else if (r_cnt  >= CNT_MAX && i_carry) begin
//         r_cnt <= 0;
//     end
//     else if(i_en == 1'b1 && i_carry)begin
//         r_cnt <= r_cnt + 'd1;
//     end
//     else begin
//         r_cnt <= r_cnt;
//     end
// end

// always @(posedge i_clk or negedge i_rst_n) begin
//     if (!i_rst_n) begin
//         r_hseg <= 4'b1111;
//         r_lseg <= 4'b1111;
//         r_carry <= 0;
//     end
//     else if( i_carry)begin
//         r_hseg <= r_cnt  / 10;
//         r_lseg <= r_cnt  % 10;
//         r_carry <= r_cnt  >= CNT_MAX;
//     end
//     else begin
//         r_hseg <= r_hseg;
//         r_lseg <= r_lseg;
//         r_carry <= r_carry;
//     end
// end

// assign o_hseg = r_hseg;
// assign o_lseg = r_lseg;
// assign o_carry = r_carry;

// endmodule       
