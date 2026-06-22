module bcd_in_reg #(parameter  = WIDTH=12)(
    input clk,
    input rst,
    input LD,
    input LD1,
    input LD2,
    input LD3,
    input SHBCD,
    input bcd_in,
    input wire [3:0] added_slice_11_8,
    input wire [3:0] added_slice_7_4,
    input wire [3:0] added_slice_3_0,
    output reg [WIDTH-1:0] bcd_reg_out
);
    always @(posedge clk) begin
        if (LD)
            bcd_reg_out <= bcd_in;
        else if(rst)
            bcd_reg_out <= bcd_in;
        else if (LD1)
            
    end
endmodule