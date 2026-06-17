module count_addr(
    input clk,
    input rst,
    input inc,
    output reg [7:0] addr
);
    always @(negedge clk) begin
        if (rst)
            addr <= 0;
        else begin
            if (inc)
                addr <= addr +1;
            else
                addr <= addr;
        end
    end
endmodule