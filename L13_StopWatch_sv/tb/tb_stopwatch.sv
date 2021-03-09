`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_stopwatch;

    parameter int P_CLK_PERIOD = 10000000; //100Hz

    //input
    logic clk,start_sw,rst;
    //ouput
    logic [7:0] min,sec,msec;
    logic run_led;
    //instance
    m_stop_watch stopwatch(.*);

    `TEST_SUITE begin
        
        `TEST_SUITE_SETUP begin
            start_sw=1'b0;
            rst=1'b1;
            @(posedge clk);
            rst=1'b0;
            @(posedge clk);
            rst=1'b1;
        end

        `TEST_CASE("test0_initial_status") begin
            `CHECK_EQUAL(run_led,1'b0);
            `CHECK_EQUAL(min,8'h0);
            `CHECK_EQUAL(sec,8'h0);
            `CHECK_EQUAL(msec,8'h0);
        end

        `TEST_CASE("test1_counting_msec") begin
            fork
                begin
                    t_push_start_sw();
                end
                begin
                    for(int i=0; i<10; i++) begin
                        @(posedge clk);
                        `CHECK_EQUAL(msec[3:0], i);
                    end
                end
            join
        end

        /*`TEST_CASE("test1_counting_another") begin
            t_push_start_sw();
            for(int i=0; i<10; i++) begin
                @(posedge clk);
                `CHECK_EQUAL(msec[3:0],i);
            end
        end*/

        `TEST_CASE("test2_carrying_msec") begin
            fork
                begin
                    t_push_start_sw();
                end
                begin
                    for(int i=0; i<11; i++)
                        @(posedge clk);
                    `CHECK_EQUAL(msec[7:4],1);
                    `CHECK_EQUAL(msec[3:0],0); 
                end
            join
        end

        `TEST_CASE("test3_turning_led_on_and_off") begin
            t_push_start_sw();
            `CHECK_EQUAL(run_led,1'b1);
            t_push_start_sw();
            `CHECK_EQUAL(run_led,1'b0);
        end


    end

    task t_push_start_sw;
        $display("[%0d] push",$time);
        start_sw=1'b1;
        @(posedge clk);
        $display("[%0d] release",$time);
        start_sw=1'b0;
        @(posedge clk);
    endtask

    `WATCHDOG(500ms);
    initial begin: gen_clk
        clk=1'b0;
        forever #(P_CLK_PERIOD/2)
            clk=~clk;
    end

endmodule