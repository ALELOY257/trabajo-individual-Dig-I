module comp_helper #(parameter WIDTH=8)(
    input [WIDTH-1:0] helper_ca2;
    output reg v;
);
    always@(*)
        if (helper_ca2<0)
            v <= 1;
        else 
            v <= 0;

endmodule