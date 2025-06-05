module adder (
    input [n-1:0] a,
    input [n-1:0] b,
    output [n-1:0] y
);
    parameter n = 32;

    wire [n:0] w; // Wire để lưu carry, kích thước n+1
    assign w[0] = 0; // Carry vào ban đầu là 0

    genvar i;
    generate
        for (i = 0; i < n; i = i + 1) begin : adding
            FA FA_inst (
                .a(a[i]),
                .b(b[i]),
                .cin(w[i]),
                .cout(w[i + 1]),
                .s(y[i])
            );
        end
    endgenerate
endmodule