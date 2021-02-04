`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_topmodule;

    //  input
    logic CLK1, CLK2;
    logic [1:0] BTN;
    logic [9:0] SW;
    //  output
    logic [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    logic [9:0] LED;


    //  instance
    TopModule UUT(.*);