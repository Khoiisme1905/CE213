module ram (
    input wire CLK_I,
    input wire RST_I,
    input wire [31:0] ADR_I,
    input wire [31:0] DAT_I,
    output reg [31:0] DAT_O,
    input wire WE_I,
    input wire [3:0] SEL_I,
    input wire STB_I,
    input wire CYC_I,
    output reg ACK_O
);
    reg [31:0] mem [0:63]; // Bộ nhớ 64 từ (256 byte)

    always @(posedge CLK_I or posedge RST_I) begin
        if (RST_I) begin
            ACK_O <= 0;
        end else if (CYC_I && STB_I) begin
            if (WE_I) begin
                // Ghi dữ liệu
                if (SEL_I[0]) mem[ADR_I[7:2]][7:0]   <= DAT_I[7:0];
                if (SEL_I[1]) mem[ADR_I[7:2]][15:8]  <= DAT_I[15:8];
                if (SEL_I[2]) mem[ADR_I[7:2]][23:16] <= DAT_I[23:16];
                if (SEL_I[3]) mem[ADR_I[7:2]][31:24] <= DAT_I[31:24];
            end else begin
                // Đọc dữ liệu
                DAT_O <= mem[ADR_I[7:2]];
            end
            ACK_O <= 1;
        end else begin
            ACK_O <= 0;
        end
    end
endmodule