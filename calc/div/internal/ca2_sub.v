module ca2_sub #(
    parameter WIDTH = 8
)(
    input  wire [WIDTH-1:0] divisor,
    input  wire [WIDTH-1:0] helper,
    output reg  [WIDTH-1:0] ca2_res
);

    always @(*) begin
        ca2_res = helper -((~divisor) + 1'b1);
    end

endmodule