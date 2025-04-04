module seg_one(
    input i_clk,
    input i_rst_n,
    input [3:0] i_data,
    output [6:0] o_seg
);

reg[6:0] r_seg;

always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        r_seg <= 7'b1111111;
    end
    else begin
        case(i_data)
            4'h0: r_seg <= 7'b1000000; // 0
            4'h1: r_seg <= 7'b1111001; // 1
            4'h2: r_seg <= 7'b0100100; // 2
            4'h3: r_seg <= 7'b0110000; // 3
            4'h4: r_seg <= 7'b0011001; // 4
            4'h5: r_seg <= 7'b0010010; // 5
            4'h6: r_seg <= 7'b0000010; // 6
            4'h7: r_seg <= 7'b1111000; // 7
            4'h8: r_seg <= 7'b0000000; // 8
            4'h9: r_seg <= 7'b0010000; // 9
            4'hf: r_seg <= 7'b1111111; // 不显示
            default: r_seg <= 7'b1111111;// 不显示

        endcase
    end
end

assign o_seg = r_seg;

endmodule       
