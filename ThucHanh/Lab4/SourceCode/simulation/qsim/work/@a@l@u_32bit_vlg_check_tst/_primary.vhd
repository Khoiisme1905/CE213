library verilog;
use verilog.vl_types.all;
entity ALU_32bit_vlg_check_tst is
    port(
        add_sub_overflow: in     vl_logic;
        iszero          : in     vl_logic;
        result          : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end ALU_32bit_vlg_check_tst;
