`timescale 1ns / 1ps 

module ALU_32bit_tb;

    reg [31:0] A;
    reg [31:0] B;
    reg M, S1, S0;
    wire [31:0] result;
    wire add_sub_overflow;
    wire iszero;

    ALU_32bit alu (
        .A(A),
        .B(B),
        .M(M),
        .S1(S1),
        .S0(S0),
        .result(result),
        .add_sub_overflow(add_sub_overflow),
	.iszero(iszero)
    );

    initial begin
        A = 32'd5; B = 32'd0; M = 0; S1 = 0; S0 = 0;
        #10;
        $display("Complement A: result = %d", result);

        A = 32'd5; B = 32'd3; M = 0; S1 = 0; S0 = 1;
        #10;
        $display("AND: result = %d", result);

        A = 32'd5; B = 32'd3; M = 0; S1 = 1; S0 = 0;
        #10;
        $display("EX-OR: result = %d", result);

        A = 32'd5; B = 32'd3; M = 0; S1 = 1; S0 = 1;
        #10;
        $display("OR: result = %d", result);

        A = 32'd5; B = 32'd0; M = 1; S1 = 0; S0 = 0;
        #10;
        $display("Decrement A: result = %d", result);

        A = 32'd10; B = 32'd20; M = 1; S1 = 0; S0 = 1;
        #10;
        $display("Add (signed): result = %d, overflow = %b", result, add_sub_overflow);

        A = 32'd30; B = 32'd30; M = 1; S1 = 1; S0 = 0;
        #10;
        $display("Subtract (signed): result = %d, overflow = %b", result, add_sub_overflow);

        A = 32'd5; B = 32'd0; M = 1; S1 = 1; S0 = 1;
        #10;
        $display("Increment A: result = %d", result);

        A = 32'h7FFFFFFF; B = 32'd1; M = 1; S1 = 0; S0 = 1;
        #10;
        $display("Overflow Add A: result = %d", result);

        A = 32'h80000000; B = 32'd1; M = 1; S1 = 1; S0 = 0;
        #10;
        $display("Overflow Sub A: result = %d", result);

        $finish;
    end

    initial begin
        $monitor("At time %t: A = %d, B = %d, result = %d, overflow = %b", $time, A, B, result, add_sub_overflow);
    end

endmodule