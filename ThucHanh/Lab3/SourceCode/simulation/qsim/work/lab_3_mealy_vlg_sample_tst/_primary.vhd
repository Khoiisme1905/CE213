library verilog;
use verilog.vl_types.all;
entity lab_3_mealy_vlg_sample_tst is
    port(
        X               : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end lab_3_mealy_vlg_sample_tst;
