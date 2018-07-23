library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package mytypes_pkg is
	constant N: integer := 16;
	constant Nsteps: integer := 7;
	constant Ninput : integer := 63; 
    type t_coeff          is array (0 to 6) of std_logic_vector(N-1 downto 0);      --7 coefficients
    type t_mult           is array (0 to 6) of std_logic_vector(N-1 downto 0);        --per each coefficient we have one mul
    type t_add 			  is array (0 to 5) of std_logic_vector(N-1 downto 0);
    type my_array_t	  	  is array (0 to 6) of std_logic_vector(N-1 downto 0);
    type my_array_in  	  is array (0 to Ninput-1) of std_logic_vector(N-1 downto 0);
end package mytypes_pkg;