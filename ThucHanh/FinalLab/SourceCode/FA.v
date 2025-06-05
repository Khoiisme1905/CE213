module FA (
    input a,
    input b,
    input cin,
    output cout,
    output s
);
    // Logic Full Adder
    assign {cout, s} = a + b + cin; // Sử dụng phép toán trực tiếp, nhưng đảm bảo không vượt 2 bit
    // Hoặc triển khai chi tiết:
    // assign s = a ^ b ^ cin;
    // assign cout = (a & b) | (b & cin) | (a & cin);
endmodule