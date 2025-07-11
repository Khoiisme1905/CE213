module registerfile32 (
    input clk,
    input we,
    input reset,
    input [4:0] ra1,
    input [4:0] ra2,
    input [4:0] wa,
    input [31:0] wd,
    output [31:0] rd1,
    output [31:0] rd2
);
    reg [31:0] register [31:0];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            register[i] = 32'd0;
        end
    end

    always @(posedge clk) begin
        register[0] = 32'd0; // Thanh ghi 0 luôn là 0
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) register[i] = 32'd0;
        end
        else if (we && wa != 0) begin
            register[wa] = wd;
        end
    end

    assign rd1 = register[ra1];
    assign rd2 = register[ra2];
endmodule