Bit1_Counter (
	input 					clk,
	input					rst,
	input 		[7:0]		d_in,
	output reg 	[2:0]		bit_cnt );

reg check_1=1'b0;
reg [3:0] clk_cnt;
reg [7:0] Data;

wire w_d_change;

parameter flag = 8'b0000_0001;

assign w_d_change = (Data!=d_in) ? 1 : 0; // Data change


always @(posedge clk or negedge rst) begin
	if(!rst)				begin check_1 <= 0; end
	else if (w_d_change)	begin check_1 <= 0; end
	else begin
		case(clk_cnt)
			4'd0 : begin check_1 <= flag & d_in[7:0]; end
			4'd1 : begin check_1 <= flag & {1'b0,d_in[7:1]}; end
			4'd2 : begin check_1 <= flag & {2'b0,d_in[7:2]}; end
			4'd3 : begin check_1 <= flag & {3'b0,d_in[7:3]}; end
			4'd4 : begin check_1 <= flag & {4'b0,d_in[7:4]}; end
			4'd5 : begin check_1 <= flag & {5'b0,d_in[7:5]}; end
			4'd6 : begin check_1 <= flag & {6'b0,d_in[7:6]}; end
			4'd7 : begin check_1 <= flag & {7'b0,d_in[7]}; end
			default : begin check_1 <= 0; end
		endcase
	end
end


always @(posedge clk or negedge rst) begin
	if(!rst)	begin Data <= 8'b0; end
	else		begin Data <= d_in; end
end

/*
 always @(posedge clk or negedge rst) begin
	if(!rst)			 begin clk_cnt <= 0; end
 	else if (w_d_change) begin clk_cnt <= 0; end
 	else if(clk_cnt < 8) begin clk_cnt <= clk_cnt + 1; end
 	else 				 begin clk_cnt <= clk_cnt; end
 end
*/

always @(posedge clk or negedge rst) begin
	if(!rst) begin  clk_cnt <= 0; end
	else begin 
			if (w_d_change) begin clk_cnt <= 0; end
			else begin 
				if(clk_cnt < 8 ) begin clk_cnt <= clk_cnt + 1; end
				else			begin clk_cnt <= clk_cnt; end
			end
	end
end

/*
always @(posedge clk or negedge rst) begin
 	if(!rst)					begin bit_cnt <= 0; end
 	else if (w_d_change)		begin bit_cnt <= 0; end	
 	else if	(check_1)			begin bit_cnt <= bit_cnt + 1; end
 	else						begin bit_cnt <= bit_cnt; end 	
end
*/ 


always @(posedge clk or negedge rst) begin
	if(!rst)					begin bit_cnt <= 3'b0; end
	else begin
			if (w_d_change)		begin bit_cnt <= 0; end	
			else begin
					if	(check_1)	begin bit_cnt <= bit_cnt + 1; end
   					else 			begin bit_cnt <= bit_cnt; end 	
			end
	end
end

endmodule