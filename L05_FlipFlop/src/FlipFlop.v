module m_rs_flipflop(input set, input reset, output q, output nq);

    assign q = ~(set & nq);
    assign nq = ~(reset & q);

endmodule

module m_flipflop (input clk, output q);

    reg ff;

    always @(posedge clk) begin
        ff = ~ff;
    end
    assign q = ff;
    
endmodule