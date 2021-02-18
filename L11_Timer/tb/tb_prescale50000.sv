`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_prescale50000;

    parameter P_CLK_PERIOD = 20; // 50MHz

    // input
    logic clk;
    logic rst;

    // output
    logic c_out;

    // instance
    m_prescale50000 prescale50000(.*);

    `TEST_SUITE begin
        
        `TEST_SUITE_SETUP begin
            rst = 1'b0;
            repeat(10) @(posedge clk);
            rst = 1'b1;
            repeat(10) @(posedge clk);
            rst = 1'b0;
            $display("Running test suite setup code");
        end

        `TEST_CASE("test0_initial_status") begin
            `CHECK_EQUAL(c_out, 1'b0);
        end

        `TEST_CASE("test1_count50000") begin
            int cnt_edge;
            cnt_edge = 0;
            @(posedge clk) cnt_edge++;
            if(cnt_edge==50000)
                `CHECK_EQUAL(c_out, 1'b1);
        end

    end

    `WATCHDOG(1s);

    initial begin: gen_clk
        clk = 1'b0;
        forever #(P_CLK_PERIOD/2) begin
            clk = ~clk;
        end
    end

endmodule