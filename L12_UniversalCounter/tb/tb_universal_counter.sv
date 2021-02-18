`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_universal_counter;

    parameter int P_PUSHBUTTON_PERIOD = 100;
    parameter int P_BASE_NUMBER = 9;

    // input
    logic clk;
    logic n_reset;
    logic c_in;

    // output
    logic c_out;
    logic [3:0] q;

    // instance
    m_universal_counter #(P_BASE_NUMBER) universal_counter(.*);

    `TEST_SUITE begin
        
        `TEST_SUITE_SETUP begin
            clk = 1'b0;
            n_reset = 1'b1;
            c_in = 1'b1;
            #(P_PUSHBUTTON_PERIOD);
            n_reset = 1'b0;
            #(P_PUSHBUTTON_PERIOD);
            n_reset = 1'b1;
            #(P_PUSHBUTTON_PERIOD);
        end

        `TEST_CASE("test0_initial_status") begin
            `CHECK_EQUAL(clk, 1'b0);
            `CHECK_EQUAL(n_reset, 1'b1);
            `CHECK_EQUAL(c_in, 1'b1);
        end

        `TEST_CASE("test1_push_and_countup") begin
            for(int i=1; i<P_BASE_NUMBER; i++) begin
                t_push_button0(P_PUSHBUTTON_PERIOD);
                `CHECK_EQUAL(c_out, 1'b0);
                `CHECK_EQUAL(q, i);
            end
        end

        `TEST_CASE("test2_carryout") begin
            for(int i=1; i<P_BASE_NUMBER+1; i++) begin
                t_push_button0(P_PUSHBUTTON_PERIOD);
                if(i==P_BASE_NUMBER) begin
                    `CHECK_EQUAL(c_out, 1'b1);
                    t_push_button0(P_PUSHBUTTON_PERIOD);
                    `CHECK_EQUAL(q, 0);
                end
            end
        end

    end

    `WATCHDOG(100ms);

    task t_push_button0(int interval);
        $display("[%0t] push BTN[0]", $time);
        clk = 1'b1; // push
        #(interval);
        $display("[%0t] release BTN[0]", $time);
        clk = 1'b0; // release
        #(interval);
    endtask

endmodule