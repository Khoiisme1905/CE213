module pwm (
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
    output reg pwmOut
);
    reg [31:0] pwm_reg; // Thanh ghi PWM

    always @(posedge CLK_I or posedge RST_I) begin
        if (RST_I) begin
            pwm_reg <= 32'b0;
            pwmOut <= 0;
            ACK_O <= 0;
        end else if (CYC_I && STB_I) begin
            if (WE_I) begin
                // Ghi vào thanh ghi PWM
                if (SEL_I[0]) pwm_reg[7:0]   <= DAT_I[7:0];
                if (SEL_I[1]) pwm_reg[15:8]  <= DAT_I[15:8];
                if (SEL_I[2]) pwm_reg[23:16] <= DAT_I[23:16];
                if (SEL_I[3]) pwm_reg[31:24] <= DAT_I[31:24];
                pwmOut <= |DAT_I; 
            end else begin
                // Đọc trạng thái PWM
                DAT_O <= pwm_reg;
            end
            ACK_O <= 1;
        end else begin
            ACK_O <= 0;
        end
    end
endmodule