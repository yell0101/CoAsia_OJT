`timescale 1ns/10ps

module tb_bit_cnt;

reg clk, rst;
reg [7:0] d_in;

wire [2:0] bit_cnt;

integer i;


Bit1_Counter u_Bit1_Counter (.clk(clk), .rst(rst), .d_in(d_in), .bit_cnt(bit_cnt) );

initial begin clk=0; end
always #(50) begin clk <= ~clk; end

initial begin
	rst=0;
	#(200)
	rst=1;
	input_data(8'b1011_1001);
	input_data(8'b0000_0001);
	input_data(8'b0010_0011);
	input_data(8'b1011_1001);
	rst=0;
	#(1000)
	rst=1;

	begin
	for ( i=0 ; i<256 ; i=i+1 )
		#(1000)
		d_in = i;
	end
end

task input_data;
	input [7:0] D_in;

	begin
		#(400)
		d_in = D_in;
		#(1200)
		
		d_in = ~D_in;
		#(1200)		
		
		d_in = D_in;
	end
endtask

endmodule
