module TopModule(
    ////////// CLOCK //////////
    input               CLK1,
    input               CLK2,
    ////////// SEG7 //////////
    output  [7:0]       HEX0,
    output  [7:0]       HEX1,
    output  [7:0]       HEX2,
    output  [7:0]       HEX3,
    output  [7:0]       HEX4,
    output  [7:0]       HEX5,
    ////////// Push Button //////////
    input   [1:0]       BTN,
    ////////// LED //////////
    input   [9:0]       LED,
    ////////// SW //////////
    input   [9:0]       SW
    );

    wire w_and, w_or, w_not, w_xor;

    m_and u1(SW[0], SW[1], w_and);
    m_or u2(SW[2], SW[3], w_or);
    m_not u3(SW[4], w_not);
    m_xor u4(SW[5], SW[6], w_xor);

    assign LED = {3'h0, w_xor, w_xor, w_not, w_or, w_or, w_and, w_and};
    assign HEX0 = 8'hff;
    assign HEX1 = 8'hff;
    assign HEX2 = 8'hff;
    assign HEX3 = 8'hff;
    assign HEX4 = 8'hff;
    assign HEX5 = 8'hff;

endmodule
