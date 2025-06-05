module Datapath (
    input clk,
    input reset,
    input RegDst,
    input RegWrite,
    input ALUSrc,
    input Jump,
    input MemtoReg,
    input PCSrc,
    input [3:0] ALUControl,
    input [31:0] ReadData,
    input [31:0] Instr,
    output [31:0] PC,
    output ZeroFlag,
    output [31:0] WriteData,
    output [31:0] ALUResult
);
    wire [31:0] PCNext, PCplus4, PCbeforeBranch, PCBranch;
    wire [31:0] extendedimm, extendedimmafter, MUXresult, dataone, aluop2;
    wire [4:0] writereg;

    flopr_param #(32) PCregister (
        .clk(clk),
        .rst(reset),
        .d(PCNext),
        .q(PC)
    );

    assign PCplus4 = PC + 32'd4;

    signext immextention (
        .a(Instr[15:0]),
        .y(extendedimm)
    );
    sl2 shifteradd2 (
        .a(extendedimm),
        .y(extendedimmafter)
    );

    assign PCbeforeBranch = PCplus4 + extendedimmafter;

    wire [31:0] PCBranchIntermediate;
    assign PCBranchIntermediate = PCSrc ? PCbeforeBranch : PCplus4;

    wire [31:0] jump_addr;
    assign jump_addr = {PCplus4[31:28], Instr[25:0], 2'b00};

    assign PCNext = Jump ? jump_addr : PCBranchIntermediate;

    registerfile32 RF (
        .clk(clk),
        .we(RegWrite),
        .reset(reset),
        .ra1(Instr[25:21]),
        .ra2(Instr[20:16]),
        .wa(writereg),
        .wd(MUXresult),
        .rd1(dataone),
        .rd2(WriteData)
    );

    assign writereg = RegDst ? Instr[15:11] : Instr[20:16];

    assign aluop2 = ALUSrc ? extendedimm : WriteData;

    alu32 alucomp (
        .a(dataone),
        .b(aluop2),
        .f(ALUControl),
        .shamt(Instr[10:6]),
        .y(ALUResult),
        .zero(ZeroFlag)
    );

    assign MUXresult = MemtoReg ? ReadData : ALUResult;
endmodule