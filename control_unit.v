`define score_en 2'b00
`define speed_en 2'b01
`define range_en 2'b10

module control_unit(i_start_stop, i_range_disp, i_speed_disp, i_rst, o_cnt_en, o_disp_en, o_rst);

input i_start_stop, i_rst, i_range_disp, i_speed_disp;

output reg o_cnt_en, o_rst;

output reg [1:0] o_disp_en;


always @* begin

	if (i_rst) begin 
		
		o_rst <= i_rst;
		o_cnt_en <= 1'b0;
		o_disp_en <= `score_en;
		
	end else begin
		if (i_start_stop) begin 
		
			o_cnt_en <= 1'b1;
			o_rst <= 1'b0;
			o_disp_en <= `score_en;
			
		end else if (i_range_disp) begin
			
			o_cnt_en <= 1'b1;
			o_rst <= 1'b0;
			o_disp_en <= `range_en;
			
		end else if (i_speed_disp) begin 
		
			o_cnt_en <= 1'b1;
			o_rst <= 1'b0;
			o_disp_en <= `speed_en;
			
		end else begin
			o_cnt_en <= 1'b0;
			o_rst <= 1'b0;
			o_disp_en <= `score_en;
		end
			
	end 
	
end

endmodule
			