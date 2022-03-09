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
	#(100) 				rstn = 1;
		 				i_input = 2'b00;
	#(50+3*period-2)	rstn = 0;
	
	#(4+48)				i_input = 2'b01;
						rstn = 1;
	#(50+3*period-2)	rstn = 0;
	
	#(4+48)				i_input = 2'b11;
						rstn = 1;
	#(50+3*period-2)	rstn = 0; 
	
	//Green Path	
	#(4+48)				i_input = 2'b10;
						rstn = 1;
	#(2*period)			i_input = 2'b11;
	#(50+1*period-2)	rstn = 0;

	//Purple Path
	#(4+48)				i_input = 2'b00;
						rstn = 1;
	#(period)			i_input = 2'b11;
	#(period)			i_input = 2'b00;
	#(period)			i_input = 2'b10;
	#(period)			i_input = 2'b01;	
	#(50+1*period-2)	rstn = 0;

	//Gray Path
	#(4+48)				i_input = 2'b00;
						rstn = 1;
	#(period)			i_input = 2'b00;
	#(period)			i_input = 2'b11;
	#(period)			i_input = 2'b00;
	#(period)			i_input = 2'b00;	
	#(period)			i_input = 2'b11;	
	#(period)			i_input = 2'b01;	
	#(period)			i_input = 2'b10;	
	#(50+1*period-2)	rstn = 0;
	
	#(200) $finish;


end



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
