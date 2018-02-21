library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity fir_filter is
  generic (
    coeffs    : real_vector := (0.0135,0.0785,0.2409,0.3344,0.2409,0.0785,0.0135);
    N         : integer := 16;
  );
  port (
    clock     : in  std_logic;
    reset     : in  std_logic;
    -- coefficient
    C0        : in  std_logic_vector(N-1 downto 0);
    C1        : in  std_logic_vector(N-1 downto 0);
    C2        : in  std_logic_vector(N-1 downto 0);
    C3        : in  std_logic_vector(N-1 downto 0);  
    C4        : in  std_logic_vector(N-1 downto 0);
    C5        : in  std_logic_vector(N-1 downto 0);
    C6        : in  std_logic_vector(N-1 downto 0);
    -- data input
    x         : in  std_logic_vector(N-1 downto 0);
    -- filtered data 
    y         : out std_logic_vector(9 downto 0));   // still to size
  );
end fir_filter;
architecture firFilter_arc of firFilter is

  signal clock : std_logic;

begin

end firFilter_arc;