module ForwardingUnit (
    input [4:0] Rs_EX, Rt_EX,      // Source registers trong EX stage
    input [4:0] WriteReg_MEM,      // Destination register trong MEM stage
    input [4:0] WriteReg_WB,       // Destination register trong WB stage
    input RegWrite_MEM,            // RegWrite signal từ MEM stage
    input RegWrite_WB,             // RegWrite signal từ WB stage
    output reg [1:0] ForwardA,     // Forward control cho ALU input A
    output reg [1:0] ForwardB      // Forward control cho ALU input B
);
    always @(*) begin
        // Forwarding cho ALU input A
        if (RegWrite_MEM && (WriteReg_MEM != 0) && 
            (WriteReg_MEM == Rs_EX)) begin
            ForwardA = 2'b10; // Forward từ MEM stage
        end
        else if (RegWrite_WB && (WriteReg_WB != 0) && 
                 (WriteReg_WB == Rs_EX)) begin
            ForwardA = 2'b01; // Forward từ WB stage
        end
        else begin
            ForwardA = 2'b00; // Không forward
        end
        
        // Forwarding cho ALU input B
        if (RegWrite_MEM && (WriteReg_MEM != 0) && 
            (WriteReg_MEM == Rt_EX)) begin
            ForwardB = 2'b10; // Forward từ MEM stage
        end
        else if (RegWrite_WB && (WriteReg_WB != 0) && 
                 (WriteReg_WB == Rt_EX)) begin
            ForwardB = 2'b01; // Forward từ WB stage
        end
        else begin
            ForwardB = 2'b00; // Không forward
        end
    end
endmodule