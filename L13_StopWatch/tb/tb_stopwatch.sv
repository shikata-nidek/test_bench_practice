`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_stopwatch;

    parameter int P_CLK_PERIOD = 20; // 50MHz
    parameter int P_PUSH_BUTTON_PERIOD = 2**16;

    //input 
    logic clk;
    logic start_sw;
    logic n_reset;

    //output
    logic [7:0] min;
    logic [7:0] sec;
    logic [7:0] msec;
    logic run_led;

    //instance
    m_stop_watch stopwatch(.*);
    

    `TEST_SUITE begin
        
        `TEST_SUITE_SETUP begin
            start_sw = 1'b0;
            n_reset = 1'b1;
            repeat(10) @(posedge clk);
            n_reset = 1'b0;
            repeat(10) @(posedge clk);
            n_reset = 1'b1;
        end

        `TEST_CASE("test0_initial_status") begin
            `CHECK_EQUAL(run_led, 1'b0);
            `CHECK_EQUAL(min, 8'h0);
            `CHECK_EQUAL(sec, 8'h0);
            `CHECK_EQUAL(msec, 8'h0);
        end

        `TEST_CASE("test1_start_counting") begin
            t_push_button0(1);
            repeat(9) @(posedge clk);
            `CHECK_EQUAL(msec[7:4], 4'h1);
        end

        `TEST_CASE("test2_start_and_stop_led") begin
            t_push_button0(1);
            `CHECK_EQUAL(run_led, 1'b1);
            t_push_button0(1);
            `CHECK_EQUAL(run_led, 1'b0);
        end

        `TEST_CASE("test3_push_reset_led") begin
            t_push_button1(1);
            `CHECK_EQUAL(run_led, 1'b0);
        end

    end

    `WATCHDOG(100ms);

    task t_push_button0(int interval);
        $display("[%0t] push", $time);
        start_sw = 1'b1;
        repeat(interval) @(posedge clk);
        $display("[%0t] release", $time);
        start_sw = 1'b0;
        repeat(interval) @(posedge clk);
    endtask

    task t_push_button1(int interval);
        $display("[%0t] reset push", $time);
        n_reset = 1'b0;
        repeat(interval) @(posedge clk);
        $display("[%0t] reset release", $time);
        n_reset = 1'b1;
        repeat(interval) @(posedge clk);
    endtask


    initial begin: gen_clk
        clk = 1'b0;
        forever #(P_CLK_PERIOD/2) begin
            clk = ~clk;
        end
    end

endmodule