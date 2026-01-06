library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

package example_pkg is

  constant NPOLMUX : integer := 6;
  constant NSTA    : integer := 3;

  constant TDCPOLMUX_FIBERID_LEN : integer := 3;
  constant TDCPOLMUX_ELINKID_LEN : integer := 3;
  constant TDC_CHANID_LEN : integer := 3;
  constant TDC_EDGEMODE_LEN : integer := 3;
  constant TDC_COARSETIME_LEN : integer := 3;
  constant TDC_FINETIME_LEN : integer := 3;
  constant TDC_PULSEWIDTH_LEN : integer := 3;

  type tdc_rt is record
    chanid     : std_logic_vector(TDC_CHANID_LEN-1 downto 0);      -- 4
    edgemode   : std_logic_vector(TDC_EDGEMODE_LEN-1 downto 0);    -- 1
    coarsetime : std_logic_vector(TDC_COARSETIME_LEN-1 downto 0);  -- 11
    finetime   : std_logic_vector(TDC_FINETIME_LEN-1 downto 0);    -- 4
    pulsewidth : std_logic_vector(TDC_PULSEWIDTH_LEN-1 downto 0);  -- 7
  end record tdc_rt;

  type tdcpolmux_rt is record
    tdc_r     : tdc_rt;
    fiberid   : std_logic_vector(TDCPOLMUX_FIBERID_LEN-1 downto 0);  -- 4
    elinkid   : std_logic_vector(TDCPOLMUX_ELINKID_LEN-1 downto 0);  -- 3
    datavalid : std_logic;
  end record tdcpolmux_rt;

  type polmux_pipe_art is array (NPOLMUX-1 downto 0) of tdcpolmux_rt;
  type polmux_pipe_aart is array (integer range <>) of polmux_pipe_art;

end package example_pkg;
