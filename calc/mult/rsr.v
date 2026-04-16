module rsr (
    input clk,
    input [4:0]in_B, 
    input shift, 
    input load, 
    output reg [4:0]s_B
    );

    always @(negedge clk)begin
        if (load)
            s_B = in_B;
        else begin
            if (shift)
                s_B <= s_B >> 1;
            else
                s_B <= s_B
        end
    end

endmodule
