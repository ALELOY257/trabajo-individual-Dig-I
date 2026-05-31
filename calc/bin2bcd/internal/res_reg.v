module res_reg #(parameter WIDTH=8)(
    input wire clk,
    input wire rst,
    input wire LD,
    input wire SHRES,
    input wire replacing_bit,
    output reg [WIDTH-1:0] res_out
);

    always @(posedge clk)begin
        if (rst)
            res_out <= {WIDTH{1'b0}};
        else if (LD)
            res_out <= {WIDTH{1'b0}};
        else if (SHRES)
            res_out <= {res_out[WIDTH-2:0], replacing_bit}
    end

endmodule