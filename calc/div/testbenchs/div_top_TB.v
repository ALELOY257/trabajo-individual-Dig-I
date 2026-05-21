`timescale 1ns / 1ps

module division_tb();

    parameter WIDTH = 8;
    parameter CLK_PERIOD = 10;

    reg clk, rst, init;
    reg [WIDTH-1:0] dividend_in, divisor_in;
    wire [WIDTH-1:0] res_out;
    wire done;

    divisor_top #(WIDTH) uut (
        .clk(clk), .rst(rst), .start(init),
        .dividend(dividend_in), .divisor(divisor_in),
        .res(res_out), .done(done)
    );

    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // Task: run one division and print result
    task run_test;
        input [WIDTH-1:0] dividend;
        input [WIDTH-1:0] divisor;
        input [WIDTH-1:0] expected;
        input integer test_num;
        begin
            // If done is still high from last run, wait for it to fall
            if (done) @(negedge done);

            dividend_in = dividend;
            divisor_in  = divisor;
            init = 1;
            #(CLK_PERIOD);
            init = 0;

            wait(done);
            $display("Test %0d: %0d / %0d | Result: %0d (Expected: %0d) %s",
                test_num, dividend, divisor, res_out, expected,
                (res_out == expected) ? "PASS" : "FAIL");
        end
    endtask

    initial begin
        $dumpfile("div_top_TB.vcd");
        $dumpvars(0, division_tb);

        rst = 1; init = 0;
        dividend_in = 0; divisor_in = 0;
        #(CLK_PERIOD * 2);
        rst = 0;
        #(CLK_PERIOD);

        run_test(8'd20,  8'd4,  8'd5,  1);
        run_test(8'd100, 8'd10, 8'd10, 2);
        run_test(8'd7,   8'd2,  8'd3,  3);

        #(CLK_PERIOD * 10);
        $finish;
    end

endmodule