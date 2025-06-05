`timescale 1ns/100ps

module Top_tb;
  
    reg clk;
    reg reset;
    reg [15:0] gpioIn;
    
    // Outputs
    wire [15:0] gpioOut;
    wire pwmOut;

   
    wire [31:0] PC;
    wire [31:0] Instr;
    wire [31:0] MemAddr;
    wire [31:0] WriteData;
    wire [31:0] ReadData;
    wire MemRead, MemWrite;
    wire ZeroFlag;
    wire [31:0] ALUResult;

    wire [31:0] wb_adr_o, wb_dat_o, wb_dat_i;
    wire wb_we_o, wb_stb_o, wb_cyc_o, wb_ack_i;

    Top top_inst (
        .clk(clk),
        .reset(reset),
        .gpioIn(gpioIn),
        .gpioOut(gpioOut),
        .pwmOut(pwmOut)
    );

  
    assign PC = top_inst.misp_inst.PC;
    assign Instr = top_inst.misp_inst.Instr;
    assign MemAddr = top_inst.misp_inst.MemAddr;
    assign WriteData = top_inst.misp_inst.WriteData;
    assign ReadData = top_inst.misp_inst.ReadData;
    assign MemRead = top_inst.misp_inst.MemRead;
    assign MemWrite = top_inst.misp_inst.MemWrite;
    assign ZeroFlag = top_inst.misp_inst.ZeroFlag;
    assign ALUResult = top_inst.misp_inst.ALUResult;


    assign wb_adr_o = top_inst.wb_adr_o;
    assign wb_dat_o = top_inst.wb_dat_o;
    assign wb_dat_i = top_inst.wb_dat_i;
    assign wb_we_o = top_inst.wb_we_o;
    assign wb_stb_o = top_inst.wb_stb_o;
    assign wb_cyc_o = top_inst.wb_cyc_o;
    assign wb_ack_i = top_inst.wb_ack_i;


    initial begin
        clk = 0;
        forever #50 clk = ~clk;
    end


    initial begin
        // Create VCD file for waveform viewing
        $dumpfile("top_simulation.vcd");
        $dumpvars(0, Top_tb);

        // Display header
        $display("=== Top Module Simulation ===");
        $display("Time\tPC\t\tInstr\t\tMemAddr\t\tWriteData\tReadData\tMemR\tMemW\twb_adr_o\twb_dat_o\twb_we_o\twb_stb_o\twb_cyc_o\twb_ack_i\tgpioIn\tgpioOut\tpwmOut");
        $display("----\t----\t\t-----\t\t-------\t\t---------\t--------\t----\t----\t--------\t--------\t-------\t-------\t-------\t-------\t------\t-------\t------");


        reset = 1;
        gpioIn = 16'h1234;

        #100 reset = 0;

        // Test scenario
        #200; // Wait for pipeline to initialize
        // Test writing to gpioOut (0x00007f04)
        // Assume memfile.hex has instructions like:
        // lw $t0, 0($zero)       - Load from RAM (0x0000_0000)
        // sw $t0, 32516($zero)   - Store to gpioOut (0x00007f04)
        #400;
        // Test writing to PWM (0x00000710) with value 0x0080
        // Assume memfile.hex has instructions to write 0x0080 to PWM
        #400;
        // Test reading from gpioIn (0x0000_0100)
        gpioIn = 16'h5678; // Change gpioIn value
        #400;

        // Run for additional cycles to observe pipeline
        repeat (50) #100;

        // Display simulation summary
        $display("\n=== Simulation Summary ===");
        $display("GPIO Output value: %h", gpioOut);
        $display("PWM Output state: %b", pwmOut);
        $display("Total cycles: %0d", ($time/100));

        $display("\nSimulation complete.");
        $finish;
    end

    // Monitor signals at each positive clock edge
    always @(posedge clk) begin
        $display("%0t\t%h\t%h\t%h\t%h\t%h\t%b\t%b\t%h\t%h\t%b\t%b\t%b\t%b\t%h\t%h\t%b", 
                 $time, PC, Instr, MemAddr, WriteData, ReadData, MemRead, MemWrite, 
                 wb_adr_o, wb_dat_o, wb_we_o, wb_stb_o, wb_cyc_o, wb_ack_i, 
                 gpioIn, gpioOut, pwmOut);
    end

    // Error checking
    always @(posedge clk) begin
        if (!reset) begin
            // Check PC alignment
            if (PC[1:0] != 2'b00) begin
                $display("ERROR: PC not word-aligned at time %0t", $time);
            end
            // Check Wishbone write without valid slave
            if (MemWrite && !wb_stb_o) begin
                $display("ERROR: No Slave selected during write at time %0t", $time);
            end
        end
    end
endmodule