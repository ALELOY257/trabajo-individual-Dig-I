`timescale 1ns / 1ps

module div_top_tb;

    reg clk;
    reg rst;
    reg init;
    reg [7:0] dividend;
    reg [7:0] divisor;

    wire [15:0] res;
    wire done;

    div_top #(.WIDTH(8)) uut (
        .clk(clk),
        .rst(rst),
        .init(init),
        .dividend(dividend),
        .divisor(divisor),
        .res(res),
        .done(done)
    );

    always begin
        #10 clk = ~clk;
    end

    initial begin
        $dumpfile("div_top_TB.vcd");
        $dumpvars(0, div_top_tb);

        clk = 0;
        rst = 1;
        init = 0;
        dividend = 0;
        divisor = 0;

        #40;
        rst = 0;
        #20;

        // ---------------------------------------------------------
        // TEST CASE 1: 8 / 3 
        // ---------------------------------------------------------
        $display("[TB] Starting Test Case 1: 8 / 3");
        dividend = 8'd8;
        divisor  = 8'd3;
        init     = 1;     
        #20;
        init     = 0;

        wait(done == 1);
        $display("[TB] Test Case 1 Finished! Result (Quotient) = %d", res);
        
        #100; 

        // ---------------------------------------------------------
        // TEST CASE 2: 45 / 5
        // ---------------------------------------------------------
        $display("[TB] Starting Test Case 2: 45 / 5");
        dividend = 8'd45;
        divisor  = 8'd5;
        init     = 1;
        #20;
        init     = 0;

        wait(done == 1);
        $display("[TB] Test Case 2 Finished! Result (Quotient) = %d", res);
        
        #100;

        // ---------------------------------------------------------
        // TEST CASE 3: 255 / 10 
        // ---------------------------------------------------------
        $display("[TB] Starting Test Case 3: 255 / 10");
        dividend = 8'd255;
        divisor  = 8'd10;
        init     = 1;
        #20;
        init     = 0;

        wait(done == 1);
        $display("[TB] Test Case 3 Finished! Result (Quotient) = %d", res);


        #200;
        $display("[TB] All tests completed.");
        $finish;
    end

endmodule