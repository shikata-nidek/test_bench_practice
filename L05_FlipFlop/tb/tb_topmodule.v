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

    task push_buttoni(input i);
    begin
            BTN[i] = ~BTN[i];
        #1  BTN[i] = ~BTN[i];
    end
    endtask

    initial begin
        CLK1 <= 0;
        CLK2 <= 0;
        BTN <= 2'b11;
        SW <= 10'h0;
        force topmodule.u2.ff = 1'b0;
        #1;
        release topmodule.u2.ff;

        push_buttoni(0);
        push_buttoni(1);
        push_buttoni(0);
        push_buttoni(1);
        push_buttoni(0);
        push_buttoni(1);
    end

endmodule


        
        
        