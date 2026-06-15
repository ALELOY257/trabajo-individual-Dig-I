module mux #(parameter WIDTH=11)(
    input [1:0] sel_tim,
    input [WIDTH-1:0] T0H,
    input [WIDTH-1:0] T1H,
    input [WIDTH-1:0] RES,
    input [WIDTH-1:0] PER,
    output reg [WIDTH-1:0] s
);

always @(*) begin
    case (sel_tim)
        2'b00:   s = T0H;
        2'b01:   s = T1H;
        2'b10:   s = RES;
        2'b11:   s = PER;
        default: s = T0H;
    endcase
end

endmodule