module ws_array_top(
    input clk,
    input reset,
    input init_m,
    input rst_cmd,
    output dout,
    output done_m
);
    parameter N_LEDS = 2**8;
    wire rst, init_led, inc;
    wire [7:0]addr;
    wire [23:0]rgb;

    wire done_led;

    wire z;



    count_addr u_count_addr(
        .clk(clk), .rst(rst), .inc(inc),
        .addr(addr)
    );

    led_mem u_led_mem(
        .clk(clk), .addr(addr), 
        .rgb(rgb)
    );

    ws_top u_ws_top(
        .clk(clk), .reset(reset), .init(init_led), .rst_cmd(rst_cmd), .rgb(rgb),
        .dout(dout), .done(done_led)
    );

    comp #(.WIDTH(8)) u_comp( // sirve exactamente el mismo del timer
        .a(N_LEDS-1), .b(addr),
        .v(z)
    );

    control_ws_array u_control(
        .clk(clk), .reset(reset), .init_m(init_m), .done_led(done_led), .z(z),
        .done(done_m), .init_led(init_led), .rst(rst), .inc(inc)
    );



endmodule