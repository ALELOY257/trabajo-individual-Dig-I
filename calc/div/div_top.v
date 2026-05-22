module div_top (
    input clk,
    input rst,
    input init,
    input [DND_WIDTH-1:0] dividend,
    input [DSR_WIDTH-1:0] divisor,
    output [RES_WIDTH-1:0] res,
    output done
);
    parameter DND_WIDTH = 16;
    parameter DSR_WIDTH = 16;
    parameter RES_WIDTH = DND_WIDTH + DSR_WIDTH;

    wire helper;
    wire sh;

    lsb_replace #(.WIDTH(RES_WIDTH)) lsb_replace0(
        .clk(clk), .rst(rst), .shift()
    );

endmodule