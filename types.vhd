library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package mytypes_pkg is
	constant N: integer := 16;
    type my_array_t 	  is array (0 to 6) of real range 0.00 to 0.50;
 	type t_data           is array (0 to 6) of signed(N-1   downto 0);        --7 data inputs, one per coefficient
  	type t_coeff          is array (0 to 6) of signed(N-1   downto 0);        --7 coefficients
  	type t_mult           is array (0 to 6) of signed(2*N-1 downto 0);        --per each coefficient we have one mul
  	type t_add_st0        is array (0 to 3) of signed(2*N   downto 0);        --first step of addition we have 4(one is just an input) of them the output is on 33bit
  	type t_add_st1        is array (0 to 1) of signed(2*N+1 downto 0);        --second step addition we have 2 of them 
end package mytypes_pkg;