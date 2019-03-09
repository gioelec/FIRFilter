library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fir is
port(   Clk : in std_logic; 
        Xin : in signed(15 downto 0); 
        Yout : out signed(15 downto 0)
        );
end fir;

architecture Behavioral of fir is

component DFF is 
   port(
      Q : out signed(31 downto 0);    
      Clk :in std_logic;      -- Clock input
      D :in  signed(31 downto 0)      -- Data input from the MCM block.
   );
end component;  
  
signal H0,H1,H2,H3,H4,H5,H6 : signed(15 downto 0) := (others => '0');
signal MCM0,MCM1,MCM2,MCM3,MCM4,MCM5,MCM6,add_out1,add_out2,add_out3,add_out4,add_out5,add_out6 : signed(31 downto 0) := (others => '0');
signal Q1,Q2,Q3,Q4,Q5,Q6 : signed(31 downto 0) := (others => '0');

begin

--filter coefficient initializations, integer coefficients are obtained from matlab
H0 <= to_signed(442,16);
H1 <= to_signed(2572,16);
H2 <= to_signed(7894,16);
H3 <= to_signed(10958,16);
H4 <= to_signed(7894,16);
H5 <= to_signed(2572,16);
H6 <= to_signed(442,16);

--Multiple constant multiplications.
MCM6 <= H6*Xin;
MCM5 <= H5*Xin;
MCM4 <= H4*Xin;
MCM3 <= H3*Xin;
MCM2 <= H2*Xin;
MCM1 <= H1*Xin;
MCM0 <= H0*Xin;

--adders
add_out1 <= Q1 + MCM5;
add_out2 <= Q2 + MCM4;
add_out3 <= Q3 + MCM3;
add_out4 <= Q4 + MCM2;
add_out5 <= Q5 + MCM1;
add_out6 <= Q6 + MCM0;

--flipflops(for introducing a delay).
dff1 : DFF port map(Q1,Clk,MCM6);
dff2 : DFF port map(Q2,Clk,add_out1);
dff3 : DFF port map(Q3,Clk,add_out2);
dff4 : DFF port map(Q4,Clk,add_out3);
dff5 : DFF port map(Q5,Clk,add_out4);
dff6 : DFF port map(Q6,Clk,add_out5);

--an output produced at every positive edge of clock cycle.
process(Clk)
begin
    if(rising_edge(Clk)) then
        Yout <= add_out6(15 downto 0);
    end if;
end process;
    
end Behavioral;