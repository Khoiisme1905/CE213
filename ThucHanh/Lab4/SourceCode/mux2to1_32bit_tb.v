`timescale 1ns/1ps

module mux2to1_32bit_tb;

    reg Sel;
    reg [31:0] A, B;
    wire [31:0] Out;

    mux2to1_32bit uut (
        .Sel(Sel),
        .A(A),
        .B(B),
        .Out(Out)
    );

    initial begin

        $display("Time\tSel\tA\t\tB\t\tOut");

        Sel = 0;
        A = 32'hAAAAAAAA; 
        B = 32'h55555555; 
        #10; 
        $display("%0dns\t%b\t%h\t%h\t%h", $time, Sel, A, B, Out);


        Sel = 1;
        #10;
        $display("%0dns\t%b\t%h\t%h\t%h", $time, Sel, A, B, Out);

     
        A = 32'h12345678;
        B = 32'h87654321;
        Sel = 0;
        #10;
        $display("%0dns\t%b\t%h\t%h\t%h", $time, Sel, A, B, Out);

        Sel = 1;
        #10;
        $display("%0dns\t%b\t%h\t%h\t%h", $time, Sel, A, B, Out);

  
        A = $random;
        B = $random;
        Sel = 0;
        #10;
        $display("%0dns\t%b\t%h\t%h\t%h", $time, Sel, A, B, Out);

        Sel = 1;
        #10;
        $display("%0dns\t%b\t%h\t%h\t%h", $time, Sel, A, B, Out);

        $finish;
    end

endmodule
