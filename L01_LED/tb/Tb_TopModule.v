`timescale 1ns/1ns
module Tb_TopModule();

    reg SW;
    wire LED;

    TopModule topmodule(.sw(SW), .led(LED));

    initial begin
       #0   SW = 0;
       #50  SW = 1;
       #50  SW = 0;
       #50  SW = 1;
    end

endmodule