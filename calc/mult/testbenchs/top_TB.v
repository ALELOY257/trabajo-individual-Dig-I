`timescale 1ns/1ps

module top_TB;

reg clk;
reg init;
reg rst;
reg [3:0] A;
reg [3:0] B;

wire [7:0] res;
wire done;

top instance (.clk(clk), .rst(rst), .init(init),.A(A), .B(B), .pp(res), .done(done));

initial clk = 0;

initial begin
    $dumpfile("top_TB.v");
    #dumpvars(-1, top_TB);

    A=0;
    B=0;
    init=0;

    @(negedge clk);
    @(posedge clk);

    A=3;
    B=4;
    init=1;
    #20
    init=0;
    #20

    $finish;
end
endmodule



