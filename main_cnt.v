module main_cnt(i_score_clk, i_rst, i_en_cnt, o_score);

input i_score_clk, i_rst, i_en_cnt;

output reg [31:0] o_score;

always @(posedge i_score_clk) begin

	if (i_rst) begin 
	
		o_score <= 32'b0;
		
	end else if (i_en_cnt) begin 
	
		o_score <= o_score + 1'b0;
		
	end
	
end

endmodule
				