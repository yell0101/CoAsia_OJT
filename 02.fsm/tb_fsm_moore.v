`timescale 1ns/10ps

module tb_fsm_moore;

reg clk,rstn;
reg [1:0] i_input;

wire [0:0] o_output;

fsm_moore	u_fsm_moore (.clk(clk), .rstn(rstn), .i_input(i_input), .o_output(o_output) );

parameter period=100;

initial begin clk=0; end
always #(period/2) begin clk <=~clk; end

initial begin
						rstn = 0;
	#(period/2-2)
	
	//Red Path
	state_change_3times(2'b00,2'b00,2'b00);
	state_change_3times(2'b01,2'b01,2'b01);
	state_change_3times(2'b11,2'b11,2'b11);
	state_change_3times(2'b10,2'b10,2'b11);
	state_change_5times(2'b00,2'b11,2'b00,2'b10,2'b01);
	state_change_8times(2'b00,2'b00,2'b11,2'b00,2'b00,2'b11,2'b01,2'b10);
	
	#(200) $finish;


end

task state_change_3times;
		input [1:0] in_1, in_2, in_3;

		begin
			#(period)
			#(2+period/2) 		rstn = 1;
								i_input = in_1;
			#(period/2)			i_input = in_1;
			#(period)			i_input = in_2;
			#(period)			i_input = in_3;
			#(period-2)			rstn = 0;
		end
endtask


task state_change_5times;
		input [1:0] in_1, in_2, in_3, in_4, in_5;

		begin
			#(period)
			#(2+period/2) 		rstn = 1;
								i_input = in_1;
			#(period/2)			i_input = in_1;
			#(period)			i_input = in_2;
			#(period)			i_input = in_3;
			#(period)			i_input = in_4;
			#(period)			i_input = in_5;
			#(period-2)			rstn = 0;
		end
endtask

task state_change_8times;
		input [1:0] in_1, in_2, in_3, in_4, in_5,
					in_6, in_7, in_8;

		begin
			#(period)
			#(2+period/2) 		rstn = 1;
								i_input = in_1;
			#(period/2)			i_input = in_1;
			#(period)			i_input = in_2;
			#(period)			i_input = in_3;
			#(period)			i_input = in_4;
			#(period)			i_input = in_5;
			#(period)			i_input = in_6;
			#(period)			i_input = in_7;
			#(period)			i_input = in_8;
			#(period-2)			rstn = 0;
		end
endtask

/*

integer i;
initial begin
	rstn=0;
	clk=0;
	i_input=2'b00;
	#(430)

/*
	for (i=0 ; i<4 < i++) begin 					
		case (i_input) 								
				2'00 : i_input = 2'b00; // A0 1st branch
						for (i=0 ; i<4 ; i++) begin
								case (i) // current stage = A0
									0 : i_input = 2'b00; // current stage = OK0
										for(i=0 ; i<4 ; i++) begin
											case (i) // current stage = OK0
												0 : i_input = 2'b00; // (1) OK0
												1 : i_input = 2'b01; // (2) OK0
												2 : i_input = 2'b10; // current stage = OK1
													for(i=0 ; i<4 ; i++) begin
															case(i) // curret stage = OK1
																0 : i_input = 2'b00 //(3) A0
																1 :
																2 :
																3 :
															endcase
															i_input = 2
													end
													
												3 : i_input = 2'b11;
											endcase 
										end
									1 : i_input = 2'b01; // (2) OK0
									2 : i_input = 2'b10; //3rd OK1
											for (i=0 ; i<4 ; i++ ) begin
												case (i) 
													0 : i_input = 2'b00 
													1 :
													2 :
													3 :
												endcase
										end	
									3 : i_input = 2'b10;

								endcase			
						end

	end

	//near init Path
	reset_data;
	i_input=2'b00; // curr_state=A0
	#(100)
	
	reset_data;
	i_input=2'b01; // curr_state=A1
	#(90)
	
	reset_data;
	i_input=2'b10; //curr_state=OK1
	#(80)
	
	reset_data;
	i_input=2'b11;
	#(70)
	reset_data;

end

task reset_data;
	begin
		rstn=0; #(10) 
		rstn=1;
	end
endtask
*/	

endmodule
