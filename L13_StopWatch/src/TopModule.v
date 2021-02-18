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
	wire clk10m,button,start_sw,run_led;
	wire [7:0] w_min;
	wire [7:0] w_sec;
	wire [7:0] w_msec;
	assign start_sw=~button;
	
	m_chattering u0(CLK1,BTN[0],button);
	m_10ms_clk u1(CLK1,clk10ms);
	m_stop_watch u2(clk10ms,start_sw,BTN[1],w_min,w_sec,w_msec,run_led);
	
	assign LED={9'h0,run_led};
	m_seven_segment #(1) h0(w_msec[3:0],HEX0);
	m_seven_segment #(1) h1(w_msec[7:4],HEX1);
	m_seven_segment #(0) h2(w_sec[3:0],HEX2);
	m_seven_segment #(1) h3(w_sec[7:4],HEX3);
	m_seven_segment #(0) h4(w_min[3:0],HEX4);
	m_seven_segment #(1) h5(w_min[7:4],HEX5);
	
endmodule
