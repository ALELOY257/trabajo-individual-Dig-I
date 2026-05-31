module bin2bcd_top #(parameter WIDTH=8)(
    input wire clk,
    input wire rst,
    input wire init,
    input wire [WIDTH_1:0] bcd_in,
    output wire [3:0] res,
    output wire done
);
    wire LD, SHIN, ADDRES, SHRES, DECC, replacing_bit;
    wire v_1, v_2, v_3 ; 
    wire z;

    wire bcd_in_msb,

    control_bin2bcd u_control(
        .clk(clk), .rst(rst), .init(init), .v(v), .z(z),
        .LD(LD), .SHIN(SHIN), .ADDRES(ADDRES), .SHRES(SHRES), .DECC(DECC), .replacing_bit(replacing_bit),
        .done(done)
    );

    bcd_in_reg #(.WIDTH(WIDTH)) bcd_in(
        .clk(clk), .rst(rst), .LD(LD), .SHIN(SHIN), .bcd_in(bcd_in),
        .bcd_in_msb(bcd_in_msb)
    );

    res_reg #(.WIDTH(WIDTH)) u_res_reg(
        .clk(clk), .rst(rst), .LD(LD), .SHRES(SHRES), .replacing_bit(replacing_bit),
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
        .clk(clk), .slice(res[11:8]), .add(ADDRES)
    );


endmodule