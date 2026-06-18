`timescale 1ns / 1ps
`define SIMULATION

module ws_array_top_TB;
    // Inputs
    reg       clk;
    reg       reset;
    reg       init_m;
    reg       rst_cmd;

    // Outputs
    wire      dout;
    wire      done_m;

    // Instantiate the Unit Under Test (UUT)
    // Make sure to set the N_LEDS parameter to match your test
    ws_array_top #(.N_LEDS(2**8)) uut (
        .clk(clk),
        .reset(reset),
        .init_m(init_m),
        .rst_cmd(rst_cmd),
        .dout(dout),
        .done_m(done_m)
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

   initial begin // Main stimulus
        // 1. Reset the system
        #0 reset = 1; init_m = 0; rst_cmd = 0;
        @ (posedge clk);
        reset = 0;
        @ (posedge clk);

        // 2. Start the process to send data to all LEDs
        init_m = 1;
        @ (posedge clk);
        init_m = 0;

        // 3. Wait for the controller to signal it's done
        wait(uut.done_m == 1);
        @ (posedge clk);

        // 4. Send the final reset command to latch the colors
        rst_cmd = 1;
        init_m = 1; // The timer needs an init pulse
        @ (posedge clk);
        rst_cmd = 0;
        init_m = 0;
        // You might need to wait for a final 'done' from the timer here
        // depending on the exact behavior you want.

        @ (posedge clk);
        $finish;
   end

   initial begin: TEST_CASE
     $dumpfile("ws_array_top_TB.vcd");
     $dumpvars(0, uut);
     #(10000000) $finish; // 10ms timeout, should be plenty
   end

endmodule