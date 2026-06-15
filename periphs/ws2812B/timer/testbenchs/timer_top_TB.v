`timescale 1ns / 1ps
`define SIMULATION

module timer_top_TB;

    // Inputs
    reg        clk;
    reg        reset;
    reg        init_t;
    reg [1:0]  sel;

    // Outputs
    wire       dout;
    wire       done_t;
    wire [1:0] sel_tim;
    wire       inc;
    wire       rst;

    timer_top uut (
        .clk(clk),
        .reset(reset),
        .init_t(init_t),
        .sel(sel),
        .dout(dout),
        .done_t(done_t),
        .sel_tim(sel_tim),
        .inc(inc),
        .rst(rst)
    );

    parameter PERIOD          = 20; // 50 MHz clock
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;

    initial begin // Process for clk
        #OFFSET;
        forever begin
            clk = 1'b0;
            #(PERIOD - (PERIOD * DUTY_CYCLE)) clk = 1'b1;
            #(PERIOD * DUTY_CYCLE);
        end
    end

    initial begin
        // Initialize Inputs
        #0 reset = 1; init_t = 0; sel = 0;
        @ (negedge clk);
        reset  = 0;
        @ (negedge clk);

        // --- TEST CASE 1: SEND ZERO ---
        sel    = 2'b00;
        init_t = 1;
        @ (negedge clk);
        init_t = 0;
        wait(uut.done_t == 1);
        @ (negedge clk);

        // --- TEST CASE 2: SEND ONE ---
        @ (negedge clk);
        sel    = 2'b01;
        init_t = 1;
        @ (negedge clk);
        init_t = 0;
        wait(uut.done_t == 1);
        @ (negedge clk);

        // --- TEST CASE 3: SEND ANOTHER ONE ---
        @ (negedge clk);
        sel    = 2'b01;
        init_t = 1;
        @ (negedge clk);
        init_t = 0;
        wait(uut.done_t == 1);
        @ (negedge clk);

        // --- TEST CASE 4: SEND RESET ---
        @ (negedge clk);
        sel    = 2'b10; // sel = 2
        init_t = 1;
        @ (negedge clk);
        init_t = 0;
        wait(uut.done_t == 1);
        @ (negedge clk);

        $finish; // End simulation after tests
    end

    initial begin: TEST_CASE
        $dumpfile("timer_top_TB.vcd");
        $dumpvars(0, uut); // Dump all signals in the UUT
        #(200000) $finish; // Increased timeout
    end

endmodule