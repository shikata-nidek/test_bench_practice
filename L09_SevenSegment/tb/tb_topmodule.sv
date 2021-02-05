`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_topmodule;

    parameter P_CLK_PERIOD = 20;
    localparam L_MAX_SW_COUNT = 15;

    //  input
    logic CLK1, CLK2;
    logic [1:0] BTN;
    logic [9:0] SW;
    //  output
    logic [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    logic [9:0] LED;

    logic [7:0] HEX0_DATA;


    //  instance
    TopModule UUT(.*);

    function [7:0] HEX_DATA(input [3:0] SW);
    begin
        case(SW)
            4'h0:   HEX_DATA = 8'b11000000;
            4'h1:   HEX_DATA = 8'b11111001;
            4'h2:   HEX_DATA = 8'b10100100;
            4'h3:   HEX_DATA = 8'b10110000;
            4'h4:   HEX_DATA = 8'b10011001;
            4'h5:   HEX_DATA = 8'b10010010;
            4'h6:   HEX_DATA = 8'b10000010;
            4'h7:   HEX_DATA = 8'b11111000;
            4'h8:   HEX_DATA = 8'b10000000;
            4'h9:   HEX_DATA = 8'b10011000;
            4'hA:   HEX_DATA = 8'b10001000;
            4'hB:   HEX_DATA = 8'b10000011;
            4'hC:   HEX_DATA = 8'b10100111;
            4'hD:   HEX_DATA = 8'b10100001;
            4'hE:   HEX_DATA = 8'b10000110;
            4'hF:   HEX_DATA = 8'b10001110;
            default: HEX_DATA = 8'b11000000;
        endcase
    end
    endfunction
    assign HEX0_DATA[7:0] = HEX_DATA(SW[3:0]);


    `TEST_SUITE begin
        
        `TEST_SUITE_SETUP begin
            BTN = 2'b11;
            SW = 10'b0;
            repeat(10) @(posedge CLK1);
            $display("Running test suite setup code");
        end

        `TEST_CASE("test1_sw_and_change_number") begin
            
        end


    end

    initial begin:  gen_CLK1
        CLK1 = 1'b0;
        CLK2 = 1'b0;
        forever #(P_CLK_PERIOD/2) begin
            CLK1 = ~CLK1;
            CLK2 = ~CLK2;
        end
    end

    task t_increment_sw;
    begin
        for(int i=0; i<=L_MAX_SW_COUNT; i++) begin
            SW[3:0] = i;
            repeat(1) @(posedge CLK1);
            $display("i = %0d, HEX0 = %d, HEX0_DATA = %d", i, HEX0, HEX0_DATA);
            `CHECK_EQUAL(HEX0, HEX0_DATA);
        end
    end
    endtask

    task t_decrement_sw;
    begin
        for(int i=)
    end