library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fir is
  generic (
    constant N: integer := 16;
    constant taps: integer := 7
  );
  port(   
    Clk : in std_logic; 
    Reset : in std_logic;  
    X : in signed(N-1 downto 0); 
    Y : out signed(2  *N-1 downto 0)
  );
end fir;

architecture Behavioral of fir is

component DFF is 
   port(
      Q : out signed(2*N-1 downto 0);    -- 
      Reset : in std_logic;  
      Clk :in std_logic;                  -- Clock input
      D :in  signed(2*N-1 downto 0)       -- Data input from the MUL_OUT block.
   );
end component;  
  
signal C0,C1,C2,C3,C4,C5,C6 : signed(N-1 downto 0) := (others => '0');
signal MUL_OUT0,MUL_OUT1,MUL_OUT2,MUL_OUT3,MUL_OUT4,MUL_OUT5,MUL_OUT6: signed(2*N-1 downto 0) := (others => '0');
signal SUM_OUT1,SUM_OUT2,SUM_OUT3,SUM_OUT4,SUM_OUT5,SUM_OUT6 : signed(2*N-1 downto 0) := (others => '0');
signal Q1,Q2,Q3,Q4,Q5,Q6 : signed(2*N-1 downto 0) := (others => '0');

begin

--filter coefficient initializations, integer coefficients are obtained from matlab
C0 <= to_signed(442,16);      --0.0135
C1 <= to_signed(2572,16);     --0.0785
C2 <= to_signed(7894,16);     --0.2409
C3 <= to_signed(10958,16);    --0.3344
C4 <= to_signed(7894,16);     --0.2409
C5 <= to_signed(2572,16);     --0.0785
C6 <= to_signed(442,16);      --0.0135

--Multiple constant multiplications.
MUL_OUT6 <= C6*X;
MUL_OUT5 <= C5*X;
MUL_OUT4 <= C4*X;
MUL_OUT3 <= C3*X;
MUL_OUT2 <= C2*X;
MUL_OUT1 <= C1*X;
MUL_OUT0 <= C0*X;

--adders
SUM_OUT1 <= Q1 + MUL_OUT5;
SUM_OUT2 <= Q2 + MUL_OUT4;
SUM_OUT3 <= Q3 + MUL_OUT3;
SUM_OUT4 <= Q4 + MUL_OUT2;
SUM_OUT5 <= Q5 + MUL_OUT1;
SUM_OUT6 <= Q6 + MUL_OUT0;

--flipflops(for introducing a delay).
dff1 : DFF port map(Q1,Reset,Clk,MUL_OUT6);
dff2 : DFF port map(Q2,Reset,Clk,SUM_OUT1);
dff3 : DFF port map(Q3,Reset,Clk,SUM_OUT2);
dff4 : DFF port map(Q4,Reset,Clk,SUM_OUT3);
dff5 : DFF port map(Q5,Reset,Clk,SUM_OUT4);
dff6 : DFF port map(Q6,Reset,Clk,SUM_OUT5);

--an output produced at every positive edge of clock cycle.
process(Clk,Reset)
begin
    if(rising_edge(Clk)) then
        Y <= SUM_OUT6(2*N-1 downto 0);
    elsif Reset = '1' then
        Y <= (others=> '0');
    end if;
end process;
    
end Behavioral;