//リセット及びキャリー出力付き10進カウンタ
module m_dec_counter2(input clk,output [3:0] q,input n_reset,input c_in,output c_out);
	reg [3:0] counter;
	
	assign c_out=(counter==4'h9) ? 1 : 0;
	
	always @(posedge clk or negedge n_reset) begin
		if(n_reset==1'b0) begin
			counter=0;
		end
		else begin
			if(c_in==1'h1) begin
				if(counter==4'h9) begin
					counter=0;
				end else begin
					counter=counter+1;
				end
			end
		end
	end
	
	assign q=counter;
endmodule

//8bit BCDカウンタ
module m_bcd_counter(input clk,input n_reset,output [7:0] bcd_out);
	wire w_carry,w_cout;	//キャリー
	wire [7:0] w_bcd;		//BCDデータ
	
	//下位4ビット
	m_dec_counter2 u0(clk,w_bcd[3:0],n_reset,1'b1,w_carry);
	//上位4ビット
	m_dec_counter2 u1(clk,w_bcd[7:4],n_reset,w_carry,w_cout);
	
	assign bcd_out=w_bcd;
	
endmodule
	

//7セグメントデコーダ
module m_seven_segment(input [3:0] idat,output [7:0] odat);

    function [7:0] LedDec;
      input [3:0] num;
      begin
         case (num)
           4'h0:        LedDec = 8'b11000000;  // 0
           4'h1:        LedDec = 8'b11111001;  // 1
           4'h2:        LedDec = 8'b10100100;  // 2
           4'h3:        LedDec = 8'b10110000;  // 3
           4'h4:        LedDec = 8'b10011001;  // 4
           4'h5:        LedDec = 8'b10010010;  // 5
           4'h6:        LedDec = 8'b10000010;  // 6
           4'h7:        LedDec = 8'b11111000;  // 7
           4'h8:        LedDec = 8'b10000000;  // 8
           4'h9:        LedDec = 8'b10011000;  // 9
           4'ha:        LedDec = 8'b10001000;  // A
           4'hb:        LedDec = 8'b10000011;  // B
           4'hc:        LedDec = 8'b10100111;  // C
           4'hd:        LedDec = 8'b10100001;  // D
           4'he:        LedDec = 8'b10000110;  // E
           4'hf:        LedDec = 8'b10001110;  // F
           default:     LedDec = 8'b11111111;  // LED OFF
         endcase
      end 
    endfunction
	
	assign odat=LedDec(idat);
endmodule

//チャタリング除去
module m_chattering(input clk,input sw_in,input rst,output sw_out);
	reg [15:0] cnt;	//16bit counter
	reg swreg;			//Switch Latch
	wire iclk;			//1/65536 clock
	
	assign sw_out=swreg;
	
	//16bit Counter
	always @(posedge clk or negedge rst) begin
		if(~rst) begin
			cnt = 16'b0;
			swreg = 1'b1;
		end else
			cnt=cnt+1;
	end
	assign iclk=cnt[15];	//clock for chattering inhibit
	
	//switch latch 
	always @(posedge iclk) begin
		swreg=sw_in;
	end

endmodule

