module full_adder_4bit_procedural(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output reg [3:0] sum,
    output reg cout
);
    always @(a or b or cin) begin
        {cout, sum} = a + b + cin;
    end
endmodule