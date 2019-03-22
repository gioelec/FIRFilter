library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types.all;

entity DFF is 
   port(
      Q : out signed(2*N-1 downto 0);       -- output connected to the adder
      Reset :in std_ulogic;                 -- Clock input
      Clk :in std_ulogic;                   -- Clock input
      D :in  signed(2*N-1 downto 0)         -- Data input from the MCM block.
   );
end DFF;

architecture Behavioral of DFF is 

signal qt : signed(2*N-1 downto 0) := (others => '0');  -- signal linking input and output

begin 

Q <= qt;                                    -- Link output and signal 

process(Clk,Reset) 
begin 
	if Reset = '1' then
		qt <= (others=> '0');                   -- On reset zero the signal
  elsif ( rising_edge(Clk) ) then 
    	qt <= D;                              -- On each rising edge if reset is not active sample the input
	end if;
end process; 

end Behavioral;
