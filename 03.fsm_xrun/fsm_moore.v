module fsm_moore (
	input				clk,
	input				rstn,
	input [1:0]			i_input,
	output reg [0:0]	o_output
   );

reg [3:0]	r_ns=3'b000; //next state
reg [3:0]	r_cs=3'b000; //current state

parameter	init 	= 3'b000,
			a_0 	= 3'b001,
			a_1 	= 3'b010,
			ok_0 	= 3'b011,
			ok_1 	= 3'b100;

always @(posedge clk or negedge rstn) begin
	if(!rstn)	begin r_cs <= init; end
	else		begin r_cs <= r_ns; end
end

always @(*) begin
		if(!rstn) begin r_ns = init; end
		else begin
				case(r_cs)
						init :		if(i_input==2'b00 || i_input==2'b01)	begin r_ns = a_0; end
									else									begin r_ns = a_1; end
						a_0  :		if(i_input==2'b00 || i_input==2'b01)	begin r_ns = ok_0; end
									else									begin r_ns = a_1; end
						a_1  :		if(i_input==2'b00 || i_input==2'b01)	begin r_ns = a_0; end
									else									begin r_ns = ok_1; end
						ok_0 :		if(i_input==2'b00 || i_input==2'b01)	begin r_ns = ok_0; end
									else if(i_input==2'b11)					begin r_ns = ok_1; end
									else									begin r_ns = a_1; end
						ok_1 :		if(i_input==2'b00)						begin r_ns = a_0; end
									else if(i_input==2'b01)					begin r_ns = ok_0; end
									else 									begin r_ns = ok_1; end
						default : r_ns = init;
				endcase
		end
end

always @(*) begin
		case(r_cs)
				init : o_output = 1'b0;
				a_0	 : o_output = 1'b0;
				a_1	 : o_output = 1'b0;
				ok_0 : o_output = 1'b1;
				ok_1 : o_output = 1'b1;
				default : o_output = 1'b1;
		endcase
end



// synopsys translate_off

    reg     [15*8-1:0]  Curr_state; 

    always @(*) begin
        case(r_cs)
            init        :   Curr_state <= "Init";
            a_0      	:   Curr_state <= "A0";
            a_1  		:   Curr_state <= "A1";
            ok_0 		:   Curr_state <= "OK0";
            ok_1        :   Curr_state <= "OK1";
            default     :   Curr_state <= "DEFAULT";
        endcase
    end



    reg     [15*8-1:0]  Next_state; 

    always @(*) begin
        case(r_ns)
            init        :   Next_state <= "Init";
            a_0      	:   Next_state <= "A0";
            a_1  		:   Next_state <= "A1";
            ok_0 		:   Next_state <= "OK0";
            ok_1        :   Next_state <= "OK1";
            default     :   Next_state <= "DEFAULT";
        endcase
    end

// synopsys translate_on

endmodule
