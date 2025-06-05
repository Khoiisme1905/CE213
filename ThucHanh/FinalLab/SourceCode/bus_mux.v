module bus_mux (
    input [4:0] bSel,
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [31:0] in5,
    output reg [31:0] bData
);
    always @(*) begin
        case (bSel)
            5'b00001: bData = in1; // Memory (RAM)
            5'b00010: bData = in2; // GPIO Input
            5'b00100: bData = in3; // GPIO Output
            5'b01000: bData = in4; // PWM
            default: bData = in0;  // Default (no Slave selected)
        endcase
    end
endmodule