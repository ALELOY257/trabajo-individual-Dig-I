module counter #(parameter WIDTH=8)(
    input clk,
    input rst,
    input dec,
    input load,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] count_out
);
    always @(posedge clk) begin
        if (rst)
            count_out <= {WIDTH{1'b0}};
        else if (load)
            count_out <= data_in;
        else if (dec)
            count_out <= count_out -1;
    end
endmodule