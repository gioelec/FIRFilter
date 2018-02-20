use IEEE.std_logic_1164.all;
library IEEE;

entity dff is
	port (
		clock : in std_ulogic;
		reset : in std_ulogic;
		d     : in std_logic;
		q     : out std_logic;
	);
end dff;
architecture struct of dff is
begin
	d_flip_flop: process(clock,reset)
	begin
		if reset = '1' then
			q <= '0';
		elsif rising_edge(clock) then
			q <= d;
		end if;
	end process d_flip_flop;
end architecture struct;