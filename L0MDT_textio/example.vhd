library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.example_pkg.all;


entity example is

  port (
    clk                  : in  std_logic;
    polmux_pipeline_aart : in  polmux_pipe_aart(NSTA-1 downto 0);
    hit                  : out std_logic
    );

end entity example;


architecture arch of example is

  signal big_or : std_logic_vector(NPOLMUX*NSTA-1 downto 0);

begin  -- architecture arch

  sta: for s in 0 to NSTA-1 generate
    pipe: for p in 0 to NPOLMUX-1 generate
      big_or(s*NPOLMUX+p) <= polmux_pipeline_aart(s)(p).datavalid;
    end generate pipe;
  end generate sta;

  hit <= or_reduce( big_or);

end architecture arch;
