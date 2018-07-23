library IEEE;
use IEEE.std_logic_1164.all;

entity dff is	
	port(
			clk : 	in std_ulogic;
			reset : in std_ulogic;
			d : 	in std_logic;
			q : 	out std_logic
		);
end entity dff;

architecture struct of dff is
begin	
	d_flip_flop: process(clk, reset)
	begin
		if reset = '1' then
			q <= '0';
		elsif rising_edge(clk) then
			q <= d ;
		end if;
	end process d_flip_flop;
end architecture struct;