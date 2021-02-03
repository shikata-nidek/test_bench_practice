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

    task pushbuttoni(input i);
    begin
                BTN[i] = ~BTN[i];
            #10000000  BTN[i] = ~BTN[i];
            #10000000;
    end
    endtask

    task switchi_onoff(input j);
    begin
            SW[j] = ~SW[j];
        #1  SW[j] = ~SW[j];
        #1;
    end
    endtask

    initial begin
        CLK1 = 0;
        CLK2 = 0;
        BTN = 2'b11;
        SW = 10'h0;
        #1;
        SW[9] = ~SW[9];
        #1;
        SW[9] = ~SW[9];  // reset
        #10000000;
        repeat(10) begin
            pushbuttoni(0);
        end
    end

    always #20
        CLK1 = ~CLK1;

endmodule