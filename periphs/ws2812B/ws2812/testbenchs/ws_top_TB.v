`timescale 1ns / 1ps
`define SIMULATION

module ws_top_TB;
    // Inputs
    reg       clk;
    reg       reset;
    reg       init;
    reg [23:0] rgb;
    reg       rst_cmd;

    // Outputs
    wire      dout;
    wire      done;

    // Instantiate the Unit Under Test (UUT)
    ws_top uut(
        .clk(clk),
        .reset(reset),
        .init(init),
        .rst_cmd(rst_cmd),
        .rgb(rgb),
        .dout(dout),
        .done(done)
    );

    parameter PERIOD          = 20; // 50MHz clock
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;

    initial begin  // Process for clk
        #OFFSET;
        forever begin
            clk = 1'b0;
            #(PERIOD - (PERIOD * DUTY_CYCLE)) clk = 1'b1;
            #(PERIOD * DUTY_CYCLE);
        end
    end

   initial begin // Reset the system, Start the image capture process
        #0 reset = 1; rgb = 24'h112233; init = 0; rst_cmd = 0;
        @ (posedge clk);
        reset = 0;
        @ (posedge clk);

        // --- SEND DATA 1 ---
        init = 1;
        @ (posedge clk);
        init = 0;
        wait(uut.done == 1);

        // --- SEND DATA 2 ---
        repeat (4) @ (posedge clk);
        rgb = 24'hAA5588;
        rst_cmd = 0; // Ensure rst_cmd is low for data
        @ (posedge clk);
        init = 1;
        @ (posedge clk);
        init = 0;
        wait(uut.done == 1);

        // --- SEND RESET COMMAND ---
        repeat (4) @ (posedge clk);
        rgb = 24'hFF00FF; // RGB data doesn't matter for reset
        rst_cmd = 1;
        @ (posedge clk);
        init = 1;
        @ (posedge clk);
        init = 0;
        wait(uut.done == 1);

        $finish;
   end

   initial begin: TEST_CASE
     $dumpfile("ws_top_TB.vcd");
     $dumpvars(0, uut); // Use level 0 for dumping all signals in uut
     #(60000) $finish;
   end

endmodule