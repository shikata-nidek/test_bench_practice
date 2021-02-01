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

	wire button;	//チャタリング除去後のスイッチデータ
	wire [3:0] wq;	//10進カウンタの出力データ
	wire clk;		//KEY0は、押された時に0になるので、カウンタ用に論理を反転
	assign clk=~button;
	m_chattering u0(CLK1,BTN[0],button);
	m_dec_counter u1(clk,SW[9],wq);
	assign LED={6'h0,wq};
	assign HEX0=8'hff;
	assign HEX1=8'hff;
	assign HEX2=8'hff;
	assign HEX3=8'hff;
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
endmodule
