module ALU_32bit(
	input wire [31:0] A, B,
	input wire M, S1, S0,
	output reg [31:0] result,
	output reg add_sub_overflow,
	output reg iszero
);

always @(*) begin
	case({M,S1,S0})
		3'b000: begin result = ~A;  add_sub_overflow = 0; end
		3'b001: begin result = A&B; add_sub_overflow = 0; end
		3'b010: begin result = A^B; add_sub_overflow = 0; end
		3'b011: begin result = A|B; add_sub_overflow = 0; end
		3'b100: begin result = A-1; add_sub_overflow = (~A[31] & B[31] & result[31]) | (A[31] & ~B[31] & ~result[31]); end
		3'b101: begin result = A+B; add_sub_overflow = (A[31] & B[31] & ~result[31]) | (~A[31] & ~B[31] & result[31]); end
		3'b110: begin result = A-B; add_sub_overflow = (~A[31] & B[31] & result[31]) | (A[31] & ~B[31] & ~result[31]); end
		3'b111: begin result = A+1; add_sub_overflow = (A[31] & B[31] & ~result[31]) | (~A[31] & ~B[31] & result[31]); end
		default: begin result = 32'h00000000; add_sub_overflow <= 0; end
	endcase
	
	iszero <= (result == 32'h00000000) ? 1'b1 : 1'b0;
end 
endmodule