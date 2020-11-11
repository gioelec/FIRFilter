LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.my_types.ALL;
ENTITY fir IS
  PORT (
    Clk : IN STD_ULOGIC; -- Clock input 
    Reset : IN STD_ULOGIC; -- Reset input 
    X : IN signed(N - 1 DOWNTO 0); -- Input data
    Y : OUT signed(2 * N - 1 DOWNTO 0) -- Output data
  );
END fir;

ARCHITECTURE Behavioral OF fir IS

  COMPONENT DFF IS
    PORT (
      Q : OUT signed(2 * N - 1 DOWNTO 0); -- Output of the DFF sized with 31 bits 
      Reset : IN STD_LOGIC; -- Reset signal 
      Clk : IN STD_LOGIC; -- Clock input
      D : IN signed(2 * N - 1 DOWNTO 0) -- Data input of the DFF
    );
  END COMPONENT;
  -- List of coefficients initialized to 0
  SIGNAL C0, C1, C2, C3, C4, C5, C6 : signed(N - 1 DOWNTO 0) := (OTHERS => '0');
  -- Signals carrying the multiplication result between input and coefficients 
  SIGNAL MUL_OUT0, MUL_OUT1, MUL_OUT2, MUL_OUT3, MUL_OUT4, MUL_OUT5, MUL_OUT6 : signed(2 * N - 1 DOWNTO 0) := (OTHERS => '0');
  -- Signals with the sum result of output of register and previous signals 
  SIGNAL SUM_OUT1, SUM_OUT2, SUM_OUT3, SUM_OUT4, SUM_OUT5, SUM_OUT6 : signed(2 * N - 1 DOWNTO 0) := (OTHERS => '0');
  -- Signals connected to the output of registers
  SIGNAL Q1, Q2, Q3, Q4, Q5, Q6 : signed(2 * N - 1 DOWNTO 0) := (OTHERS => '0');

BEGIN

  -- Filter coefficient initializations, integer coefficients are obtained from matlab
  C0 <= to_signed(442, 16); --0.0135
  C1 <= to_signed(2572, 16); --0.0785
  C2 <= to_signed(7894, 16); --0.2409
  C3 <= to_signed(10958, 16); --0.3344
  C4 <= to_signed(7894, 16); --0.2409
  C5 <= to_signed(2572, 16); --0.0785
  C6 <= to_signed(442, 16); --0.0135

  -- Multiple constant multiplications.
  MUL_OUT6 <= C6 * X;
  MUL_OUT5 <= C5 * X;
  MUL_OUT4 <= C4 * X;
  MUL_OUT3 <= C3 * X;
  MUL_OUT2 <= C2 * X;
  MUL_OUT1 <= C1 * X;
  MUL_OUT0 <= C0 * X;

  -- Sum results from registers output and multiplication result
  SUM_OUT1 <= Q1 + MUL_OUT5;
  SUM_OUT2 <= Q2 + MUL_OUT4;
  SUM_OUT3 <= Q3 + MUL_OUT3;
  SUM_OUT4 <= Q4 + MUL_OUT2;
  SUM_OUT5 <= Q5 + MUL_OUT1;
  SUM_OUT6 <= Q6 + MUL_OUT0;

  -- D-Flipflops(for introducing a delay), with addition result as input
  dff1 : DFF PORT MAP(Q1, Reset, Clk, MUL_OUT6); -- First sample does not have any previous sum
  dff2 : DFF PORT MAP(Q2, Reset, Clk, SUM_OUT1);
  dff3 : DFF PORT MAP(Q3, Reset, Clk, SUM_OUT2);
  dff4 : DFF PORT MAP(Q4, Reset, Clk, SUM_OUT3);
  dff5 : DFF PORT MAP(Q5, Reset, Clk, SUM_OUT4);
  dff6 : DFF PORT MAP(Q6, Reset, Clk, SUM_OUT5);

  -- An output produced at every positive edge of clock cycle.
  PROCESS (Clk, Reset)
  BEGIN
    IF Reset = '1' THEN
      Y <= (OTHERS => '0'); -- The output is Reset to 0
    ELSIF (rising_edge(Clk)) THEN
      Y <= SUM_OUT6(2 * N - 1 DOWNTO 0); -- We output the last addition as result
    END IF;
  END PROCESS;

END Behavioral;