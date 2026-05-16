module control_mult(
    input clk,

    input rst,
    input done,
    input load,
    input decc,
    input shhe,
    input shres,

    parameter START = 3'b000;
    parameter HELPCOUNT = 3'b001;
    parameter CHECKRES = 3'b010;
    parameter CORR = 3'b011;
    parameter END = 3'b100;
);
endmodule