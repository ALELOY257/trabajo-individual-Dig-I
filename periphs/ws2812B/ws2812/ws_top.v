module ws_top(
    input clk,
    input reset,
    input init, 
    input rst_cmd,
    input [23:0]rgb,
    output dout,
    output done
);
    wire LD, SH;
    wire [23:0]rgb_out;
    wire DEC, z;
    wire init_t, done_t;

    lsr u_lsr(.clk(clk), .ld(LD), .sh(SH), .rgb_in(rgb),
            .rgb_out(rgb_out));

    count u_count(.clk(clk), .ld(LD), .dec(DEC),
                    .z(z));

    timer_top u_timer(.clk(clk), .reset(rst_cmd), .init_t(init_t), .sel({rst_cmd, rgb_out[23]}),
                        .dout(dout), .done_t(done_t), .sel_tim(), .inc(), .rst());

    control_ws u_control(.clk(clk), .reset(reset), .init(init), .done_t(done_t), .z(z),
                        .SH(SH), .INIT_T(init_t), .DEC(DEC), .LD(LD), .DONE(done));
endmodule
