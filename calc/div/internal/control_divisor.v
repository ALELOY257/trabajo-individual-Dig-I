module control_mult(
    input clk,

    input rst,
    input done,
    input load,
    input decc,
    input shhe,
    input shres,
    input shdi,
    input ldhe,

    output reg done,
    output reg sh,
    output reg reset,
    output reg add,
);  
    parameter START = 3'b000;
    parameter HELPCOUNT = 3'b001;
    parameter SHIFTDIV = 3'b010;
    parameter CHECKRES = 3'b011;
    parameter CORR = 3'b100;
    parameter CHECKCOUNT = 3'b101
    parameter END = 3'b110;
endmodule