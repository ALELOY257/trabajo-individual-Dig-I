module control_mult(
    input clk,

    input rst,
    input init,
    input v,
    input z,

    output reg replacing_bit;
    output reg LD,
    output reg DECC,
    output reg SHHE,
    output reg SHRES,
    output reg SHDI,
    output reg LDHE,
    output reg done
);  
    parameter START = 3'b000;
    parameter HELPCOUNT = 3'b001;
    parameter SHIFTDIV = 3'b010;
    parameter CHECKRES = 3'b011;
    parameter CORR1 = 3'b100;
    parameter CORR0 = 3'b101
    parameter CHECKCOUNT = 3'b110;
    parameter END = 3'b111;

    reg [2:0] state, next_state;
    reg [4:0] done_count;
    reg [8:0] count;

    always @(posedge clk) begin
        if (rst) begin
            state <= START;
            done_count <= 0;
        end
        else begin
            state <= next_state;

            if (state == END) 
                done_count <= done_count +1;
            else if (state == START)
                done_count <= 0;
        end
    end

    always @(*) begin
        next_state = state;
        
        replacing_bit;
        LD = 0;
        DECC =0;
        SHHE =0;
        SHRES=0;
        SHDI=0;
        LDHE=0;

        case (state)begin
            START: begin
                reset = 1;
                LD = 1; 
                if (init) 
                    next_state= HELPCOUNT;
            end
            HELPCOUNT: begin
                SHHE =1;
                DECC =1;
                // aclaracion pa mi, puse una se;al de replacing bit, pero en este caso no sera utilizada, la dinamica de lsbreplace la voy a hacer en top
                next_state=SHIFTDIV;
            end
            SHIFTDIV: begin
                SHDI =1;
                next_state = CHECKRES;
            end
            CHECKRES: begin
                if (v)
                    next_state = CORR0;
                else
                    next_state = CORR1;
            end
            CORR0: begin
                SHRES = 1;
                replacing_bit = 0;
                next_state = CHECKCOUNT;
            end
            CORR1: begin
                SHRES=1;
                replacing_bit=1;
                next_state=CHECKCOUNT;
            end
            CHECKCOUNT: begin
                if (z)
                    next_state = END;
                else
                    next_state = HELPCOUNT;
            end
            END: begin
                done = 1;
                if (done_count>28) next_state=START;
                else next_state=END;
            end

            default: next_state = START;
        endcase
    end
endmodule