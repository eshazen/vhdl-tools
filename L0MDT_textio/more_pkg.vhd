--
-- just for testing the perl code
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

package more_pkg is

  type more_rt is record
    chanid     : unsigned( 3 townto 0);
    edgemode   : std_logic_vector(4 downto 0);
  end record more_rt;


end package more_pkg;
