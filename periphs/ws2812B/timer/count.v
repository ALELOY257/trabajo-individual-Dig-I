module count #(
    parameter WIDTH = 8  
)(
    input clk,
    input rst,
    input load,          
    input [WIDTH-1:0] data_in,
    input inc,           
    output reg [WIDTH-1:0] count_out
);

always @(negedge clk) begin
    if (rst) begin
        count_out <= {WIDTH{1'b0}};
    end else if (load) begin
        count_out <= data_in;    
    end else if (inc) begin
        count_out <= count_out + 1'b1;
    end
end 

endmodule