LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.my_types.ALL;

ENTITY DFF IS
   PORT (
      Q : OUT signed(2 * N - 1 DOWNTO 0); -- output connected to the adder
      Reset : IN STD_ULOGIC; -- Clock input
      Clk : IN STD_ULOGIC; -- Clock input
      D : IN signed(2 * N - 1 DOWNTO 0) -- Data input from the MCM block.
   );
END DFF;

ARCHITECTURE Behavioral OF DFF IS

   SIGNAL qt : signed(2 * N - 1 DOWNTO 0) := (OTHERS => '0'); -- signal linking input and output

BEGIN

   Q <= qt; -- Link output and signal 

   PROCESS (Clk, Reset)
   BEGIN
      IF Reset = '1' THEN
         qt <= (OTHERS => '0'); -- On reset zero the signal
      ELSIF (rising_edge(Clk)) THEN
         qt <= D; -- On each rising edge if reset is not active sample the input
      END IF;
   END PROCESS;

END Behavioral;