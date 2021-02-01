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
            #1  BTN[i] = ~BTN[i];
            #1;
    end
    endtask

    task pushbutton_3times();
    begin
        repeat(3) begin
            pushbuttoni(0);
            pushbuttoni(1);
        end
    end
    endtask

    initial begin
        CLK1 <= 0;
        CLK2 <= 0;
        BTN <= 2'b11;
        SW <= 10'h0;
        #1;
        SW[7] <= 1'b1;  // reset
        #1;
        SW[7] <= 1'b0;
        #1;
        SW[0] <= 1'b1;
        #1;
        pushbutton_3times();
        SW[0] <= 1'b0;
        #1;
        pushbutton_3times();
        SW[8] <= 1'b1;
        SW[0] <= 1'b1;
        #1;
        pushbutton_3times();
        SW[0] <= 1'b0;
        #1;
        pushbutton_3times();
    end

endmodule