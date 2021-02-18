`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_topmodule;

    parameter int P_CLK_PERIOD = 20; // 50MHz
    parameter int P_PUSHBUTTON_PERIOD = 2**16;
    parameter int P_BASE_NUMBER = 7;

    // input
    logic CLK1,CLK2;
    logic [1:0] BTN;
    logic [9:0] SW;

    // output
    logic [7:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
    logic [9:0] LED;

    // instance
    TopModule topmodule(.*);

    `TEST_SUITE begin
        
        `TEST_SUITE_SETUP begin
            BTN = 2'b11;
            SW = 10'b0;
            repeat(10) @(posedge CLK1);
            BTN[1] = 1'b0;
            repeat(10) @(posedge CLK1);
            BTN[1] = 1'b1;
        end

        `TEST_CASE("test0_initial_status") begin
            `CHECK_EQUAL(HEX0, 8'b11000000);
            `CHECK_EQUAL(HEX1, 8'b11000000);
            `CHECK_EQUAL(HEX2, 8'hff);
            `CHECK_EQUAL(HEX3, 8'hff);
            `CHECK_EQUAL(HEX4, 8'hff);
            `CHECK_EQUAL(HEX5, 8'hff);
            `CHECK_EQUAL(LED, 10'h0);
        end


    end

    `WATCHDOG(100ms);

    task t_push_button0(int interval);
        $display("[%0t] push", $time);
        BTN[0] = 1'b0;
        repeat(interval) @(posedge CLK1);
        $display("[%0t] release", $time);
        BTN[0] = 1'b1;
        repeat(interval) @(posedge CLK1);
    endtask


    initial begin: gen_CLK
        CLK1 = 1'b0;
        CLK2 = 1'b0;
        forever #(P_CLK_PERIOD/2) begin
            CLK1 = ~CLK1;
            CLK2 = ~CLK2;
        end
    end

endmodule