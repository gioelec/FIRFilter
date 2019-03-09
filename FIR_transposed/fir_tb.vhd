LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb IS
END tb;

ARCHITECTURE behavior OF tb IS 

   signal Clk : std_logic := '0';
   signal Xin : signed(15 downto 0) := (others => '0');
   signal Yout : signed(15 downto 0) := (others => '0');
   constant Clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
   uut: entity work.fir PORT MAP (
          Clk => Clk,
          Xin => Xin,
          Yout => Yout
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
   begin        
      wait for Clk_period*2;
        Xin <= to_signed(-3,16); wait for clk_period*1;
        Xin <= to_signed(1,16); wait for clk_period*1;
        Xin <= to_signed(0,16); wait for clk_period*1;
        Xin <= to_signed(-2,16); wait for clk_period*1;
        Xin <= to_signed(-1,16); wait for clk_period*1;
        Xin <= to_signed(4,16); wait for clk_period*1;
        Xin <= to_signed(-5,16); wait for clk_period*1;
        Xin <= to_signed(6,16); wait for clk_period*1;
        Xin <= to_signed(0,16);
        
      wait;
   end process;

END;