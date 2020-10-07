`define score_en 2'b00
`define speed_en 2'b01
`define range_en 2'b10


module mux_disp(i_range, i_speed, i_cnt, i_clk, i_choice_disp, 
					 HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);

input [9:0] i_range;
input [7:0] i_speed;
input [31:0] i_cnt;
input i_clk;
input [1:0] i_choice_disp;

output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
reg [3:0] bcd_hex0, bcd_hex1, bcd_hex2, bcd_hex3, bcd_hex4, bcd_hex5, bcd_hex6, bcd_hex7;

wire [15:0] bcd_range; 
wire [11:0] bcd_speed; 
wire [39: 0] bcd_cnt;

binary_to_BCD #(.INPUT_WIDTH(10), .DECIMAL_DIGITS(4)) range_bcd(.i_Clock (i_clk),
																					 .i_Binary (i_range),
																					 .i_Start (1'b1),
																					 .o_BCD (bcd_range),
																					 .o_DV (1'b1)

);

binary_to_BCD #(.INPUT_WIDTH(8), .DECIMAL_DIGITS(3)) speed_bcd(.i_Clock (i_clk),
																					 .i_Binary (i_speed),
																					 .i_Start (1'b1),
																					 .o_BCD (bcd_speed),
																					 .o_DV (1'b1)

);

binary_to_BCD #(.INPUT_WIDTH(32), .DECIMAL_DIGITS(10)) cnt_bcd(.i_Clock (i_clk),
																					 .i_Binary (i_cnt),
																					 .i_Start (1'b1),
																					 .o_BCD (bcd_cnt),
																					 .o_DV (1'b1)

);


BCD_to_HEX seg7_0(.i_dat (bcd_hex0), 
					 .o_seg (HEX0));

BCD_to_HEX seg7_1(.i_dat (bcd_hex1), 
					 .o_seg (HEX1));

BCD_to_HEX seg7_2(.i_dat (bcd_hex2), 
					 .o_seg (HEX2));

BCD_to_HEX seg7_3(.i_dat (bcd_hex3), 
					 .o_seg (HEX3));					 

BCD_to_HEX seg7_4(.i_dat (bcd_hex4), 
					 .o_seg (HEX4));
					 
BCD_to_HEX seg7_5(.i_dat (bcd_hex5), 
					 .o_seg (HEX5));
					 
BCD_to_HEX seg7_6(.i_dat (bcd_hex6), 
					 .o_seg (HEX6));

BCD_to_HEX seg7_7(.i_dat (bcd_hex7), 
					 .o_seg (HEX7));					 
					 
always @* begin 

	casez(i_choice_disp)
	
		`score_en: begin
		
			bcd_hex0 <= bcd_cnt[11:8];
			bcd_hex1 <= bcd_cnt[15:12];
			bcd_hex2 <= bcd_cnt[19:16];
			bcd_hex3 <= bcd_cnt[23:20];
			bcd_hex4 <= bcd_cnt[27:24];
			bcd_hex5 <= bcd_cnt[31:28];
			bcd_hex6 <= bcd_cnt[34:32];
			bcd_hex7 <= bcd_cnt[39:36];
		
		end 
		
		
		`speed_en: begin 
		
			bcd_hex0 <= bcd_speed[3:0];
			bcd_hex1 <= bcd_speed[7:4];
			bcd_hex2 <= bcd_speed[11:8];
			bcd_hex3 <= 4'b0;
			bcd_hex4 <= 4'b0;
			bcd_hex5 <= 4'b0;
			bcd_hex6 <= 4'b0;
			bcd_hex7 <= 4'b0;
			
		end
		
		
		`range_en: begin
		
			bcd_hex0 <= bcd_range[3:0];
			bcd_hex1 <= bcd_range[7:4];
			bcd_hex2 <= bcd_range[11:8];
			bcd_hex3 <= bcd_range[15:12];
			bcd_hex4 <= 4'b0;
			bcd_hex5 <= 4'b0;
			bcd_hex6 <= 4'b0;
			bcd_hex7 <= 4'b0;
		
		end 
		
		default : begin
			bcd_hex0 <= bcd_cnt[11:8];
			bcd_hex1 <= bcd_cnt[15:12];
			bcd_hex2 <= bcd_cnt[19:16];
			bcd_hex3 <= bcd_cnt[23:20];
			bcd_hex4 <= bcd_cnt[27:24];
			bcd_hex5 <= bcd_cnt[31:28];
			bcd_hex6 <= bcd_cnt[34:32];
			bcd_hex7 <= bcd_cnt[39:36];
		 end
		 
	endcase
	
	end
	
endmodule
		
			