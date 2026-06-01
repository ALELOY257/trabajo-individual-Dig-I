module bin2bcd_top #(parameter WIDTH=8)(
    input wire clk,
    input wire rst,
    input wire init,
    input wire [WIDTH_1:0] bcd_in,
    output wire [3:0] res,
    output wire done
);
    wire LD, SHIN, SHRES, DECC, replacing_bit;
    wire LD_2, LD_3, LD_4;
    wire v_1, v_2, v_3 ; 
    wire z;
    wire added_slice_11_8, added_slice_7_4, added_slice_3_0;

    wire bcd_in_msb,

    control_bin2bcd u_control(
        .clk(clk), .rst(rst), .init(init), .v(v), .z(z),
        .SHIN(SHIN), .SHRES(SHRES), .DECC(DECC), .replacing_bit(replacing_bit),
        .LD_1(LD), .LD_2(LD_2) , .LD_3(LD_3) , .LD_4(LD_4);
        .done(done)
    );

    bcd_in_reg #(.WIDTH(WIDTH)) u_bcd_in(
        .clk(clk), .rst(rst), .LD(LD), .SHIN(SHIN), .bcd_in(bcd_in),
        .bcd_in_msb(bcd_in_msb)
    );

    res_reg #(.WIDTH(WIDTH)) u_res_reg(
        .clk(clk), .rst(rst), .LD_1(LD), .LD_2(LD_2) , .LD_3(LD_3), .LD_4(LD_4) , .SHRES(SHRES), .replacing_bit(replacing_bit),
        .added_slice_11_8(added_slice_11_8), .added_slice_7_4(added_slice_7_4), .added_slice_3_0(added_slice_3_0),
        .res_out(res)
    );

    comp #(.WIDTH(WIDTH)) comp_11_8(
        .a(res[11:8]), .b(3'd5),
        .v(v_1)
    );

    comp #(.WIDTH(WIDTH)) comp_7_4(
        .a(res[7:4]), .b(3'd5),
        .v(v_2)
    );

    comp #(.WIDTH(WIDTH)) comp_3_0(
        .a(res[3:0]), .b(3'd5),
        .v(v_3)
    );

    sumador #(.WIDTH(WIDTH)) sum_11_8(
        .slice(res[11:8]), 
        .added_slice(added_slice_11_8)
    );

    sumador #(.WIDTH(WIDTH)) sum_7_4(
        .slice(res[7:4]),
        .added_slice(added_slice_7_4)
    );

    sumador #(.WIDTH(WIDTH)) sum_3_0(
        .slice(res[3:0]),
        .added_slice(added_slice_3_0)
    );

    contador #(.WIDTH(WIDTH))(
        .clk(clk), .rst(rst), .LD(LD), .DECC(DECC), .init_val(WIDTH),
        .z(z)
    );

endmodule