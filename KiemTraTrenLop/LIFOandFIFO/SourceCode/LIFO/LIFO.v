module LIFO (
    input wire clk,          // Clock signal
    input wire rst,          // Reset signal
    input wire w_en,         // Write (push) enable
    input wire r_en,         // Read (pop) enable
    input wire [31:0] data_in,  // Data input
    output reg [31:0] data_out, // Data output
    output wire full,        // Stack full indicator
    output wire empty        // Stack empty indicator
);

// Memory array declaration
reg [31:0] stack_mem [31:0]; // 32x32 memory array (depth=32, width=32)

// Stack pointer declaration (6-bit to handle 0-32 states)
reg [5:0] sp;                // Points to next available space

// Status flags assignments
assign full = (sp == 6'd32); // Full when pointer reaches 32
assign empty = (sp == 6'd0); // Empty when pointer is 0

// Stack control logic
always @(posedge clk) begin
    if (rst) begin           // Synchronous reset
        sp <= 6'd0;
        data_out <= 32'bz;   // High-impedance when reset
    end
    else begin
        // Push operation (highest priority)
        if (w_en && !full) begin
            stack_mem[sp] <= data_in;  // Store data at current pointer
            sp <= sp + 1;             // Increment stack pointer
        end
        
        // Pop operation (only if not pushing)
        else if (r_en && !empty) begin
            sp <= sp - 1;             // Decrement pointer first
            data_out <= stack_mem[sp - 1]; // Read previous top element
        end
        
        // Maintain output when no operations
        else begin
            data_out <= data_out;     // Keep previous value
        end
    end
end

endmodule