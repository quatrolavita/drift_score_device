module scoring_device(MAX10_CLK1_50, SW, KEY,
							 HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

input MAX10_CLK1_50;
input KEY;
input [12:0] SW;

output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;


wire sys_clk = MAX10_CLK1_50;
wire cnt_en, rst, score;
wire [1:0] choice_disp;
wire [9:0] range = SW[9:0];
wire [9:0] min_range;
wire [7:0] max_speed;
wire [31:0] final_score;

control_unit control_unit(.i_start_stop (SW[12]), 
								  .i_range_disp (SW[11]), 
								  .i_speed_disp (SW[10]), 
								  .i_rst (KEY), 
								  .o_cnt_en (cnt_en), 
								  .o_disp_en (choice_disp), 
								  .o_rst (rst)
);


score_module score_module(.i_range (range), 
								  .i_reset (rst), 
								  .i_clk (sys_clk), 
								  .o_score (score)

);


range_speed_module range_speed_module(.i_range (range),
												  .i_rst (rst), 
												  .i_clk (sys_clk), 
												  .o_min_range (min_range), 
												  .o_max_speed (max_speed)
);


main_cnt main_cnt(.i_score_clk (score),
						.i_rst (rst), 
					   .i_en_cnt (cnt_en), 
					   .o_score (final_score)

);

mux_disp mux_disp(.i_range(min_range), 
						.i_speed(max_speed), 
						.i_cnt(final_score), 
						.i_clk(sys_clk), 
						.i_choice_disp(choice_disp), 
						.HEX0(HEX0), 
						.HEX1(HEX1), 
						.HEX2(HEX2), 
						.HEX3(HEX3), 
						.HEX4(HEX4), 
						.HEX5(HEX5), 
						.HEX6(HEX6), 
						.HEX7(HEX7)
);


endmodule

