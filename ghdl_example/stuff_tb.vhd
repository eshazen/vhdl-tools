
library ieee;
use ieee.std_logic_1164.all;

entity stuff_tb is
  
end entity stuff_tb;


architecture arch of stuff_tb is

  component stuff is
    port (
      clk : in  std_logic;
      rst : in  std_logic;
      q   : out std_logic);
  end component stuff;

  signal clk, rst, q : std_logic;

begin  -- architecture arch

  rst <= '0', '1' after 20 ns;

  process

  begin
    

    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;

  end process;

  stuff_1: entity work.stuff
    port map (
      clk => clk,
      rst => rst,
      q   => q);

end architecture arch;
