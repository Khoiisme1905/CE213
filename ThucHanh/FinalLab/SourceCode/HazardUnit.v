module HazardUnit (
    input [4:0] Rs_ID, Rt_ID,      // Register addresses từ ID stage
    input [4:0] Rt_EX,             // Destination register từ EX stage  
    input MemRead_EX,              // Load instruction trong EX stage
    input Branch_ID, Jump_ID,      // Branch/Jump trong ID stage
    output reg Stall,              // Stall pipeline
    output reg PCWrite,            // Enable PC update
    output reg IF_IDWrite          // Enable IF/ID register update
);
    always @(*) begin
        // Load-use hazard detection
        if (MemRead_EX && 
            ((Rt_EX == Rs_ID) || (Rt_EX == Rt_ID)) &&
            (Rt_EX != 0)) begin
            Stall = 1'b1;
            PCWrite = 1'b0;
            IF_IDWrite = 1'b0;
        end
        else begin
            Stall = 1'b0;
            PCWrite = 1'b1;
            IF_IDWrite = 1'b1;
        end
    end
endmodule