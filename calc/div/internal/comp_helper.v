module comp_helper #(parameter WIDTH=8)(
    input [WIDTH-1:0] reg_ca2;
    output reg v;
);
    always@(*)
        if (reg_ca2<0)
            v <= 1;
        else 
            v <= 0;

endmodule