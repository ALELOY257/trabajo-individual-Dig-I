module control_ws_array(
    input clk,
    input reset,
    input init_m,
    input done_led, 
    input z,
    output reg done,
    output reg init_led,
    output reg rst,
    output reg inc
);

    // 7 estadis
    parameter START = 3'b000;
    parameter LEDUP = 3'b001;
    parameter LEDDOWN = 3'b010;
    parameter CHECKLED = 3'b011;
    parameter ADDRPLUS = 3'b100;
    parameter CHECKADDR = 3'b101;
    parameter FINISH = 3'b110;

    reg [2:0] current_state, next_state;

    always @(posedge clk) begin
        if (reset)
            current_state <= START;
        else 
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            START: begin
                if(init_m)
                    next_state = LEDUP;
                else
                    next_state = START;
            end

            LEDUP: begin
                next_state = LEDDOWN;
            end

            LEDDOWN: begin
                next_state = CHECKLED;
            end

            CHECKLED: begin
                if (done_led)
                    next_state = ADDRPLUS;
                else
                    next_state = CHECKLED;
            end

            ADDRPLUS: begin
                next_state = CHECKADDR;
            end

            CHECKADDR: begin
                if (z)
                    next_state = FINISH;
                else
                    next_state = LEDUP;
            end

            FINISH: begin
                next_state = START;
            end

            default: next_state = START;
        endcase
    end

    always @(*) begin
        done = 0;
        init_led = 0;
        rst = 0;
        inc =0;
        case (current_state)
            START: begin
                rst =1 ;
            end

            LEDUP: begin
                init_led = 1;
            end

            LEDDOWN: begin
                
            end

            CHECKLED: begin
                
            end

            ADDRPLUS: begin
                inc=1;
            end

            CHECKADDR: begin
            end

            FINISH: begin
                
            end
        endcase
    end

endmodule