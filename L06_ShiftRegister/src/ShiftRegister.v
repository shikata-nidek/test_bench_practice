module m_rs_flipflop(input set,input reset,output q,output nq);
	assign q=~(set & nq);
	assign nq=~(reset & q);
endmodule

module m_Shiftreg0(input clk,input d_in,output [2:0] q);
	reg [2:0] ff;
	
	assign q=ff;
	
	always @(posedge clk) begin
		ff[0]=d_in;
		ff[1]=ff[0];
		ff[2]=ff[1];
	end

endmodule

module m_Shiftreg1(input clk,input d_in,output [2:0] q);
	reg [2:0] ff;
	
	assign q=ff;
	
	always @(posedge clk) begin
		ff[0]<=d_in;
		ff[1]<=ff[0];
		ff[2]<=ff[1];
	end

endmodule

module m_dff(input clk,input d_in,output q);
	reg dff;
	
	assign q=dff;
	always @(posedge clk) begin
		dff=d_in;
	end
endmodule

module m_Shiftreg2(input clk,input d_in,output [2:0] q);
	wire [2:0] wq;
	
	assign q=wq;
	
	m_dff u0(clk,d_in,wq[0]);
	m_dff u1(clk,wq[0],wq[1]);
	m_dff u2(clk,wq[1],wq[2]);
endmodule

module m_Shiftreg3(input clk,input d_in,output [2:0] q);
	reg [2:0] ff;
	
	assign q=ff;
	
	always @(posedge clk) begin
		ff={ff[1:0],d_in};
	end

endmodule
