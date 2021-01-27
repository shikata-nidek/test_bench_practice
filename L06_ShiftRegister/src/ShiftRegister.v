module m_rs_flipflop(input set,input reset,output q,output nq);
	assign q=~(set & nq);
	assign nq=~(reset & q);
endmodule

module m_Shiftreg0(input clk, input rst, input d_in,output [2:0] q);
	reg [2:0] ff;
	
	assign q=ff;
	
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			ff = 3'h0;
		end else begin
			ff[0]=d_in;
			ff[1]=ff[0];
			ff[2]=ff[1];
		end
	end

endmodule

module m_Shiftreg1(input clk,input rst, input d_in,output [2:0] q);
	reg [2:0] ff;
	
	assign q=ff;
	
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			ff = 3'h0;
		end else begin
			ff[0]<=d_in;
			ff[1]<=ff[0];
			ff[2]<=ff[1];
		end
	end

endmodule

module m_dff(input clk,input rst, input d_in,output q);
	reg dff;
	
	assign q=dff;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			dff = 1'b0;
		end else begin
			dff=d_in;
		end
	end
endmodule

module m_Shiftreg2(input clk,input rst, input d_in,output [2:0] q);
	wire [2:0] wq;
	
	assign q=wq;
	
	m_dff u0(clk,rst,d_in,wq[0]);
	m_dff u1(clk,rst,wq[0],wq[1]);
	m_dff u2(clk,rst,wq[1],wq[2]);
endmodule

module m_Shiftreg3(input clk,input rst, input d_in,output [2:0] q);
	reg [2:0] ff;
	
	assign q=ff;
	
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			ff = 3'h0;
		end else begin
			ff={ff[1:0],d_in};
		end
	end

endmodule
