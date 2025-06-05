
module bus (
    input wire clk,            // Wishbone CLK_I
    input wire reset,          // Wishbone RST_I
    // Giao diện CPU
    input wire [31:0] cpu_addr,
    input wire [31:0] cpu_data_write,
    input wire cpu_read,
    input wire cpu_write,
    output reg [31:0] cpu_data_read,
    // Giao diện Wishbone Master
    output reg [31:0] ADR_O,   // Địa chỉ Wishbone
    output reg [31:0] DAT_O,   // Dữ liệu ghi
    input wire [31:0] DAT_I,   // Dữ liệu đọc từ các slave
    output reg WE_O,           // Write Enable (1: ghi, 0: đọc)
    output reg [3:0] SEL_O,    // Chọn byte
    output reg STB_O,          // Strobe
    output reg CYC_O,          // Cycle
    input wire ACK_I           // Acknowledge từ các slave
);

    // Máy trạng thái
    localparam IDLE = 2'b00, REQUEST = 2'b01, WAIT_ACK = 2'b10;
    reg [1:0] state, next_state;

    // Giải mã địa chỉ
    reg [4:0] slave_select;

    // Logic giải mã địa chỉ
    always @(*) begin
        case (cpu_addr[31:8])
            24'h000000: slave_select = 5'b00001; // RAM: 0x0000_0000 - 0x0000_00FF
            24'h000001: slave_select = 5'b00010; // GPIO In: 0x0000_0100 - 0x0000_01FF
            24'h000002: slave_select = 5'b00100; // GPIO Out: 0x0000_0200 - 0x0000_02FF
            24'h000003: slave_select = 5'b01000; // PWM: 0x0000_0300 - 0x0000_03FF
            default: slave_select = 5'b00000;    // Không chọn slave
        endcase
    end

    // FSM: Điều khiển giao thức Wishbone
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        CYC_O = 0;
        STB_O = 0;
        WE_O = 0;
        SEL_O = 4'b1111; // Chọn toàn bộ 32 bit
        ADR_O = cpu_addr;
        DAT_O = cpu_data_write;
        cpu_data_read = DAT_I;

        case (state)
            IDLE: begin
                if (cpu_read || cpu_write) begin
                    next_state = REQUEST;
                end
            end
            REQUEST: begin
                CYC_O = 1;
                STB_O = (slave_select != 5'b00000); // Chỉ kích hoạt STB nếu slave được chọn
                WE_O = cpu_write;
                next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                CYC_O = 1;
                STB_O = (slave_select != 5'b00000);
                WE_O = cpu_write;
                if (ACK_I)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
