
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library l0mdt_lib;
use l0mdt_lib.mdttp_constants_pkg.all;
use l0mdt_lib.mdttp_types_pkg.all;
use l0mdt_lib.mdttp_control_pkg.all;

package my_types_pkg is
  constant c_NUM_POLMUX_INNER : integer := 6;
  constant c_NUM_POLMUX_MIDDLE : integer := 5;
  constant c_NUM_POLMUX_OUTER : integer := 4;
  constant c_NUM_POLMUX_EXTRA : integer := 3;
  constant c_NUM_SF_INPUTS: integer := 2;
  constant c_NUM_SF_OUTPUTS: integer := 2;
  constant c_NUM_DAQ_STREAMS : integer := 3;
end package my_types_pkg;

