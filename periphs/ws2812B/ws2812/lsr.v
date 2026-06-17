module lsr(
    input clk,
    input ld,
    input sh,
    input [23:0]rgb_in,
    output reg [23:0]rgb_out
);

    always @(negedge clk) begin
        if (ld) rgb_out <= rgb_in;
        else if (sh) rgb_out <= rgb_out<<1;
    end

endmodule