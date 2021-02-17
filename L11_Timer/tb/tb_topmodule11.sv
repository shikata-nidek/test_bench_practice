`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_topmodule;

    parameter int P_CLK_PERIOD = 20; // 50MHz

    // input
    logic CLK1, CLK2;
    logic [1:0] BTN;
    logic [9:0] SW;
    // output
    logic [7:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
    logic [9:0] LED;
    // instance
    TopModule UUT(.*);
    // time
    time start,stop,diff;


    `TEST_SUITE begin
        
        `TEST_SUITE_SETUP begin
            BTN = 2'b11;
            SW = 10'b0;
            repeat(10) @(posedge (CLK1));
            BTN[1] = 1'b0;
            repeat(10) @(posedge (CLK1));
            BTN[1] = 1'b1;
            $display("Running test suite setup codes.");
        end

        `TEST_CASE("test0_inital_status") begin
            `CHECK_EQUAL(HEX0,8'hff);
            `CHECK_EQUAL(HEX1,8'hff);
            `CHECK_EQUAL(HEX2,8'hff);
            `CHECK_EQUAL(HEX3,8'hff);
            `CHECK_EQUAL(HEX4,8'hff);
            `CHECK_EQUAL(HEX5,8'hff);
            `CHECK_EQUAL(LED,10'h1);
            $display("test0 is expected to pass");
        end

        `TEST_CASE("test1_100ms_led") begin
            @(posedge (LED[1])) begin
                start = $time;
                $display("[%0t] turn on LED[1]", start);
            end
            @(negedge (LED[1])) begin
                stop = $time;
                $display("[%0t] turn off LED[1]", stop);
            end
            diff = stop - start;
            $display("time for lighting = %0t", diff);
            //$stop;
            `CHECK_EQUAL(diff, 10**8);
        end



    end

    `WATCHDOG(1s);

    initial begin: gen_CLK1
        CLK1 = 1'b0;
        CLK2 = 1'b0;
        forever #(P_CLK_PERIOD/2) begin
            CLK1 = ~CLK1;
            CLK2 = ~CLK2;
        end
    end

endmodule