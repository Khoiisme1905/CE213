module mux2 (
    input [n-1:0] d0,
    input [n-1:0] d1,
    input s,
    output [n-1:0] y
);
    parameter n = 32;

    assign y = s ? d1 : d0;
endmodule