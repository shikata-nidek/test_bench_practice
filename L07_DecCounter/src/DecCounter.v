module m_rs_flipflop(input set,input reset,output q,output nq);
	assign q=~(set & nq);
	assign nq=~(reset & q);
endmodule


module m_dec_counter(input clk,output [3:0] q);
	reg [3:0] counter;
	
	always @(posedge clk) begin
		if(counter==4'h9) begin
			counter=0;
		end
		else begin
			counter=counter+1;
		end
	end
	
	assign q=counter;
endmodule

