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
    output   [9:0]       LED,
    ////////// SW //////////
    input   [9:0]       SW
    );

    assign HEX0 = 8'hff;
    assign HEX1 = 8'hff;
    assign HEX2 = 8'hff;
    assign HEX3 = 8'hff;
    assign HEX4 = 8'hff;
    assign HEX5 = 8'hff;

    wire [3:0] wled;
    assign LED = {6'h0, wled};

    m_selector selector(SW[9], SW[8], SW[3:0], SW[7:4], wled);

endmodule
