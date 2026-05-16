module lsb_replace #(parameter WIDTH = 8)(
    input clk,
    input rst,
    input shift,
    input replacing_value,
    output reg [WIDTH-1:0] generic_output
);
    always @(posedge clk) begin
        if (rst) 
            generic_output <= {WIDTH{1'b0}};
        else if (shift) 
            generic_output <= {generic_output[WIDTH-2:0], replacing_value};
    end

endmodule