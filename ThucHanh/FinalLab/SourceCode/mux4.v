module mux4 (
    input [n-1:0] d0,
    input [n-1:0] d1,
    input [n-1:0] d2,
    input [n-1:0] d3,
    input [1:0] s,
    output reg [n-1:0] y
);
    parameter n = 32;

    always @(*) begin
        case (s)
            2'b00: y <= d0;
            2'b01: y <= d1;
            2'b10: y <= d2;
            2'b11: y <= d3;
            default: y <= 0; // Giá trị mặc định để tránh hành vi không xác định
        endcase
    end
endmodule