library ieee;
use ieee.std_logic_1164.all;

entity stuff is
  
  port (
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic);

end entity stuff;



architecture arch of stuff is

  signal y : std_logic;

begin  -- architecture arch

  process (clk, rst) is
  begin  -- process
    if rst = '0' then                   -- asynchronous reset (active low)
      y <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      y <= not y;
    end if;
  end process;

  q <= y;
  
end architecture arch;
