module Cla_M(A, B, Cin, S);
    input [2:0] A, B;
    input Cin;
    output [3:0] S;
    
    assign S = (A + B + Cin);
endmodule

`timescale 1ns/100ps
module CLA_testbench();
    reg [2:0] A, B;
    reg Cin;
    wire [3:0] S, mS;

    initial
    begin
        #640 $stop;
    end

    initial
    begin
        Gen();
    end

    // ?úng tên module
    Cla_M Inst1(.A(A), .B(B), .Cin(Cin), .S(S));
    Cla_M Inst2(.A(A), .B(B), .Cin(Cin), .S(mS));

    task Gen;
    begin
        A <= 0;
        B <= 0;
        Cin <= 0;
        forever begin
            #5 A <= (A + 1);

            if (A == 3'b111) begin
                A <= 0;
                B <= B + 1;
                if (B == 3'b111) 
                    Cin <= Cin + 1;
            end

            // Ki?m tra giá tr? S và mS
            if (S == mS)
                $display("PASS: S = %b, mS = %b", S, mS);
            else
                $display("FAILED: S = %b, mS = %b", S, mS);
        end
    end
    endtask

endmodule