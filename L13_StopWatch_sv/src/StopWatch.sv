module m_10ms_clk(input logic clk,input logic rst,output logic clk10ms);
    
    logic [19:0] cnt;
    logic r10ms;
    logic wcout;

    assign wcout = (cnt==20'd249999) ? 1'b1 : 1'b0;
    assign clk10ms = r10ms;

    always_ff @(posedge clk or negedge rst) begin
        if(rst==1'b0) begin
            cnt = 0;
            r10ms = 1'b1;
        end else if(wcout==1'b1) begin
            cnt = 0;
            r10ms = ~r10ms;
        end else
            cnt = cnt + 1; 
    end

endmodule



module m_stop_watch(
    //input
    input logic clk,
    input logic start_sw,
    input logic rst,
    //output
    output logic [7:0] min,
    output logic [7:0] sec,
    output logic [7:0] msec,
    output logic run_led
    );

    logic r_run;
    logic [5:0] carry;
    logic [7:0] w_min,w_sec,w_msec;

    assign run_led = r_run;
    assign min = w_min;
    assign sec = w_sec;
    assign msec = w_msec;

    always_ff @(posedge start_sw or negedge rst) begin
        if(rst==1'b0) r_run = 0;
        else r_run = ~r_run;
    end

    m_universal_counter #(9) counter0(.clk,.rst,.c_in(r_run),.c_out(carry[0]),.q(w_msec[3:0]));
    m_universal_counter #(9) counter1(.clk,.rst,.c_in(carry[0]),.c_out(carry[1]),.q(w_msec[7:4]));
    m_universal_counter #(9) counter2(.clk,.rst,.c_in(carry[1]),.c_out(carry[2]),.q(w_sec[3:0]));
    m_universal_counter #(5) counter3(.clk,.rst,.c_in(carry[2]),.c_out(carry[3]),.q(w_sec[7:4]));
    m_universal_counter #(9) counter4(.clk,.rst,.c_in(carry[3]),.c_out(carry[4]),.q(w_min[3:0]));
    m_universal_counter #(5) counter5(.clk,.rst,.c_in(carry[4]),.c_out(carry[5]),.q(w_min[7:4]));

endmodule

