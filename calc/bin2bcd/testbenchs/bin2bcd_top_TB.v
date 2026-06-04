`timescale 1ns / 1ps

module bin2bcd_top_TB;

    // Parameters
    localparam WIDTH = 8;
    localparam CLK_PERIOD = 10;

    // Testbench signals
    reg clk;
    reg rst;
    reg init;
    reg [WIDTH-1:0] bcd_in;

    // DUT outputs
    wire [11:0] res; // 3 BCD digits = 12 bits
    wire done;

    // Instantiate the Device Under Test (DUT)
    bin2bcd_top #(
        .WIDTH(WIDTH)
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
        $dumpfile("bin2bcd_top_TB.vcd");
        $dumpvars(0, bin2bcd_top_TB);

        // 1. Initial state
        clk = 0;
        rst = 1;
        init = 0;
        bcd_in = 0;
        #20;

        // 2. Release reset
        rst = 0;
        #20;

        // 3. Test case 1: Convert 255
        // $display("Starting conversion for 255 (11111111)...");
        // bcd_in = 8'd255;
        // init = 1;
        // #CLK_PERIOD;
        // init = 0;
        $display("Starting conversion for 97 (01100001)...");
        bcd_in = 8'd97;
        init = 1;
        #CLK_PERIOD;
        init = 0;

        // Wait for conversion to finish
        wait (done);
        $display("Conversion done. BCD result: %h", res); // Should be 0x255
        #20;

        // 4. Test case 2: Convert 97
        $display("Starting conversion for 97 (01100001)...");
        bcd_in = 8'd97;
        init = 1;
        #CLK_PERIOD;
        init = 0;

        // Wait for conversion to finish
        wait (done);
        $display("Conversion done. BCD result: %h", res); // Should be 0x097
        #20;

        // 5. End simulation
        $display("Testbench finished.");
        $finish;
    end

endmodule