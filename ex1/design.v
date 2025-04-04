module ex1(a,b,c,d,s0,s1,y);
	input a,b,c,d,s0,s1;
	output reg y;

    always @(a or b or c or d or s0 or s1)
        begin
            case({s1,s0})
                2'b00: y = a;
                2'b01: y = b;
                2'b10: y = c;
                2'b11: y = d;
                default: y = a;
            endcase
        end
endmodule       