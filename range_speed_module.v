module range_speed_module(i_range, i_rst, i_clk, o_min_range, o_max_speed);

input [9:0] i_range;

input i_rst, i_clk;

output reg [9:0] o_min_range;

output reg [7:0] o_max_speed;

reg [32:0] diff_time;

reg [9:0] temp_range;




always @(posedge i_clk) begin



	if (i_rst) begin 
		diff_time<= 32'b0;
		
	end else begin
	
		diff_time<= diff_time+ 1'b1;
	
	end

end

always @(posedge i_clk) begin

	if (i_rst) begin
		o_min_range <= 10'hA;
		
	end else if (diff_time== 32'hFFFFFFFF) begin 
		
		if (i_range < o_min_range) begin
			o_min_range <= i_range;
			
		end 
	end
end

always @(posedge i_clk) begin

	if (i_rst) begin 
		o_max_speed <= 8'b0;
		temp_range <= i_range;
		
	end else begin
		
		if (temp_range > i_range) begin
			
			o_max_speed <= (temp_range - i_range);
		
			temp_range <= i_range;
		end
	
	end
end

endmodule
