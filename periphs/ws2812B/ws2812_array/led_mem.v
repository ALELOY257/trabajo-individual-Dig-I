module led_mem(
    input clk,
    input addr,
    output reg [23:0]rgb
);
    reg [23:0] MEM [0: (2**8 - 1)];
    initial begin
        $readmemh("./display.hex",MEM);
    end

    always @(negedge clk) begin
        data_r <= MEM[address];
    end

endmodule