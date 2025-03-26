// Mô-đun MUX 2-1
module mux2(in0, in1, select, out);
    input in0, in1, select;
    output out;
    wire s0, w0, w1;
    not (s0, select);
    and (w0, s0, in0), (w1, select, in1);
    or (out, w0, w1);
endmodule

// Mô-đun MUX 4-1 sử dụng MUX 2-1
module mux4(in0, in1, in2, in3, sel0, sel1, out);
    input in0, in1, in2, in3, sel0, sel1;
    output out;
    wire w0, w1;
    
    mux2 mux_low(in0, in1, sel0, w0);
    mux2 mux_high(in2, in3, sel0, w1);
    
    mux2 mux_final(w0, w1, sel1, out);
endmodule

// Bộ giải mã 3-to-8
module decoder_3to8(A, B, C, out);
    input A, B, C;
    output [7:0] out;
    wire A_not, B_not, C_not;
    wire o1out, a1out, or1out;
    
    // Nghịch đảo các đầu vào
    not (A_not, A);
    not (B_not, B);
    not (C_not, C);
    
    // Tạo các đầu ra giải mã
    and (out[0], A_not, B_not, C_not); // 000
    and (out[1], A_not, B_not, C);     // 001
    and (out[2], A_not, B, C_not);     // 010
    and (out[3], A_not, B, C);         // 011
    and (out[4], A, B_not, C_not);     // 100
    and (out[5], A, B_not, C);         // 101
    and (out[6], A, B, C_not);         // 110
    and (out[7], A, B, C);             // 111
    
    not (o1out, out[3]);
    and (a1out, o1out, out[4]);
    or (or1out, out[6], out[7]);
endmodule

// T-Flip Flop
module t_flip_flop(T, clk, reset, Q);
    input T, clk, reset;
    output reg Q;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else if (T)
            Q <= ~Q; // Toggle khi T=1
    end
endmodule

module Lecture5(A, B, C, clk, reset, Q);
    input A, B, C, clk, reset;
    output Q;
    
    // Các dây dẫn nội bộ
    wire [7:0] decoder_out;
    wire mux_out, o1out, a1out, or1out, intff;
    
    // Bộ giải mã 3-to-8
    decoder_3to8 decoder_inst(A, B, C, decoder_out);
    
    // Tạo các tín hiệu logic
    not (o1out, decoder_out[3]);
    and (a1out, o1out, decoder_out[4]);
    or (or1out, decoder_out[6], decoder_out[7]); 
    
    // Sử dụng MUX4 với đủ đối số
    mux4 mux_inst(
        decoder_out[2],  // in0
        a1out,           // in1
        decoder_out[5],  // in2
        or1out,          // in3
        A,               // sel0 
        B,               // sel1 
        intff            // out
    );
    
    // T-Flip Flop nhận đầu vào từ mạch logic trước đó
    t_flip_flop tff_inst(intff, clk, reset, Q);
endmodule