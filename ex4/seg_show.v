module seg_show(
    input i_clk,
    input i_rst_n,
    input[7:0] i_xx,
    input[7:0] i_ss,
    input[7:0] i_mm,
    input[7:0] i_hh,
    output reg [6:0] o_seg0,
    output reg [6:0] o_seg1,
    output reg [6:0] o_seg2,
    output reg [6:0] o_seg3,
    output reg [6:0] o_seg4,
    output reg [6:0] o_seg5

);

wire[13:0] r_xseg;
wire[13:0] r_sseg;
wire[13:0] r_mseg;
wire[13:0] r_hseg;

seg_one uut_xseg1(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_data(i_xx[3:0]),.o_seg(r_xseg[6:0]));
seg_one uut_sseg1(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_data(i_ss[3:0]),.o_seg(r_sseg[6:0]));
seg_one uut_mseg1(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_data(i_mm[3:0]),.o_seg(r_mseg[6:0]));
seg_one uut_hseg1(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_data(i_hh[3:0]),.o_seg(r_hseg[6:0]));

seg_one uut_xseg2(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_data(i_xx[7:4]),.o_seg(r_xseg[13:7]));
seg_one uut_sseg2(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_data(i_ss[7:4]),.o_seg(r_sseg[13:7]));
seg_one uut_mseg2(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_data(i_mm[7:4]),.o_seg(r_mseg[13:7]));
seg_one uut_hseg2(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_data(i_hh[7:4]),.o_seg(r_hseg[13:7]));


always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        o_seg0 <= 7'b111_1111;
        o_seg1 <= 7'b111_1111;
        o_seg2 <= 7'b111_1111;
        o_seg3 <= 7'b111_1111;
        o_seg4 <= 7'b111_1111;
        o_seg5 <= 7'b111_1111;
    end
    else if(i_hh > 8'b00000000 && (!(i_hh == 8'hff)))begin
        o_seg0 <= r_sseg[6:0];
        o_seg1 <= r_sseg[13:7];
        o_seg2 <= r_mseg[6:0];
        o_seg3 <= r_mseg[13:7];
        o_seg4 <= r_hseg[6:0];
        o_seg5 <= r_hseg[13:7];
    end
    else begin
        o_seg0 <= r_xseg[6:0];
        o_seg1 <= r_xseg[13:7];
        o_seg2 <= r_sseg[6:0];
        o_seg3 <= r_sseg[13:7];
        o_seg4 <= r_mseg[6:0];
        o_seg5 <= r_mseg[13:7];
    end
end


endmodule       
