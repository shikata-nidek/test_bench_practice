module m_selector(input sel, input all_on, input [3:0] in1, input [3:0] in2, output [3:0] out);

    assign out = (all_on==1'b1) ? 4'hf : ((sel==1'b0) ? in1 : in2);

endmodule