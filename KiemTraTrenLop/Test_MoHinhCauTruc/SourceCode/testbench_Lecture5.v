// Testbench cho mô-đun Lecture5
module testbench_Lecture5;

    // Khai báo các tín hiệu đầu vào và đầu ra
    reg A, B, C;       // Đầu vào điều khiển
    reg clk;           // Tín hiệu clock
    reg reset;         // Tín hiệu reset
    wire Q;            // Đầu ra của T-Flip Flop

    // Khởi tạo mô-đun Lecture5
    Lecture5 uut (
        .A(A),
        .B(B),
        .C(C),
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );

    // Tạo xung clock 50 MHz (chu kỳ 20 ns)
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Chu kỳ 20 ns = 50 MHz
    end

    // Quá trình kiểm tra
    initial begin
        // Khởi tạo giá trị ban đầu
        A = 0; B = 0; C = 0; reset = 1; // Reset ban đầu
        #20; // Chờ 20 ns để reset được áp dụng
        
        reset = 0; // Tắt reset để mạch hoạt động bình thường
        #20; // Chờ thêm 20 ns
        
        // Kiểm tra các trường hợp đầu vào
        $display("Time\tA\tB\tC\tReset\tQ");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, C, reset, Q);

        // Trường hợp 1: A=0, B=0, C=0
        A = 0; B = 0; C = 0;
        #40; // Chờ 2 chu kỳ clock

        // Trường hợp 2: A=0, B=0, C=1
        A = 0; B = 0; C = 1;
        #40;

        // Trường hợp 3: A=0, B=1, C=0
        A = 0; B = 1; C = 0;
        #40;

        // Trường hợp 4: A=0, B=1, C=1
        A = 0; B = 1; C = 1;
        #40;

        // Trường hợp 5: A=1, B=0, C=0
        A = 1; B = 0; C = 0;
        #40;

        // Trường hợp 6: A=1, B=0, C=1
        A = 1; B = 0; C = 1;
        #40;

        // Trường hợp 7: A=1, B=1, C=0
        A = 1; B = 1; C = 0;
        #40;

        // Trường hợp 8: A=1, B=1, C=1
        A = 1; B = 1; C = 1;
        #40;

        // Kiểm tra reset lại
        reset = 1; // Kích hoạt reset
        #20;
        reset = 0; // Tắt reset
        #40;

        // Kết thúc mô phỏng
        #20 $finish;
    end

    // Tạo file VCD để xem dạng sóng (nếu cần)
    initial begin
        $dumpfile("Lecture5.vcd"); // File lưu dạng sóng
        $dumpvars(0, tb_Lecture5); // Ghi lại tất cả các tín hiệu trong testbench
    end

endmodule