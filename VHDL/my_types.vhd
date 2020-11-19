LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE my_types IS
	CONSTANT N : INTEGER := 16; -- input and coefficients size in bits
	CONSTANT taps : INTEGER := 7; -- number of fir filter taps
END PACKAGE my_types;