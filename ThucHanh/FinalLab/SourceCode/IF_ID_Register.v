module IF_ID_Register (
    input clk,
    input reset,
    input stall,          // Để stall pipeline
    input flush,          // Để flush pipeline
    input [31:0] PC_in,
    input [31:0] Instr_in,
    output reg [31:0] PC_out,
    output reg [31:0] Instr_out
);
    always @(posedge clk) begin
        if (reset || flush) begin
            PC_out <= 32'b0;
            Instr_out <= 32'b0;
        end
        else if (!stall) begin
            PC_out <= PC_in;
            Instr_out <= Instr_in;
        end
        // Nếu stall=1, giữ nguyên giá trị cũ
    end
endmodule