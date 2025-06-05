`timescale 1ns/100ps

module MISP_tb;
   
    reg clk;
    reg reset;

    // Outputs để quan sát
    wire [31:0] PC;
    wire [31:0] Instr;
    wire [31:0] ReadData;
    wire [31:0] WriteData;
    wire [31:0] ALUResult;
    wire        ZeroFlag;

    // Instantiate the Unit Under Test (UUT)
    MISP uut (
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .Instr(Instr),
        .ReadData(ReadData),
        .WriteData(WriteData),
        .ALUResult(ALUResult),
        .ZeroFlag(ZeroFlag)
    );

    // Clock generation - 100ns period
    initial clk = 0;
    always #50 clk = ~clk;

    // Test sequence
    initial begin
        // Create VCD file for waveform viewing
        $dumpfile("misp_pipeline.vcd");
        $dumpvars(0, MISP_tb);

        // Display header
        $display("=== MIPS Pipeline Simulation ===");
        $display("Time\t PC\t\t Instr\t\t ALUResult\t ReadData");
        $display("----\t ----\t\t -----\t\t ---------\t --------");

        // Reset sequence
        reset = 1;
        #100;
        reset = 0;

        // Monitor signals during execution
        $monitor("%0t\t %h\t %h\t %h\t %h", 
                 $time, PC, Instr, ALUResult, ReadData);

        // Run for enough cycles to fill pipeline and execute instructions
        repeat (100) #100;

        // Display pipeline performance info
        $display("\n=== Pipeline Performance Analysis ===");
        $display("Total cycles simulated: 100");
        $display("Pipeline stages: 5");
        $display("Pipeline fill cycles: 4");
        $display("Effective instruction execution: ~95 cycles");
        $display("Theoretical speedup vs single-cycle: ~5x");

        $display("\nSimulation complete.");
        $stop;
    end

    // Pipeline stage monitoring
    always @(posedge clk) begin
        if (!reset) begin
            // Hiển thị thông tin từng stage (nếu có debug signals)
            $strobe("Cycle %0d: PC=%h, IF_ID=%h, ID_EX=%h, EX_MEM=%h, MEM_WB=%h",
                   ($time/100), PC, 
                   (uut.datapath.Instr_ID), 
                   (uut.datapath.PC_EX),
                   (uut.datapath.ALUResult_MEM),
                   (uut.datapath.Result_WB));
        end
    end

    // Error checking
    always @(posedge clk) begin
        if (!reset) begin
            // Kiểm tra basic sanity checks
            if (PC[1:0] != 2'b00) begin
                $display("ERROR: PC not word-aligned at time %0t", $time);
            end
        end
    end

endmodule