`timescale 1ns/10ps

module tb_fsm_moore;

reg clk,rstn;
reg [1:0] i_input;
wire [0:0] o_output;

fsm_moore	u_fsm_moore (.clk(clk), .rstn(rstn), .i_input(i_input), .o_output(o_output) );

always #(50) begin clk <=~clk; end

initial begin
	rstn=0;
	clk=0;
	i_input=2'b00;
	#(500)
	rstn=1;
	#(250)
	i_input=2'b00;
	i_input=2'b01;
	#(200)
	i_input=2'b11;
	#(300)
	rstn=0;
end

endmodule
