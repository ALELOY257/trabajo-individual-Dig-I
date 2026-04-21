module blink(
    input clk,
    input rst,
    output led
);
reg [23:0] count;
assign led = ~count[23];


always @(posedge clk) begin
    if ~(rst) begin
        count <= count;
    end
    else begin
        count <= count +1;
    end


end


endmodule 
