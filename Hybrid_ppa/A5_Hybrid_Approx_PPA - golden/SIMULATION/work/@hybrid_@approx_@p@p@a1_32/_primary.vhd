library verilog;
use verilog.vl_types.all;
entity Hybrid_Approx_PPA1_32 is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        s               : out    vl_logic_vector(31 downto 0);
        cout            : out    vl_logic
    );
end Hybrid_Approx_PPA1_32;
