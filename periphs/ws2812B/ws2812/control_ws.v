module control_ws(
    input clk,
    input reset,
    input init,
    input done_t,
    input z,
    output reg SH,
    output reg INIT_T,
    output reg DEC,
    output reg LD,
    output reg DONE
);
    // 7 estados
    parameter START = 3'b000;
    parameter CHECKRGB = 3'b001;
    parameter SEND = 3'b010;
    parameter CHECKTIMER = 3'b011;
    parameter COUNTSHIFT = 3'b100;
    parameter CHECKCOUNT = 3'b101;
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
                if (init)
                    next_state = CHECKRGB;
                else 
                    next_state = START;
            end

            CHECKRGB: begin
                next_state = SEND;
            end

            SEND: begin
                next_state = CHECKTIMER;
            end

            CHECKTIMER: begin
                if (done_t) next_state = COUNTSHIFT;
                else next_state = CHECKTIMER;
            end

            COUNTSHIFT: begin
                next_state = CHECKCOUNT;
            end

            CHECKCOUNT: begin
                if (z) next_state = FINISH;
                else next_state = CHECKRGB;
            end

            FINISH: begin
                next_state = START;
            end

            default: next_state = START;
        endcase
    end

    always @(*) begin
        SH =0;
        INIT_T = 0;
        DEC = 0;
        LD = 0;
        DONE = 0;
        case (current_state)
            START: begin
                LD=1;
            end

            CHECKRGB: begin
                INIT_T=1;
            end

            SEND: begin
                
            end

            CHECKTIMER: begin
                
            end

            COUNTSHIFT: begin
                SH=1;
                DEC=1;
            end

            CHECKCOUNT: begin
                
            end

            FINISH: begin
                DONE=1;
            end
        endcase
    end
endmodule