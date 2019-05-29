library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types.all;
use std.textio.all;  
use ieee.std_logic_textio.all;


ENTITY tb IS
END tb;

ARCHITECTURE behavior OF tb IS 
  signal Clk : std_ulogic := '0';
  signal Reset: std_ulogic:= '0';
  signal X : signed(N-1 downto 0) := (others => '0');       -- input signal 
  signal Y : signed(2*N-1 downto 0) := (others => '0');     -- output signal
  constant Clk_period : time := 10 ns;
  file infile : text;                                       
  file outfile : text;                                     
BEGIN

    -- Instantiate the Unit Under Test (UUT)
   uut: entity work.fir PORT MAP (
          Clk => Clk,
          Reset => Reset,
          X => X,
          Y => Y
        );

   -- Clock process definitions, simple process for generating clock signal
   Clk_process :process
   begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
   end process;
    
   -- Stimulus process
   stim_proc: process
      variable v_ILINE     : line;          -- Input line for reading from file
      variable v_OLINE     : line;          -- Output line for writing on file
      variable v_INPUT     : integer;       -- Variable representing the number read from ILINE
      variable i           : integer:=0;    -- Variable used in the loop 
   begin
      file_open(infile, "C:\IO\input_vectors.txt",  read_mode);
      file_open(outfile, "C:IO\output_results.txt", write_mode);
   
      Reset <= '1', '0' after 10 ns;          -- Initialize the process with representing
      wait for Clk_period*2;
      while not endfile(infile) loop          -- Read for each loop one new value from file
        readline(infile, v_ILINE);
        read(v_ILINE, v_INPUT);   
        X <= to_signed(v_INPUT,N);            -- Input the filter with new data read from file
        wait for clk_period*1;
        write(v_OLINE,to_integer(signed(Y)));
        writeline(outfile,v_OLINE);           -- Output the new data
      end loop;
      -- Last output data are voluntarily ignored, they would be the result of supposing 0 as input
      file_close(infile);
      file_close(outfile);
      wait;
   end process;

END;