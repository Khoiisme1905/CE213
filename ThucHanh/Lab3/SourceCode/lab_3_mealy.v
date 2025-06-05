module lab_3_mealy (
    input wire clk,
    input wire rst,
    input wire X,
    output reg Z,
	 output reg [1:0] S
);

    reg [1:0] cur_state, next_state;
    always @(posedge clk or posedge rst) begin
        if (rst)
            cur_state <= 2'b00;
        else
            cur_state <= next_state;
    end
    always @(*) begin
        case (cur_state)
            2'b00: begin
                next_state = (X == 1'b0) ? 2'b01 : 2'b00;
                Z = 1'b0;
					 S = cur_state;
            end
            2'b01: begin
                next_state = (X == 1'b1) ? 2'b10 : 2'b01;
                Z = 1'b0;
					 S = cur_state;
            end
            2'b10: begin
                next_state = (X == 1'b0) ? 2'b01 : 2'b00;
                Z = (X == 1'b0) ? 1'b1 : 1'b0;
					 S = cur_state;
            end
            default: begin
                next_state = 2'b00;
                Z = 1'b0;
					 S = cur_state;
            end
        endcase
    end

endmodule
