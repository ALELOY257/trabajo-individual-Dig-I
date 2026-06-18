module led_mem(
    input clk,
    input [7:0]addr,
    output reg [23:0]rgb
);
    reg [23:0] MEM [0: (2**8 - 1)];
    initial begin
        $readmemh("./display.hex",MEM);
    end

    always @(negedge clk) begin
        rgb <= MEM[addr];
    end

endmodule