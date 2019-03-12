LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use std.textio.all;  --include package textio.vhd
use ieee.std_logic_textio.all;


ENTITY tb IS
  generic (
    constant N: integer := 16;      -- number of bits of the input data and coefficients
    constant taps: integer := 7     -- number of taps of the filter
  );
END tb;

ARCHITECTURE behavior OF tb IS 
  signal Clk : std_logic := '0';
  signal Reset: std_logic:= '0';
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
      variable v_ILINE     : line;          -- input line for reading from file
      variable v_OLINE     : line;          -- output line for writing on file
      variable v_INPUT     : integer;       -- variable representing the number read from ILINE
      variable i           : integer:=0;    -- variable used in the loop 
   begin
      file_open(infile, "C:\Users\gioel\OneDrive\Desktop\FIRFilter\IO\input_vectors.txt",  read_mode);
      file_open(outfile, "C:\Users\gioel\OneDrive\Desktop\FIRFilter\IO\output_results.txt", write_mode);
   
      Reset <= '1', '0' after 10 ns; --initialize the process with representing
      wait for Clk_period*2;
      while not endfile(infile) loop --read for each loop one new value from file
        readline(infile, v_ILINE);
        read(v_ILINE, v_INPUT);   
        X <= to_signed(v_INPUT,N);  --input the filter with new data read from file
        wait for clk_period*1;
        write(v_OLINE,to_integer(signed(Y)));
        writeline(outfile,v_OLINE); --output the new data
      end loop;
      -- last output data are voluntarily ignored, they would be the result of supposing 0 as input
      file_close(infile);
      file_close(outfile);
      wait;
   end process;

END;