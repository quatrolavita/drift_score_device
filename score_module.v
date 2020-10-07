module score_module(i_range, i_reset, i_clk, o_score);

input [9:0] i_range;
input i_clk, i_reset;

output reg o_score;

reg [9:0] out_cnt;


always @(posedge i_clk) begin 

	if (i_reset) begin 
		out_cnt <= 10'b0;
		
	end else begin 

	out_cnt <= out_cnt + 1;
	
	end
		
end

always @(posedge i_clk) begin

	if (out_cnt == i_range) begin
		
		o_score = 1'b1;
	end else begin
	
		o_score = 1'b0;
		
	end
	
end

endmodule
