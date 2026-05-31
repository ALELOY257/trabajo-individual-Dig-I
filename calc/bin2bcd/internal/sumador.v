module sumador #(parameter WIDTH=8)(
    input clk,
    input [WIDTH-1:0] slice,
    input add,
    output reg [WIDTH-1:0] added_slice
);

    always @(posedge clk) begin
        if (add)
            added_slice <= added_slice + 3'd5;
    end

endmodule