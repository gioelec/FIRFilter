library IEEE;
use IEEE.std_logic_1164.all;
use work.mytypes_pkg.all;
use IEEE.numeric_std.all;



entity dff_N is	
	port(
			Clk : 	in std_ulogic;
			Reset : in std_ulogic;
			d : 	in std_logic_vector(N-1 downto 0);
			q : 	out std_logic_vector(N-1 downto 0)
		);
end entity dff_N;


architecture struct of dff_N is
component dff is
	port (
			Clk : 	in std_ulogic;
			Reset : in std_ulogic;
			d : 	in std_logic;
			q : 	out std_logic
	);
end component dff;

begin
	GEN: for i in 0 to N-1 generate
		DFF_MAP:	dff port map ( 	Clk => Clk, 
								   	Reset => Reset, 
									d => d(i), 
									q => q(i)
								);
	end generate GEN;
end architecture struct;