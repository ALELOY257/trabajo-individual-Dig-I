module div_top #(parameter WIDTH=8)(
    input clk,
    input rst,
    input init,
    input [WIDTH-1:0] dividend,
    input [WIDTH-1:0] divisor,
    output [RES_WIDTH-1:0] res,
    output done
);
    parameter RES_WIDTH = 2*WIDTH;

    wire replacing_bit, LD, DECC, SHHE, SHRES, SHDI, LDHE, SUBHE, v, z;
    wire [WIDTH-1:0]helper, ca2_res, dividend_wire;

    control_divisor control(
        .clk(clk), .init(init), .v(v), .z(z),
        .replacing_bit(replacing_bit), .LD(LD), .DECC(DECC), .SHHE(SHHE), .SHRES(SHRES), .SHDI(SHDI), .LDHE(LDHE), .done(done)
    );

    lsb_replace #(WIDTH) helper_reg1(
        .clk(clk), .rst(rst), .shift(SHHE), .replacing_value(dividend[0]),
        .generic_output(helper)
    );

    lsr #(WIDTH) dividend_shift(
        .clk(clk), .dividend(dividend), .load(LD), .shift(SHDI),
        .dividend_out(dividend_wire)
    );

    ca2_sub #(WIDTH) ca2sub(
        .divisor(divisor), .helper(helper),
        .ca2_res(ca2_res)
    );

    comp_helper #(WIDTH) helpercomparator(
        .reg_ca2(ca2_res),
        .v(v)
    );

    lsb_replace #(WIDTH) result_reg(
        .clk(clk), .rst(rst), .shift(SHRES), .replacing_value(replacing_bit),
        .generic_output(res) 
    );

    substractor #(WIDTH) helper_reg2(
        .clk(clk), .subhe(SUBHE),
        .helper_reg(helper)
    );

    counter #(WIDTH) endcounter(
        .clk(clk), .rst(rst), .dec(DECC), .load(LD), data_in(WIDTH[7:0]),
        .count_out(z)
    );


endmodule