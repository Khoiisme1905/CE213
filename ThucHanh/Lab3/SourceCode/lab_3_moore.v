module lab_3_moore(
    input wire clk,
    input wire rst,
    input wire X,
    output reg Z
);
	
	reg[1:0]	cur_state, next_state;
	
	always @(posedge clk or posedge rst) begin
		if (rst)
			cur_state <= 2'b00;
		else
			cur_state <= next_state;
	end

	always @(*) begin
		case (cur_state)
			2'b00: next_state = (X == 1'b0) ? 2'b01 : 2'b00;
			2'b01: next_state = (X == 1'b1) ? 2'b10 : 2'b01;
			2'b10: next_state = (X == 1'b0) ? 2'b11 : 2'b00;
			2'b11: next_state = (X == 1'b0) ? 2'b01 : 2'b10;
			default: next_state = 2'b00;
		endcase
	end

	always @(*) begin
		Z = (cur_state == 2'b11) ? 1'b1 : 1'b0;
	end

endmodule
