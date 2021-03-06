module moore (
	input clk,
	input rstn,
	input i_input,
	output reg [1:0] o_output
);

reg [1:0] r_ns;
reg [1:0] r_cs;

parameter 	s_0 = 2'h0,
			s_1 = 2'h1,
			s_2 = 2'h2;

always @(posedge clk or negedge rstn) begin
	if(!rstn)	r_cs <= s_0;
	else		r_cs <= r_ns;
end

always @(*) begin
	if(!rstn)	begin r_ns = s_0; end
	else begin
			case(r_cs)
					s_0 :	if(i_input==2'h0)	begin r_ns = s_1; end
							else				begin r_ns = s_0; end
					s_1 :	if(i_input==2'h1)  	begin r_ns = s_2; end
							else				begin r_ns = s_1; end
					s_2 :	if(i_input==2'h1) 	begin r_ns = s_0; end
							else				begin r_ns = s_1; end
				default : 		r_ns = s_0;
			endcase
	end
end

assign o_output = (r_cs==s_2)? 1'b1 : 1'b0;

endmodule

