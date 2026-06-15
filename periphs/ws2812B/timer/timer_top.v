module timer_top(
    input init_t,
    input [1:0]sel,
    input clk,
    input reset,

    output dout,
    output done_t,
    output [1:0]sel_tim,
    output inc,
    output rst
);
    parameter T0H = 11'd10;
    parameter T1H = 11'd20;
    parameter PER = 11'd31;
    parameter RES = 11'd1250;
    wire [10:0]count_out;
    wire [10:0]s;
    wire v;

    


    count u_count(.clk(clk), .rst(rst), .load(), .data_in(), .inc(inc)
    , .count_out(count_out));

    mux u_mux(.sel_tim(sel_tim), .T0H(T0H), .T1H(T1H), .RES(RES), .PER(PER)
    , .s(s));

    comp #(.WIDTH(11)) u_comp(.a(count_out), .b(s), .v(v));

    control_timer u_control(.clk(clk), .reset(reset), .init_t(init_t), .sel(sel), .z(v),
    .dout(dout), .done_t(done_t), .rst(rst), .inc(inc), .sel_tim(sel_tim)  );

endmodule