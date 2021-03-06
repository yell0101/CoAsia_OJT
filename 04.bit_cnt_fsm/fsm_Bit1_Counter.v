module fsm_Bit1_Counter (
	input				iclk,
	input				irstn,
	input				i_load,
	input		[7:0]	i_data,
	output reg	[3:0]	o_bit_cnt,
	output reg			o_ready 
);

reg [3:0] r_clk_cnt;
reg [7:0] r_data_shift; // input data 

reg n_state, c_state;

parameter	IDLE	= 1'b0,
			COUNT	= 1'b1;

//state machine
always @(*) begin
	if (!irstn)				begin n_state = IDLE; end
	else
		case(c_state)
			IDLE	: if(i_load)				begin n_state = COUNT; end
						else 					begin n_state = IDLE; end
			COUNT	: if(r_clk_cnt > 4'b1000)	begin n_state = IDLE; end
						else					begin n_state = COUNT; end
			default : 							begin n_state = IDLE; end
		endcase
end

always @(posedge iclk or negedge irstn) begin
	if(!irstn)	begin c_state <= IDLE; end
	else		begin c_state <= n_state; end
end 



//shift register
always @(posedge iclk or negedge irstn) begin
		if(!irstn)								begin r_data_shift <= 8'b0; end
		else if( (c_state== IDLE) && i_load)	begin r_data_shift <= i_data; end
		else if (r_clk_cnt < 4'b1000)			begin r_data_shift <= {1'b0, r_data_shift[7:1] }; end
		else									begin r_data_shift <= r_data_shift; end
end

//clk_cnt ++
always @(posedge iclk or negedge irstn) begin
	if(!irstn)	begin r_clk_cnt <= 4'b0; end
	else begin
		case(c_state)
				IDLE	: r_clk_cnt <= 4'b0;
				COUNT	: r_clk_cnt <= r_clk_cnt + 4'b0001;
				default	: r_clk_cnt <= r_clk_cnt;
		endcase
	end
end

//Check 1 and Bit Counter
always @(posedge iclk or negedge irstn) begin
	if(!irstn)	begin o_bit_cnt <= 4'b0; end
	else begin
			case(c_state)
					IDLE	: o_bit_cnt <= 0;
					COUNT	: if(r_data_shift[0] == 1'b1)					begin o_bit_cnt <= o_bit_cnt + 4'b0001; end
							 else if(r_clk_cnt > 4'b1000)					begin o_bit_cnt <= o_bit_cnt; end
							 else											begin o_bit_cnt <= o_bit_cnt; end
					default	: o_bit_cnt <= o_bit_cnt;
			endcase
	end
end

// o_ready generation
always @(posedge iclk or negedge irstn) begin
	if(!irstn)	begin o_ready <= 1'b0; end
		else begin
				case(n_state)
						IDLE	: o_ready <= 1'b1;
						COUNT	: o_ready <= 1'b0;
				endcase
		end
end

endmodule

