//1/100秒のクロック生成
module m_10ms_clk(input clk,input rst,output clk10ms);
	reg [19:0] cnt;
	reg r10ms;
	wire wcout;
	
	assign wcout=(cnt==20'd249999) ? 1'b1 : 1'b0;
	assign clk10ms=r10ms;
	always @(posedge clk or negedge rst) begin
		if(rst==1'b0) begin
			cnt = 0;
			r10ms = 1'b0;
		end else if(wcout==1'b1) begin
			cnt=0;
			r10ms=~r10ms;
		end
		else begin
			cnt=cnt+1;
		end
	end
		
endmodule	


//ストップウォッチモジュール
module m_stop_watch(
	input clk,				//1/100秒のクロック
	input start_sw,		//スタート／ストップスイッチ(正論理）
	input n_reset,			//リセット（負論理）
	output [7:0] min,		//BCD2桁の分
	output [7:0] sec,		//BCD2桁の秒
	output [7:0] msec,	//BCD2桁の1/100秒
	output run_led			//実行中の表示LED
	);
	reg r_run;
	wire [5:0] carry;
	wire [7:0] w_min;
	wire [7:0] w_sec;
	wire [7:0] w_msec;
	
	assign run_led=r_run;
	assign min=w_min;
	assign sec=w_sec;
	assign msec=w_msec;
	always @(posedge start_sw or negedge n_reset) begin
		if(n_reset==1'b0) r_run = 0;
		else r_run=~r_run;
	end
	
	m_universal_counter #(9) counter0(clk,n_reset,r_run,carry[0],w_msec[3:0]);	 	//1/100sec
	m_universal_counter #(9) counter1(clk,n_reset,carry[0],carry[1],w_msec[7:4]);	//1/10sec
	m_universal_counter #(9) counter2(clk,n_reset,carry[1],carry[2],w_sec[3:0]);		//1sec
	m_universal_counter #(5) counter3(clk,n_reset,carry[2],carry[3],w_sec[7:4]);		//10sec
	m_universal_counter #(9) counter4(clk,n_reset,carry[3],carry[4],w_min[3:0]);		//1min
	m_universal_counter #(5) counter5(clk,n_reset,carry[4],carry[5],w_min[7:4]);		//10min

	endmodule
