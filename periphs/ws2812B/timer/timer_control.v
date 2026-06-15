module control_timer(
    input clk,
    input reset,
    input init_t,
    input [1:0]sel,
    input z,

    output reg dout,
    output reg done_t,
    output reg rst,
    output reg inc,
    output reg [1:0]sel_tim
);
// tengo 11 estados (por ahora jaja)
    parameter START = 4'b0000;
    parameter CHECKSEL = 4'b0001;
    parameter TH0ACT = 4'b0010;
    parameter TH1ACT = 4'b0011;
    parameter RESACT = 4'b0100;
    parameter DOUT1COUNT = 4'b0101;
    parameter CHECKCOUNTOUT = 4'b0111;
    parameter ACTDOUTCOUNT = 4'b1000;
    parameter CHECKCOUNTOUTPER = 4'b1001;
    parameter CHECKCOUNTOUTRES = 4'b1010;
    parameter FINISH = 4'b1011;

    reg [3:0] current_state, next_state;

    always @(posedge clk) begin
        if (reset) 
            current_state <= START;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            START: begin
                if (init_t)
                    next_state = CHECKSEL;
                else
                    next_state = START;
            end

            CHECKSEL: begin
                case(sel)
                    2'b00: next_state = TH0ACT;
                    2'b01: next_state = TH1ACT;
                    2'b10: next_state = RESACT;
                    2'b11: next_state = RESACT;
                    default: next_state = TH0ACT;
                endcase
            end
            // rama izq del diagrama - sends data
            TH0ACT: begin
                next_state = DOUT1COUNT;
            end

            TH1ACT: begin
                next_state = DOUT1COUNT;
            end

            DOUT1COUNT: begin
                next_state = CHECKCOUNTOUT;
            end

            CHECKCOUNTOUT: begin
                if (z) next_state = ACTDOUTCOUNT;
                else next_state = DOUT1COUNT;
            end

            ACTDOUTCOUNT: begin 
                next_state = CHECKCOUNTOUTPER;
            end

            CHECKCOUNTOUTPER: begin
                if (z) next_state = FINISH;
                else next_state = ACTDOUTCOUNT;
            end
            // rama der del diagrama - doesnt send data
            RESACT: begin
                next_state = CHECKCOUNTOUTRES;
            end

            CHECKCOUNTOUTRES: begin
                if (z) next_state = FINISH;
                else next_state = RESACT;
            end

            FINISH: begin
                next_state = START;
            end

            default: next_state = START;
        endcase
    end

    always @(*) begin
        dout = 0;
        done_t = 0;
        rst = 0;
        inc = 0;
        sel_tim =0;
        case (current_state)
            START: begin
                rst = 1;
            end 

            CHECKSEL: begin

            end
            // rama izq del diagrama - sends data
            TH0ACT: begin
                sel_tim=0;
            end

            TH1ACT: begin
                sel_tim=1;
            end

            DOUT1COUNT: begin
                dout=1;
                inc=1;
            end

            CHECKCOUNTOUT: begin
                
            end

            ACTDOUTCOUNT: begin 
                inc=1;
                sel_tim=3;
            end

            CHECKCOUNTOUTPER: begin
            end
            // rama der del diagrama - doesnt send data
            RESACT: begin
                inc=1;
                sel_tim=2;
            end

            CHECKCOUNTOUTRES: begin
                
            end

            FINISH: begin
                done_t=1;
            end
        endcase
    end


endmodule