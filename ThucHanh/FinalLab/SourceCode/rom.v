module rom (
    input [5:0] adr, // Chỉ cần 6 bit
    output [31:0] dout
);
    reg [31:0] mem[0:63]; // 64 từ (2^6)

    initial begin
        $readmemh("memfile.hex", mem); // Đọc file memfile.hex
    end

    assign dout = mem[adr];
endmodule