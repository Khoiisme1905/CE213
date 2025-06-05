module MEM_WB_Register (
    input clk,
    input reset,
    // Control signals
    input RegWrite_in, MemtoReg_in,
    // Data signals
    input [31:0] ReadData_in,
    input [31:0] ALUResult_in,
    input [4:0] WriteReg_in,
    // Outputs
    output reg RegWrite_out, MemtoReg_out,
    output reg [31:0] ReadData_out,
    output reg [31:0] ALUResult_out,
    output reg [4:0] WriteReg_out
);
    always @(posedge clk) begin
        if (reset) begin
            RegWrite_out <= 1'b0;
            MemtoReg_out <= 1'b0;
            ReadData_out <= 32'b0;
            ALUResult_out <= 32'b0;
            WriteReg_out <= 5'b0;
        end
        else begin
            RegWrite_out <= RegWrite_in;
            MemtoReg_out <= MemtoReg_in;
            ReadData_out <= ReadData_in;
            ALUResult_out <= ALUResult_in;
            WriteReg_out <= WriteReg_in;
        end
    end
endmodule