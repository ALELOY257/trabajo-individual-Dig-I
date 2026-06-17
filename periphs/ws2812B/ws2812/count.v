module count(
    input clk,
    input ld,
    input dec,
    output reg z
);

    reg [4:0]count;
    always @(negedge clk) begin
        if (ld) count <= 24;
        else if (dec) count <= count-1;
    end

    always @(*) begin
    if (count == 0)
        z <= 1;
    else
        z <= 0;
    end
endmodule