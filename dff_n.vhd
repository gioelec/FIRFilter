library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant in std

entity dff_n is
	generic (
			Nbit 	: positive := 16
		);
	port (
			clock_n : in std_ulogic;
			reset_n : in std_ulogic;
			din	  	: in std_ulogic_vector(Nbit downto 1);
			dout  	: out std_ulogic_vector(Nbit downto 1)
	);
end dff_n;


architecture dff_n_arc of dff_n is

	component dff is
	port (
		clk 	: 	in std_ulogic;
		reset 	: 	in std_ulogic;
		d 		:	in std_ulogic;
		q   	:	out std_ulogic
	);
	end component dff;

begin
	GEN: for i in 0 to Nbit-1 generate
		DFF_MAP:	dff port map ( 	clk => clk_n, 
									reset => reset_n, 
									d => din(i), 
									q => dout(i)
								);
	end generate GEN;
end dff_n_arc;

