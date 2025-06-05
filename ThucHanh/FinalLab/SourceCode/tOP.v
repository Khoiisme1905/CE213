module Top (
    input clk,
    input reset,
    input [15:0] gpioIn,
    output [15:0] gpioOut,
    output pwmOut
);
    // Wires for MISP
    wire [31:0] PC, Instr, ReadData, WriteData, ALUResult, MemAddr;
    wire ZeroFlag;
    wire MemRead, MemWrite;

    // Wishbone bus signals
    wire [31:0] wb_adr_o, wb_dat_o, wb_dat_i;
    wire [3:0] wb_sel_o;
    wire wb_we_o, wb_stb_o, wb_cyc_o, wb_ack_i;
    wire [31:0] gpio_in_data, gpio_out_data, pwm_data;
    wire gpio_in_ack, gpio_out_ack, pwm_ack;

    MISP misp_inst (
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .Instr(Instr),
        .ReadData(ReadData),
        .WriteData(WriteData),
        .ALUResult(ALUResult),
        .ZeroFlag(ZeroFlag)
    );

    // Wishbone Bus instance
    bus bus_inst (
        .clk(clk),
        .reset(reset),
        .cpu_addr(ALUResult),     
        .cpu_data_write(WriteData),
        .cpu_read(MemRead),
        .cpu_write(MemWrite),
        .cpu_data_read(ReadData),
        .ADR_O(wb_adr_o),
        .DAT_O(wb_dat_o),
        .DAT_I(wb_dat_i),
        .WE_O(wb_we_o),
        .SEL_O(wb_sel_o),
        .STB_O(wb_stb_o),
        .CYC_O(wb_cyc_o),
        .ACK_I(wb_ack_i)
    );

    // GPIO instance
    gpio gpio_inst (
        .CLK_I(clk),
        .RST_I(reset),
        .ADR_I(wb_adr_o),
        .DAT_I(wb_dat_o),
        .DAT_O(gpio_in_data),
        .WE_I(wb_we_o),
        .SEL_I(wb_sel_o),
        .STB_I(wb_stb_o && (wb_adr_o[31:8] == 24'h000001 || wb_adr_o[31:8] == 24'h000002)),
        .CYC_I(wb_cyc_o),
        .ACK_O(gpio_in_ack),
        .gpioIn(gpioIn),
        .gpioOut(gpioOut)
    );

    assign gpio_out_data = {16'b0, gpioOut};
    assign gpio_out_ack = wb_stb_o && (wb_adr_o[31:8] == 24'h000002) && wb_cyc_o && wb_we_o;

    // PWM instance
    pwm pwm_inst (
        .CLK_I(clk),
        .RST_I(reset),
        .ADR_I(wb_adr_o),
        .DAT_I(wb_dat_o),
        .DAT_O(pwm_data),
        .WE_I(wb_we_o),
        .SEL_I(wb_sel_o),
        .STB_I(wb_stb_o && (wb_adr_o[31:8] == 24'h000003)),
        .CYC_I(wb_cyc_o),
        .ACK_O(pwm_ack),
        .pwmOut(pwmOut)
    );

   
    assign wb_dat_i = gpio_in_ack ? gpio_in_data :
                      gpio_out_ack ? gpio_out_data :
                      pwm_ack ? pwm_data : ReadData; 

    assign wb_ack_i = gpio_in_ack | gpio_out_ack | pwm_ack;

endmodule