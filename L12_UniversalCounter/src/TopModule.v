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
	wire clk,w_sw;
	wire c1,c2;			//キャリー信号
	wire [3:0] cnt0;	//8進カウンタ用
	wire [3:0] cnt1;	//10進カウンタ用
	wire [7:0] led0;	//7セグメントLED0用デコードデータ
	wire [7:0] led1;	//7セグメントLED1用デコードデータ
	assign clk=~w_sw;
	
	m_chattering chattering(CLK1,BTN[0],w_sw);	//KEY0のチャタリングを除去
	m_universal_counter #(7) counter8(clk,BTN[1],1'b1,c1,cnt0);	//8進カウンタ
	m_universal_counter #(9) counter10(clk,BTN[1],c1,c2,cnt1);	//10進カウンタ
	m_seven_segment seg_LED0(cnt0,led0);
	m_seven_segment seg_LED1(cnt1,led1);
	
	assign LED=10'h0;
	assign HEX0=led0;
	assign HEX1=led1;
	assign HEX2=8'hff;
	assign HEX3=8'hff;
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
endmodule
