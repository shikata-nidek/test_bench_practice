`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_10ms_clk;

    parameter P_CLK_PERIOD = 20; // 50MHz

    // input
    logic clk;
    logic rst;
    // output
    logic clk10ms;
    // instance
    m_10ms_clk clk_10ms(.*);

    `TEST_SUITE begin
        
        `TEST_SUITE_SETUP begin
            rst = 1'b1;
            repeat(10) @(posedge clk);
            rst = 1'b0;
            repeat(10) @(posedge clk);
            rst = 1'b1;
        end

        `TEST_CASE("test1_check_10ms") begin
            int cnt_edge;
            cnt_edge = 0;
            $display("[%0t] start", $time);
            fork
                begin: wait_10ms_clk
                    @(posedge clk10ms);
                end
                begin: counting
                    while(1) @(posedge clk) cnt_edge++;
                end
            join_any
            `CHECK_EQUAL(cnt_edge, 5000000/P_CLK_PERIOD);
            $display(cnt_edge);
            disable counting;
            

        end


    end

    `WATCHDOG(100ms);

    initial begin: gen_clk
        clk = 1'b0;
        forever #(P_CLK_PERIOD/2) begin
            clk = ~clk;
        end
    end

endmodule