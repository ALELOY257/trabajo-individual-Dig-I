module bcd2bin_top #(
    parameter WIDTH=12,
    parameter SLICE_WIDTH=4
) (
    input clk,
    input rst,
    input init,
    input [WIDTH-1:0]bcd_in,
    output wire [8:0] res,
    output wire done
);
    wire v_1, v_2, v_3, z;
    wire SHBCD, LD, SHBIN, LD1, LD2, LD3;

    reg [WIDTH-1:0] bcd_out;

    wire [SLICE_WIDTH-1:0] added_slice_11_8, added_slice_7_4, added_slice_3_0;
    control_bcd2bin u_control(
        .clk(clk), .rst(rst), .init(init), .v_1(v_1), .v_2(v_2), .v_3(v_3), .z(z),
        .SHBCD(SHBCD), .LD(LD), .SHBIN(SHBIN), .LD1(LD1), .LD2(LD2), .LD3(LD3),
        .done(done)
    );

    bcd_in_reg u_bcd_in_reg(
        .clk(clk), .rst(rst), .bcd_in(bcd_in), .LD1(LD1), .LD2(LD2), .LD3(LD3), .SHBCD(SHBCD), .LD(LD),
        .added_slice_11_8(added_slice_11_8), .added_slice_7_4(added_slice_7_4), .added_slice_3_0(added_slice_3_0),
        .bcd_out(bcd_out)
    );

    bin_res_reg u_bin_res_reg(
        .clk(clk), .rst(rst), .bcdlsb(bcd_out[0]), .SHBIN(SHBIN), .LD(LD),
        .bin_out(res)
    );

    count u_count(
        .clk(clk), .rst(rst), .LD(LD), .DECC(DECC), .init_val(WIDTH),
        .z(z)
    );

    comp comp_11_8(
        .a(bcd_in[11:8]), .b(2'd3),
        .v(v_1)
    );

    comp comp_7_4(
        .a(bcd_in[7:4]), .b(2'd3),
        .v(v_2)
    );

    comp comp_3_0(
        .a(bcd_in[3:0]), .b(2'd3),
        .v(v_3)
    );

    restador #(.WIDTH(SLICE_WIDTH)) res_11_8(
        .slice(bcd_in[11:8])
        .res_slice(added_slice_11_8)
    );

    restador #(.WIDTH(SLICE_WIDTH)) res_7_4(
        .slice(bcd_in[7:4])
        .res_slice(added_slice_7_4)
    );

    restador #(.WIDTH(SLICE_WIDTH)) res_3_0(
        .slice(bcd_in[3:0])
        .res_slice(added_slice_3_0)
    );

endmodule