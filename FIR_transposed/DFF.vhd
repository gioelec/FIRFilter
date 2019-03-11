library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DFF is 
   port(
      Q : out signed(31 downto 0);      --output connected to the adder
      Reset :in std_logic;      -- Clock input
      Clk :in std_logic;      -- Clock input
      D :in  signed(31 downto 0)      -- Data input from the MCM block.
   );
end DFF;

architecture Behavioral of DFF is 

signal qt : signed(31 downto 0) := (others => '0');

begin 

Q <= qt;

process(Clk,Reset) 
begin 
  	if ( rising_edge(Clk) ) then 
    	qt <= D;
	end if;
	if Reset = '1' then
		qt <= (others=> '0');
  	end if;       
end process; 

end Behavioral;