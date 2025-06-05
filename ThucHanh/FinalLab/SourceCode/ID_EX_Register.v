module ID_EX_Register (
    input clk,
    input reset,
    input flush,
    // Control signals
    input RegWrite_in, MemtoReg_in, MemWrite_in,
    input ALUSrc_in, RegDst_in, Branch_in, Jump_in,
    input [3:0] ALUControl_in,
    // Data signals
    input [31:0] PC_in,
    input [31:0] ReadData1_in, ReadData2_in,
    input [31:0] SignImm_in,
    input [4:0] Rs_in, Rt_in, Rd_in,
    input [4:0] Shamt_in,
    // Outputs
    output reg RegWrite_out, MemtoReg_out, MemWrite_out,
    output reg ALUSrc_out, RegDst_out, Branch_out, Jump_out,
    output reg [3:0] ALUControl_out,
    output reg [31:0] PC_out,
    output reg [31:0] ReadData1_out, ReadData2_out,
    output reg [31:0] SignImm_out,
    output reg [4:0] Rs_out, Rt_out, Rd_out,
    output reg [4:0] Shamt_out
);
    always @(posedge clk) begin
        if (reset || flush) begin
            RegWrite_out <= 1'b0;
            MemtoReg_out <= 1'b0;
            MemWrite_out <= 1'b0;
            ALUSrc_out <= 1'b0;
            RegDst_out <= 1'b0;
            Branch_out <= 1'b0;
            Jump_out <= 1'b0;
            ALUControl_out <= 4'b0;
            PC_out <= 32'b0;
            ReadData1_out <= 32'b0;
            ReadData2_out <= 32'b0;
            SignImm_out <= 32'b0;
            Rs_out <= 5'b0;
            Rt_out <= 5'b0;
            Rd_out <= 5'b0;
            Shamt_out <= 5'b0;
        end
        else begin
            RegWrite_out <= RegWrite_in;
            MemtoReg_out <= MemtoReg_in;
            MemWrite_out <= MemWrite_in;
            ALUSrc_out <= ALUSrc_in;
            RegDst_out <= RegDst_in;
            Branch_out <= Branch_in;
            Jump_out <= Jump_in;
            ALUControl_out <= ALUControl_in;
            PC_out <= PC_in;
            ReadData1_out <= ReadData1_in;
            ReadData2_out <= ReadData2_in;
            SignImm_out <= SignImm_in;
            Rs_out <= Rs_in;
            Rt_out <= Rt_in;
            Rd_out <= Rd_in;
            Shamt_out <= Shamt_in;
        end
    end
endmodule