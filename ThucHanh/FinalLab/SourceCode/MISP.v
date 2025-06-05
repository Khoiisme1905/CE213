module MISP(
    input           clk,
    input           reset,
    output [31:0]   PC,
    output [31:0]   Instr,
    output [31:0]   ReadData,
    output [31:0]   WriteData,
    output [31:0]   ALUResult,
    output          ZeroFlag
);

    // Internal wires for control signals
    wire RegDst, RegWrite, ALUSrc, Jump, MemtoReg, PCSrc, MemRead, MemWrite;
    wire [3:0] ALUControl;
    wire [31:0] MemAddr;
    wire [3:0] SEL_I;
    wire STB_I, CYC_I, ACK_O;

    // Control Unit
    Controlunit control_unit (
        .Opcode(Instr[31:26]),
        .Func(Instr[5:0]),
        .Zero(ZeroFlag),
        .RegDst(RegDst),
        .RegWrite(RegWrite), 
        .ALUSrc(ALUSrc),
        .Jump(Jump),
        .MemtoReg(MemtoReg),
        .PCSrc(PCSrc),
        .ALUControl(ALUControl)
    );

    // Pipeline Datapath
    Datapath_Pipeline datapath (
        .clk(clk),
        .reset(reset),
        .RegDst(RegDst),      
        .RegWrite(RegWrite),   
        .ALUSrc(ALUSrc),     
        .Jump(Jump),        
        .MemtoReg(MemtoReg),    
        .PCSrc(PCSrc),       
        .ALUControl(ALUControl),
        .MemAddr(MemAddr),
        .WriteData(WriteData),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Instr(Instr),
        .PC(PC),
        .ZeroFlag(ZeroFlag),
        .ALUResult(ALUResult),
        .ReadData(ReadData)
    );

    // Data Memory
    ram dmem (
        .CLK_I(clk),
        .RST_I(reset),
        .ADR_I(MemAddr),      // Sử dụng toàn bộ địa chỉ 32-bit
        .DAT_I(WriteData),
        .DAT_O(ReadData),
        .WE_I(MemWrite),
        .SEL_I(4'b1111),      // Chọn toàn bộ 4 byte cho mỗi giao dịch
        .STB_I(MemRead | MemWrite), // Kích hoạt khi đọc hoặc ghi
        .CYC_I(MemRead | MemWrite), // Kích hoạt chu kỳ bus khi đọc hoặc ghi
        .ACK_O(ACK_O)         // Tín hiệu ACK_O, có thể bỏ qua nếu không cần
    );

    // Instruction Memory
    rom imem (
        .adr(PC[7:2]), // Chỉ lấy 6 bit cho địa chỉ (64 từ)
        .dout(Instr)
    );

endmodule