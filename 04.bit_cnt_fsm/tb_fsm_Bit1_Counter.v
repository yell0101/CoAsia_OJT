`timescale 1ns/10ps

module tb_fsm_Bit1_Counter;

reg iclk, irstn, i_load;
reg 	[7:0] i_data;
wire 	[3:0] o_bit_cnt;
wire o_ready;

fsm_Bit1_Counter	U1 (.iclk(iclk), .irstn(irstn), .i_load(i_load), .i_data(i_data), .o_bit_cnt(o_bit_cnt), .o_ready(o_ready) );

initial begin iclk=0; end
always #(50) begin iclk <= ~iclk; end

always @(posedge iclk) begin
	if(o_ready)	begin i_load <= 1; end
	else		begin i_load <= 0; end
end

initial begin
	irstn = 0;
	i_load = 0;
	i_data = 8'b0000_0000;
	#(50) i_data = 8'b0101_1111;
	#(50) irstn = 1;
end

initial begin
	#(350) i_data = 8'b1110_1110;
	#(140) i_data = 8'b1111_0010;
	#(500) i_data = 8'b1100_1100;
end

parameter IDLE 	= 1'b0,
	  COUNT = 1'b1;

// synopsys translate_off

reg [15*8-1:0] C_STATE;
reg [15*8-1:0] N_STATE;

always @(*) begin
	case(tb_fsm_Bit1_Counter.U1.n_state)
		IDLE	: N_STATE <= "IDLE";
		COUNT	: N_STATE <= "COUNT";
		default : N_STATE <= "DEFAULT";
	endcase
end

always @(*) begin
	case(tb_fsm_Bit1_Counter.U1.c_state)
		IDLE	: C_STATE <= "IDLE";
		COUNT	: C_STATE <= "COUNT";
		default : C_STATE <= "DEFAULT";
	endcase
end
// synopsys translate_on
endmodule

