module decoder4 (
    input [3:0] a,
    output reg [15:0] y
);
    always @(*) begin
        // Dùng phép dịch bit để giải mã: y = 1 << a
        y = (a < 4'd16) ? (16'b1 << a) : 16'b0; // Nếu a >= 16, y = 0
    end
endmodule