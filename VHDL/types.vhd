LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;

PACKAGE types IS
	constant N: integer := 16;
	constant taps        : integer := 7; --number of fir filter taps

	type coefficient_array IS ARRAY (0 TO taps-1) OF signed (coeff_width-1 DOWNTO 0);  --array of all coefficients


END PACKAGE types;