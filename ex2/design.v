module Decoder (
    input [2:0] A,      // 地址输入
    input G,            // 使能控制端（高电平有效）
    output reg [6:0] seg, // 七段码输出（a-g）
    output reg [7:0] Y  // 低有效输出
);

// 组合逻辑实现真值表
always @(*) begin
    if (G) begin
        case (A)
            3'b000: Y = 8'b11111110;
            3'b001: Y = 8'b11111101;
            3'b010: Y = 8'b11111011;
            3'b011: Y = 8'b11110111;
            3'b100: Y = 8'b11101111;
            3'b101: Y = 8'b11011111;
            3'b110: Y = 8'b10111111;
            3'b111: Y = 8'b01111111;
            default: Y = 8'b11111111;
        endcase
    end 
    else begin
        Y = 8'b11111111; // 使能无效时输出全高
    end
end


// 共阴数码管编码（需根据硬件调整段序）
always @(*) begin
    if (G) begin
        case (A)
            3'd0: seg = 7'b1000000; // 0
            3'd1: seg = 7'b1111001; // 1
            3'd2: seg = 7'b0100100; // 2
            3'd3: seg = 7'b0110000; // 3
            3'd4: seg = 7'b0011001; // 4
            3'd5: seg = 7'b0010010; // 5
            3'd6: seg = 7'b0000010; // 6
            3'd7: seg = 7'b1111000; // 7

            default: seg = 7'b1111111;
        endcase
    end
    else begin
        seg = 7'b1111111; // 使能无效时输出全高
    end        
end

endmodule       
