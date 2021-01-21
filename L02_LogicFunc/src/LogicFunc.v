module m_and(input in1, input in2, output out);
    assign out = in1 & in2;
endmodule

module m_or(input in1, input in2, output out);
    assign out = in1 | in2;
endmodule

module m_not(input in1, output out);
    assign out = ~in1;
endmodule

module m_xor(input in1, input in2, output out);
    assign out = in1 ^ in2;
endmodule