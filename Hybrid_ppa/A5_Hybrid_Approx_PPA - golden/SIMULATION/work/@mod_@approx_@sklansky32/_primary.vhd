library verilog;
use verilog.vl_types.all;
entity Mod_Approx_Sklansky32 is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        s               : out    vl_logic_vector(31 downto 0);
        cout            : out    vl_logic
    );
end Mod_Approx_Sklansky32;
