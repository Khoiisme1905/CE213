module flopr_param #(
    parameter n = 32 // Khai bao parameter truoc danh sach cong
) (
    input clk,        // Tin hieu clock
    input rst,        // Tin hieu reset
    output reg [n-1:0] q, // Dau ra q (n-bit)
    input [n-1:0] d   // Dau vao d (n-bit)
);

    always @(posedge clk) begin
        if (rst) begin
            q <= 0; // Reset active high: khi rst = 1, q = 0
        end else begin
            q <= d; // Khi rst = 0, q lay gia tri tu d
        end
    end

endmodule