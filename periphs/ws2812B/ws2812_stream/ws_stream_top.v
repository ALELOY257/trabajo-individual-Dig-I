module ws_stream_top(
    input clk,
    input reset,
    input init_m,
    input rst_cmd,
    output dout,
    output done_m, 
);

    wire rst, init_led, inc, addr;

    wire [23:0]rgb,

    wire done_led;

    count_addr u_count_addr(
        .clk(clk), .rst(rst),
        .addr(addr)
    );

    led_mem u_led_mem(
        .addr(addr), 
        .
    );

    ws_top u_ws_top(
        .clk(clk), .reset(reset), .init(init_led), .rst_cmd(rst_cmd), .rgb(rgb),
        .dout(dout), .done(done_led)
    );



endmodule