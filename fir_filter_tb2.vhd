library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.mytypes_pkg.all;

--use IEEE.std_logic_unsigned.all;

Entity FIR_tb is
end FIR_tb;
	
Architecture rtl_tb of FIR_tb is
	constant clk_period	: time := 100 ns;
	constant N	: positive := 16;   
	   
	component FIR_filter
	port (
	   Clk   : in std_logic ;  
       Reset : in std_logic ; 
	   x 	 : in signed  (N-1 downto 0);  
	   y   : out signed (N-1 downto 0)
		);
	end component;
	
	signal clkx :std_logic:='0';
	signal x_nx :  signed (N-1 downto 0):=x"0000";
	signal resetx: std_logic:='0';
	signal y_nx: signed (N-1 downto 0):=x"0000";
	
	begin
		clkx <= not clkx after clk_period/2; -- dopo 50 ns si nega il clock finché il test è vero, poi va a zero 
		
		DUT: FIR_filter -- Device Under Test 
		port map(
		x => x_nx,
		Clk=> clkx,
		Reset=>resetx,
		y => y_nx
		); 
	  
	 stimulus: process
		begin
           	resetx <= '0';
			x_nx <= to_signed(-3,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(1,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(0,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(-2,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(-1,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(4,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(-5,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(6,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(-3,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(1,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(0,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(-2,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(-1,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(4,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(-5,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(6,N); wait for CLK_PERIOD*1;
         	x_nx <= to_signed(0,N);
			wait;
		end process;
	end rtl_tb;
		
	