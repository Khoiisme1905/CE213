library verilog;
use verilog.vl_types.all;
entity lab_3_mealy is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        X               : in     vl_logic;
        Z               : out    vl_logic
    );
end lab_3_mealy;
