module TopModule(
    // input
    input logic           CLK1,
    input logic           CLK2,
    input logic   [1:0]   BTN,
    input logic   [9:0]   SW,
    // output
    output logic   [7:0]   HEX0,
    output logic   [7:0]   HEX1,
    output logic   [7:0]   HEX2,
    output logic   [7:0]   HEX3,
    output logic   [7:0]   HEX4,
    output logic   [7:0]   HEX5,
    output logic   [9:0]   LED
    );

    logic clk10ms,button,start_sw,run_led;
    logic [7:0] w_min,w_sec,w_msec;
    assign start_sw = ~button;

    m_chattering chattering(.clk(CLK1),.rst(BTN[1]),.sw_in(BTN[0]),.sw_out(button));
    m_10ms_clk clk_10ms(.clk(CLK1),.rst(BTN[1]),.clk10ms);
	m_stop_watch stop_watch(.clk(clk10ms),.start_sw,.rst(BTN[1]),.min(w_min),.sec(w_sec),.msec(w_msec),.run_led);
	
	assign LED={9'h0,run_led};
	m_seven_segment #(1) seg0(.idat(w_msec[3:0]),.odat(HEX0));
	m_seven_segment #(1) seg1(.idat(w_msec[7:4]),.odat(HEX1));
	m_seven_segment #(0) seg2(.idat(w_sec[3:0]),.odat(HEX2));
	m_seven_segment #(1) seg3(.idat(w_sec[7:4]),.odat(HEX3));
	m_seven_segment #(0) seg4(.idat(w_min[3:0]),.odat(HEX4));
	m_seven_segment #(1) seg5(.idat(w_min[7:4]),.odat(HEX5));
	
endmodule
