`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_10ms_clk;
    parameter P_CLK_PERIOD = 20; //50MHz

    //input
    logic clk,rst;
    //output
    logic clk10ms;
    //instance
    m_10ms_clk clk_10ms(.*);

    `TEST_SUITE begin
        
        `TEST_SUITE_SETUP begin
            rst = 1'b1;
            @(posedge clk);
            rst = 1'b0;
            @(posedge clk);
            rst = 1'b1;
        end

        `TEST_CASE("test1_check_10ms_countedge") begin
            int cnt_edge;
            cnt_edge = 0;
            @(posedge clk);
            fork
                begin: wait_10ms_clk
                    @(posedge clk10ms);
                end
                begin: counting
                    while(1) @(posedge clk) cnt_edge++;
                end
            join_any
            $display("cnt_edge = %0d", cnt_edge);
            `CHECK_EQUAL(cnt_edge,499999);
            disable counting;
        end

        `TEST_CASE("test2_check_10ms_counttime") begin
            time duration,start,stop;
            @(posedge clk10ms);
            start = $time;
            $display("[%0d] start",start);
            @(posedge clk10ms);
            stop = $time;
            $display("[%0d] stop",stop);
            duration = stop - start;
            $display("duration = %0d",duration);
            `CHECK_EQUAL(duration,10_000_000);
        end

    end

    `WATCHDOG(100ms);
    initial begin: gen_clk
        clk = 1'b0;
        forever #(P_CLK_PERIOD/2)
            clk = ~clk;
    end

endmodule