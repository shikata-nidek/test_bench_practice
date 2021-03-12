`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_topmodule;

    parameter int P_CLK_PERIOD = 20; //50MHz
    parameter int P_BUTTON_PERIOD = 2**16;
    parameter int P_COUNT_PERIOD = 10_000_000; //100Hz
    // input
    logic CLK1,CLK2;
    logic [1:0] BTN;
    logic [9:0] SW;

    // output
    logic [7:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
    logic [9:0] LED;

    // instance
    TopModule topmodule(.*);
    logic [6:0] hex_tbl [0:9] = '{
        7'b100_0000,
        7'b111_1001,
        7'b010_0100,
        7'b011_0000,
        7'b001_1001,
        7'b001_0010,
        7'b000_0010,
        7'b111_1000,
        7'b000_0000,
        7'b001_1000
    };

    `TEST_SUITE begin
        
        `TEST_SUITE_SETUP begin
            BTN = 2'b11;
            SW = 10'b0;
            repeat(P_BUTTON_PERIOD) @(posedge CLK1);
            t_push_buttoni(1,P_BUTTON_PERIOD);
        end

        `TEST_CASE("test0_initial_status") begin
            `CHECK_EQUAL(HEX0, {1'b1,hex_tbl[0]});
            `CHECK_EQUAL(HEX1, {1'b1,hex_tbl[0]});
            `CHECK_EQUAL(HEX2, {1'b0,hex_tbl[0]});
            `CHECK_EQUAL(HEX3, {1'b1,hex_tbl[0]});
            `CHECK_EQUAL(HEX4, {1'b0,hex_tbl[0]});
            `CHECK_EQUAL(HEX5, {1'b1,hex_tbl[0]});
            `CHECK_EQUAL(LED, 10'h0);
        end

        `TEST_CASE("test1_counting_hex0_up") begin
            fork
                begin
                    t_push_buttoni(0,P_BUTTON_PERIOD);
                end
                begin
                    for(int i=1; i<10; i++) begin
                        #(10ms);
                        `CHECK_EQUAL(HEX0,{1'b1,hex_tbl[i]});
                    end
                end
            join
        end

        `TEST_CASE("test2_carrying_hex1_up") begin
            fork
                begin
                    t_push_buttoni(0,P_BUTTON_PERIOD);
                end
                begin
                    for(int i=1; i<11; i++) begin
                        #(10ms);
                        if(i==10)
                            `CHECK_EQUAL(HEX1,{1'b1,hex_tbl[1]});
                    end
                end
            join
        end
        
    end

    task t_push_buttoni(int i,int interval);
        $display("[%0d] push",$time);
        BTN[i] = 1'b0;
        repeat(interval) @(posedge CLK1);
        $display("[%0d] release",$time);
        BTN[i] = 1'b1;
        repeat(interval) @(posedge CLK1);
    endtask

    `WATCHDOG(150ms);
    initial begin:  gen_CLK
        CLK1=1'b0;
        CLK2=1'b0;
        forever #(P_CLK_PERIOD/2) begin
            CLK1=~CLK1;
            CLK2=~CLK2;
        end
    end

endmodule