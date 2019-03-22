library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


PACKAGE my_types IS
	constant N:    integer := 16;	-- input and coefficients size in bits
	constant taps: integer := 7; 	-- number of fir filter taps
END PACKAGE my_types;