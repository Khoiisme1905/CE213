module gpio (
    input wire CLK_I,
    input wire RST_I,
    input wire [31:0] ADR_I,
    input wire [31:0] DAT_I,
    output reg [31:0] DAT_O,
    input wire WE_I,
    input wire [3:0] SEL_I,
    input wire STB_I,
    input wire CYC_I,
    output reg ACK_O,
    input wire [15:0] gpioIn,
    output reg [15:0] gpioOut
);
    always @(posedge CLK_I or posedge RST_I) begin
        if (RST_I) begin
            gpioOut <= 16'b0;
            ACK_O <= 0;
        end else if (CYC_I && STB_I) begin
            if (WE_I && (ADR_I[31:8] == 24'h000002)) begin
                // Ghi vào gpioOut
                if (SEL_I[0]) gpioOut[7:0]  <= DAT_I[7:0];
                if (SEL_I[1]) gpioOut[15:8] <= DAT_I[15:8];
            end else if (!WE_I && (ADR_I[31:8] == 24'h000001)) begin
                // Đọc từ gpioIn
                DAT_O <= {16'b0, gpioIn};
            end
            ACK_O <= 1;
        end else begin
            ACK_O <= 0;
        end
    end
endmodule