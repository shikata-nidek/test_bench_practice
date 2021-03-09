module m_universal_counter(
    //input
    input logic clk,
    input logic rst,
    input logic c_in,
    //output
    output logic c_out,
    output logic [3:0] q
    );

    parameter maxcnt = 15;
    logic [3:0] cnt;
    assign q = cnt;
    assign c_out = ((cnt==maxcnt) && (c_in==1'b1)) ? 1'b1 : 1'b0;

    always_ff @(posedge clk or negedge rst) begin
        if(rst==1'b0)
            cnt = 4'h0;
        else begin
            if(c_in==1'b1) begin
                if(cnt==maxcnt)
                    cnt = 4'h0;
                else
                    cnt = cnt + 1;
            end     
        end
    end

endmodule


module m_chattering(
    //input
    input logic clk,
    input logic rst,
    input logic sw_in,
    //output
    output logic sw_out
    );

    logic [15:0] cnt;
    logic swreg = 0;
    logic iclk;
    assign sw_out = swreg;

    always_ff @(posedge clk or negedge rst) begin
        if(rst==1'b0)
            cnt = 0;
        else
            cnt = cnt + 1; 
    end

    assign iclk = cnt[15];
 
    always_ff @(posedge iclk) begin
        swreg = sw_in;
    end

endmodule

module m_seven_segment(
    //input
    input logic [3:0] idat,
    //output
    output logic [7:0] odat
    );

    parameter dot = 1'b1;
    function [7:0] LedDec;
        input [3:0] num;
        begin
            case(num)
                4'h0:        LedDec = 8'b11000000;  // 0
                4'h1:        LedDec = 8'b11111001;  // 1
                4'h2:        LedDec = 8'b10100100;  // 2
                4'h3:        LedDec = 8'b10110000;  // 3
                4'h4:        LedDec = 8'b10011001;  // 4
                4'h5:        LedDec = 8'b10010010;  // 5
                4'h6:        LedDec = 8'b10000010;  // 6
                4'h7:        LedDec = 8'b11111000;  // 7
                4'h8:        LedDec = 8'b10000000;  // 8
                4'h9:        LedDec = 8'b10011000;  // 9
                4'ha:        LedDec = 8'b10001000;  // A
                4'hb:        LedDec = 8'b10000011;  // B
                4'hc:        LedDec = 8'b10100111;  // C
                4'hd:        LedDec = 8'b10100001;  // D
                4'he:        LedDec = 8'b10000110;  // E
                4'hf:        LedDec = 8'b10001110;  // F
                default:     LedDec = 8'b11111111;  // LED OFF
            endcase
        end
    endfunction

    logic [7:0] tdat;
    assign tdat = LedDec(idat);
    assign odat = {dot,tdat[6:0]};

endmodule

