module m_chattering(input clk,input sw_in,input rst,output sw_out);
	reg [15:0] cnt;	//16bit counter
	reg swreg;			//Switch Latch
	wire iclk;			//1/65536 clock
	
	assign sw_out=swreg;
	
	//16bit Counter
	always @(posedge clk or posedge rst) begin
		if(rst)
			cnt=16'h0;
		else
			cnt=cnt+1;
	end
	assign iclk=cnt[15];	//clock for chattering inhibit
	
	//switch latch 
	always @(posedge iclk) begin
		swreg=sw_in;
	end

endmodule

module m_dec_counter(input clk,input rst,output [3:0] q);
	reg [3:0] counter;
	
	always @(posedge clk or posedge rst) begin
		if(rst)
			counter=0;
		else if(counter==4'h9)
			counter=0;
		else
			counter=counter+1;
	end
	
	assign q=counter;
endmodule

