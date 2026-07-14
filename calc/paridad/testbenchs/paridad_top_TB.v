`timescale 1ns/1ps

module paridad_top_TB;

reg clk;
reg rst;
reg [7:0] par;

wire res;
wire done;

paridad_top #(.WIDTH(8)) instance1 (
.clk(clk),
.rst(rst),
.par(par),
.res(res),
.done(done)
);

initial clk = 0;
always #20 clk = ~clk;

initial begin
$dumpfile("paridad_top_TB.vcd");
$dumpvars(0, paridad_top_TB);

rst = 1;
par = 8'b00000000;
#40;
rst = 0;

@(negedge clk);
par = 8'b10101011; // debe dar 1

wait(done);

#100;
$finish;

end 

endmodule