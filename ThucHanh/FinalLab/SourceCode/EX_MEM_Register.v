module EX_MEM_Register (
    input clk,
    input reset,
    // Control signals
    input RegWrite_in, MemtoReg_in, MemWrite_in, Branch_in,
    // Data signals
    input [31:0] BranchTarget_in,
    input [31:0] ALUResult_in,
    input [31:0] WriteData_in,
    input [4:0] WriteReg_in,
    input Zero_in,
    // Outputs
    output reg RegWrite_out, MemtoReg_out, MemWrite_out, Branch_out,
    output reg [31:0] BranchTarget_out,
    output reg [31:0] ALUResult_out,
    output reg [31:0] WriteData_out,
    output reg [4:0] WriteReg_out,
    output reg Zero_out
);
    always @(posedge clk) begin
        if (reset) begin
            RegWrite_out <= 1'b0;
            MemtoReg_out <= 1'b0;
            MemWrite_out <= 1'b0;
            Branch_out <= 1'b0;
            BranchTarget_out <= 32'b0;
            ALUResult_out <= 32'b0;
            WriteData_out <= 32'b0;
            WriteReg_out <= 5'b0;
            Zero_out <= 1'b0;
        end
        else begin
            RegWrite_out <= RegWrite_in;
            MemtoReg_out <= MemtoReg_in;
            MemWrite_out <= MemWrite_in;
            Branch_out <= Branch_in;
            BranchTarget_out <= BranchTarget_in;
            ALUResult_out <= ALUResult_in;
            WriteData_out <= WriteData_in;
            WriteReg_out <= WriteReg_in;
            Zero_out <= Zero_in;
        end
    end
endmodule