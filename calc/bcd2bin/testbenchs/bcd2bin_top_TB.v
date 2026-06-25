`timescale 1ns / 1ps

module bcd2bin_top_TB;

    // Parameters
    localparam WIDTH = 12;
    localparam CLK_PERIOD = 10;

    // Testbench signals
    reg clk;
    reg rst;
    reg init;
    reg [WIDTH-1:0] bcd_in;

    // DUT outputs
    wire [9:0] res;  // 10-bit binary output
    wire done;

    // Instantiate the Device Under Test (DUT)
    bcd2bin_top #(
        .WIDTH(WIDTH),
        .SLICE_WIDTH(4)
    ) uut (
        .clk(clk),
        .rst(rst),
        .init(init),
        .bcd_in(bcd_in),
        .res(res),
        .done(done)
    );

    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;

    // Simulation control
    initial begin
        // VCD dump setup
        $dumpfile("bcd2bin_top_TB.vcd");
        $dumpvars(0, bcd2bin_top_TB);

        // 1. Initial state
        clk = 0;
        rst = 1;
        init = 0;
        bcd_in = 0;
        #20;

        // 2. Release reset
        rst = 0;
        #20;

        // 3. Test case 1: Convert BCD 0x000 to binary 0
        // $display("Starting conversion for BCD 0x000 (expected binary 0)...");
        // bcd_in = 12'h000;
        // init = 1;
        // #CLK_PERIOD;
        // init = 0;

        // Wait for conversion to finish
        // wait (done);
        // $display("Conversion done. Binary result: %d (0x%h)", res, res); // Should be 0
        // #20;

        // 4. Test case 2: Convert BCD 0x123 to binary 123
        $display("Starting conversion for BCD 0x123 (expected binary 123)...");
        bcd_in = 12'h123;
        init = 1;
        #CLK_PERIOD;
        init = 0;
        #10;
        // Wait for conversion to finish
        wait (done);
        $display("Conversion done. Binary result: %d (0x%h)", res, res); // Should be 123
        #20;

        // 5. Test case 3: Convert BCD 0x255 to binary 255
        // $display("Starting conversion for BCD 0x255 (expected binary 255)...");
        // bcd_in = 12'h255;
        // init = 1;
        // #CLK_PERIOD;
        // init = 0;

        // // Wait for conversion to finish
        // wait (done);
        // $display("Conversion done. Binary result: %d (0x%h)", res, res); // Should be 255
        // #20;

        // 6. Test case 4: Convert BCD 0x999 to binary 999
        // $display("Starting conversion for BCD 0x999 (expected binary 999)...");
        // bcd_in = 12'h999;
        // init = 1;
        // #CLK_PERIOD;
        // init = 0;

        // // Wait for conversion to finish
        // wait (done);
        // $display("Conversion done. Binary result: %d (0x%h)", res, res); // Should be 999
        // #20;

        // 7. End simulation
        $display("Testbench finished.");
        $finish;
    end

endmodule