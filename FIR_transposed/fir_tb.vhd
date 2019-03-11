LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use std.textio.all;  --include package textio.vhd
use ieee.std_logic_textio.all;


ENTITY tb IS
END tb;

ARCHITECTURE behavior OF tb IS 
  signal Clk : std_logic := '0';
  signal Reset: std_logic:= '0';
  signal X : signed(15 downto 0) := (others => '0');
  signal Y : signed(15 downto 0) := (others => '0');
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

   -- Clock process definitions
   Clk_process :process
   begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
   end process;
    
   -- Stimulus process
   stim_proc: process
      variable v_ILINE     : line;
      variable v_OLINE     : line;
      variable v_INPUT     : integer;
   begin
      file_open(infile, "C:\Users\gioel\OneDrive\Desktop\input_vectors.txt",  read_mode);
      file_open(outfile, "C:\Users\gioel\OneDrive\Desktop\output_results.txt", write_mode);
   
      Reset <= '1', '0' after 10 ns; 
      wait for Clk_period*2;
        --X <= to_signed(-3,16); wait for clk_period*1;
        --X <= to_signed(1,16); wait for clk_period*1;
        --X <= to_signed(0,16); wait for clk_period*1;
        --X <= to_signed(-2,16); wait for clk_period*1;
        --X <= to_signed(-1,16); wait for clk_period*1;
        --X <= to_signed(4,16); wait for clk_period*1;
        --X <= to_signed(-5,16); wait for clk_period*1;
        --X <= to_signed(6,16); wait for clk_period*1;
        --X <= to_signed(0,16);
      report "before loop";
      while not endfile(infile) loop
        report "loop";   
        readline(infile, v_ILINE);
        read(v_ILINE, v_INPUT);   
        X <= to_signed(v_INPUT,16);
        wait for clk_period*1;
        write(v_OLINE,to_integer(signed(Y)));
        writeline(outfile,v_OLINE);   
      end loop;
   
      file_close(infile);
      file_close(outfile);
      wait;
   end process;

END;