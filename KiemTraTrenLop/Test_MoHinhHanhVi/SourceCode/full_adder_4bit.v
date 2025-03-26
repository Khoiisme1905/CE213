module full_adder_1bit(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire s1, c1, c2;
    
    xor x1 (s1, a, b);
    xor x2 (sum, s1, cin);
    
    and a1 (c1, a, b);
    and a2 (c2, s1, cin);
    
    or o1 (cout, c1, c2);
endmodule

module full_adder_4bit(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
);
    wire c1, c2, c3;
    
    full_adder_1bit fa0(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(c1)
    );
    
    full_adder_1bit fa1(
        .a(a[1]),
        .b(b[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );
    
    full_adder_1bit fa2(
        .a(a[2]),
        .b(b[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );
    
    full_adder_1bit fa3(
        .a(a[3]),
        .b(b[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(cout)
    );
endmodule