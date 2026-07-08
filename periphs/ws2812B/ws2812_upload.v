module ws2812_upload(
    input reset,
    input clk,
    output dout,
);
    ws_array_top u_ws_array(
        .clk(clk),
        .reset(!reset),
        .init_m(1),
        .rst_cmd(0),
        .dout(dout),
        .done_m()
    );
endmodule