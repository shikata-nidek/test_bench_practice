`timescale 1ns/1ns
module tb_topmodule();

    // input
    reg CLK1, CLK2;
    reg [1:0] BTN;
    reg [9:0] SW;
    // output
    wire [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    wire [9:0] LED;

    TopModule topmodule(.*);

    initial begin
        CLK1 = 0;
        CLK2 = 0;
        BTN = 2'b11;
        SW = 10'h0;
        //LED = 10'h0;

        /*HEX0 = 8'hff;
        HEX1 = 8'hff;
        HEX2 = 8'hff;
        HEX3 = 8'hff;
        HEX4 = 8'hff;
        HEX5 = 8'hff;
        */
    end

    initial begin
        repeat(5) @(posedge CLK1);
        SW = {3'h0, 7'b0110101};
        @(posedge CLK1);
        SW = {3'h0, 7'b1001010};
        @(posedge CLK1);
        SW = {3'h0, 7'b1111111};
    end

    always #10
        CLK1 = ~CLK1;

endmodule
