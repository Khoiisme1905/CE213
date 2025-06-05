library verilog;
use verilog.vl_types.all;
entity mux2to1_32bit is
    port(
        Sel             : in     vl_logic;
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        \Out\           : out    vl_logic_vector(31 downto 0)
    );
end mux2to1_32bit;
