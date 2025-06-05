module bus_decoder (
    input [31:0] cpu_addr,
    output [4:0] bSel
);
    // Logic decode address to select slave
    assign bSel = (cpu_addr[15:0] >= 16'h0000 && cpu_addr[15:0] <= 16'h3FFF) ? 5'b00001 : // RAM (0x0000 - 0x3FFF)
                  (cpu_addr[15:0] == 16'h7F00) ? 5'b00010 : // GPIO Input
                  (cpu_addr[15:0] == 16'h7F04) ? 5'b00100 : // GPIO Output
                  (cpu_addr[15:0] == 16'h0710) ? 5'b01000 : // PWM
                  5'b00000; // Default (no slave)
endmodule