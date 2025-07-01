module FIFO (
    input wire clk,          // Clock signal
    input wire rst,          // Reset signal
    input wire w_en,         // Write enable
    input wire r_en,         // Read enable
    input wire [31:0] data_in,  // Data input
    output reg [31:0] data_out, // Data output
    output wire full,        // FIFO full indicator
    output wire empty        // FIFO empty indicator
);

// Register file declaration
reg [31:0] reg_file [31:0];  // 32x32 memory array

// Pointer declarations
reg [4:0] wr_ptr;            // Write pointer (5-bit for 0-31)
reg [4:0] r_ptr;             // Read pointer (5-bit for 0-31)

// Status flags assignments
assign full = (wr_ptr == 31); // Full when write pointer reaches 31
assign empty = (wr_ptr == r_ptr); // Empty when pointers are equal

// FIFO control logic
always @(posedge clk) begin
    if (rst) begin           // Synchronous reset
        wr_ptr <= 5'b0;
        r_ptr <= 5'b0;
        data_out <= 32'bz;   // High-impedance when reset
    end
    else begin
        // Write operation
        if (w_en && !full) begin
            reg_file[wr_ptr] <= data_in;  
            wr_ptr <= wr_ptr + 1;
        end
        
        // Read operation
        if (r_en && !empty) begin
            data_out <= reg_file[r_ptr];  // Output data
            r_ptr <= r_ptr + 1;           // Increment read pointer
        end
    end
end

endmodule