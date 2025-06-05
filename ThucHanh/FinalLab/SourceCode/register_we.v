module register_we #(
    parameter DATA_WIDTH = 16
) (
    input clk,
    input rst,
    input n,
    input we,
    input [DATA_WIDTH-1:0] d,
    output reg [DATA_WIDTH-1:0] q
);
    always @(posedge clk or negedge rst) begin
        if (!rst) q <= 0;
        else if (we) q <= d;
    end
endmodule