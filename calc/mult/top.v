module top(
    input clk,
    input rst, 
    input init, 
    input [3:0]A, 
    input [15:0]B, 
    output [3:0]pp, 
    output done
    );
    wire w_shift;
    wire w_reset;
    wire w_add;
    wire w_z;
    wire [3:0]w_A;
    wire [3:0]w_B;

    acc acc_instance(clk, w_A, w_add, w_reset, pp);
    comp comp_instance(w_B, w_z);
    rsr rsr_instance(clk, B, w_shift, w_reset, w_B);
    lsr lsr_instance(clk, A, w_shift, w_reset, w_A);
    control_mult cm_instance(clk, rst, w_B[0], init, w_z, done, w_shift, w_reset, w_add);
    
    
    endmodule