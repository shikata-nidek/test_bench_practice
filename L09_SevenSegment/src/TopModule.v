module TopModule(
	//////////// CLOCK //////////
	input 		          		CLK1,
	input 		          		CLK2,
	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,
	//////////// Push Button //////////
	input 		     [1:0]		BTN,
	//////////// LED //////////
	output		     [9:0]		LED,
	//////////// SW //////////
	input 		     [9:0]		SW

	);

	wire [7:0] dec_pat;
	
	m_seven_segment u0(SW[3:0],dec_pat);
	assign LED={6'h0,SW[3:0]};
	assign HEX0=dec_pat;
	assign HEX1=8'hff;
	assign HEX2=8'hff;
	assign HEX3=8'hff;
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
endmodule
