module Controlunit (
    input [5:0] Opcode,
    input [5:0] Func,
    input Zero,
    output reg MemtoReg,
    output reg ALUSrc,
    output reg RegDst,
    output reg RegWrite,
    output reg Jump,
    output PCSrc,
    output reg [3:0] ALUControl
);
    reg [7:0] temp;
    reg Branch;
    reg MemWrite; 

    always @(*) begin
        temp = 8'b00000000;
        ALUControl = 4'b0000;
        MemWrite = 0;

        case (Opcode)
            6'b000000: begin // R-type
                temp = 8'b11000000; // RegWrite, RegDst
                case (Func)
                    6'b100000, 6'b100001: ALUControl = 4'b0000; // add, addu
                    6'b100010, 6'b100011: ALUControl = 4'b0001; // sub, subu
                    6'b100100: ALUControl = 4'b0010; // and
                    6'b100101: ALUControl = 4'b0011; // or
                    6'b100110: ALUControl = 4'b0100; // xor
                    6'b100111: ALUControl = 4'b1010; // nor
                    6'b101010: ALUControl = 4'b1000; // slt
                    6'b101011: ALUControl = 4'b1001; // sltu
                    6'b000000: ALUControl = 4'b0101; // sll
                    6'b000010: ALUControl = 4'b0110; // srl
                    6'b000011: ALUControl = 4'b0111; // sra
                    6'b000100: ALUControl = 4'b1011; // sllv
                    6'b000110: ALUControl = 4'b1100; // srlv
                    6'b000111: ALUControl = 4'b1101; // srav
                    default: ALUControl = 4'b0000;
                endcase
            end
            6'b100011: begin // lw
                temp = 8'b10100100; // RegWrite, ALUSrc, MemtoReg
                ALUControl = 4'b0000;
            end
            6'b101011: begin // sw
                temp = 8'b00101000; // ALUSrc, MemWrite
                MemWrite = 1;
                ALUControl = 4'b0000;
            end
            6'b000100: begin // beq
                temp = 8'b00010000; // Branch
                ALUControl = 4'b0001;
            end
            6'b000101: begin // bne
                temp = 8'b00010001; // Branch
                ALUControl = 4'b0001;
            end
            6'b001000, 6'b001001: begin // addi, addiu
                temp = 8'b10100000; // RegWrite, ALUSrc
                ALUControl = 4'b0000;
            end
            6'b001100: begin // andi
                temp = 8'b10100000; // RegWrite, ALUSrc
                ALUControl = 4'b0010;
            end
            6'b001101: begin // ori
                temp = 8'b10100000; // RegWrite, ALUSrc
                ALUControl = 4'b0011;
            end
            6'b001110: begin // xori
                temp = 8'b10100000; // RegWrite, ALUSrc
                ALUControl = 4'b0100;
            end
            6'b001010: begin // slti
                temp = 8'b10100000; // RegWrite, ALUSrc
                ALUControl = 4'b1000;
            end
            6'b001011: begin // sltiu
                temp = 8'b10100000; // RegWrite, ALUSrc
                ALUControl = 4'b1001;
            end
            6'b000010: begin // j
                temp = 8'b00000010; // Jump
                ALUControl = 4'b0000;
            end
            6'b001111: begin // lui
                temp = 8'b10100000; // RegWrite, ALUSrc
                ALUControl = 4'b1110;
            end
            default: temp = 8'b00000000;
        endcase

        {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, Jump} = temp[7:1];
    end

    assign PCSrc = Branch & ((Opcode == 6'b000100) ? Zero : ~Zero); // beq: Zero, bne: ~Zero
endmodule