//汎用カウンタ
module m_universal_counter(input clk,input n_reset,input c_in,output c_out,output [3:0] q);
	parameter maxcnt=15;	//default=HEX counter
	reg [3:0] cnt;
	
	assign q=cnt;
	assign c_out=((cnt==maxcnt) && (c_in==1'b1)) ? 1'b1 : 1'b0;
	
	always@(posedge clk or negedge n_reset) begin
		if(n_reset==1'b0) begin
			cnt=4'h0;
		end
		else begin
			if(c_in==1'b1) begin
				if(cnt==maxcnt)
					cnt=4'h0;
				else
					cnt=cnt+1;
			end
		end
	end
	
endmodule

//チャタリング除去
module m_chattering(input clk,input sw_in,output sw_out);
	reg [15:0] cnt;	//16bit counter
	reg swreg;			//Switch Latch
	wire iclk;			//1/65536 clock
	
	assign sw_out=swreg;
	
	//16bit Counter
	always @(posedge clk) begin
		cnt=cnt+1;
	end
	assign iclk=cnt[15];	//clock for chattering inhibit
	
	//switch latch 
	always @(posedge iclk) begin
		swreg=sw_in;
	end

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



