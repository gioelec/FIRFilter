
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use work.mytypes_pkg.all;
use std.textio.all;  --include package textio.vhd
use ieee.std_logic_textio.all;
use IEEE.MATH_REAL.ALL;

library work;
use work.all;
entity TB is
end TB;
architecture TB_arc of TB is
	--component declaration of the unit under testing UUT
	component fir_filter is
		port (
			Clk: in std_ulogic := '0';
	        Reset: in std_ulogic := '1';
	        X: in std_logic_vector(N-1 downto 0) := (others => '0');
	        Y: out std_logic_vector(N-1 downto 0) := (others => '0')
		);
	end component fir_filter;
	--signals declaration
	--input signals
	signal Clk: std_ulogic := '0';
	signal Reset: std_ulogic := '1';
	signal X: std_logic_vector(N-1 downto 0) := (others => '0');
	--output signals
	signal Y: std_logic_vector(N-1 downto 0) := (others => '0');
	--constant declaration
	constant CLK_PERIOD : time := 100 ns;
	constant input    : my_array_in := (
						std_logic_vector(to_signed(0,N)),
						std_logic_vector(to_signed(3271,N)),
						std_logic_vector(to_signed(6510,N)),
						std_logic_vector(to_signed(9684,N)),
						std_logic_vector(to_signed(12760,N)),
						std_logic_vector(to_signed(15710,N)),	
						std_logic_vector(to_signed(18502,N)),	
						std_logic_vector(to_signed(21110,N)),	
						std_logic_vector(to_signed(23506,N)),	
						std_logic_vector(to_signed(25668,N)),	
						std_logic_vector(to_signed(27573,N)),	
						std_logic_vector(to_signed(29203,N)),	
						std_logic_vector(to_signed(30541,N)),	
						std_logic_vector(to_signed(31574,N)),	
						std_logic_vector(to_signed(32291,N)),	
						std_logic_vector(to_signed(32686,N)),	
						std_logic_vector(to_signed(32754,N)),	
						std_logic_vector(to_signed(32495,N)),	
						std_logic_vector(to_signed(31911,N)),	
						std_logic_vector(to_signed(31008,N)),	
						std_logic_vector(to_signed(29796,N)),	
						std_logic_vector(to_signed(28286,N)),	
						std_logic_vector(to_signed(26493,N)),	
						std_logic_vector(to_signed(24435,N)),	
						std_logic_vector(to_signed(22134,N)),	
						std_logic_vector(to_signed(19611,N)),	
						std_logic_vector(to_signed(16892,N)),	
						std_logic_vector(to_signed(14004,N)),	
						std_logic_vector(to_signed(10977,N)),	
						std_logic_vector(to_signed(7840,N)),
						std_logic_vector(to_signed(4624,N)),
						std_logic_vector(to_signed(1363,N)),
						std_logic_vector(to_signed(-1913,N)),
						std_logic_vector(to_signed(-5169,N)),
						std_logic_vector(to_signed(-8374,N)),
						std_logic_vector(to_signed(-11494,N)),	
						std_logic_vector(to_signed(-14501,N)),	
						std_logic_vector(to_signed(-17362,N)),	
						std_logic_vector(to_signed(-20049,N)),	
						std_logic_vector(to_signed(-22537,N)),	
						std_logic_vector(to_signed(-24799,N)),	
						std_logic_vector(to_signed(-26813,N)),	
						std_logic_vector(to_signed(-28560,N)),	
						std_logic_vector(to_signed(-30021,N)),	
						std_logic_vector(to_signed(-31182,N)),	
						std_logic_vector(to_signed(-32032,N)),	
						std_logic_vector(to_signed(-32561,N)),	
						std_logic_vector(to_signed(-32765,N)),	
						std_logic_vector(to_signed(-32642,N)),	
						std_logic_vector(to_signed(-32193,N)),	
						std_logic_vector(to_signed(-31422,N)),	
						std_logic_vector(to_signed(-30337,N)),	
						std_logic_vector(to_signed(-28949,N)),	
						std_logic_vector(to_signed(-27272,N)),	
						std_logic_vector(to_signed(-25322,N)),	
						std_logic_vector(to_signed(-23119,N)),	
						std_logic_vector(to_signed(-20685,N)),	
						std_logic_vector(to_signed(-18045,N)),	
						std_logic_vector(to_signed(-15224,N)),	
						std_logic_vector(to_signed(-12251,N)),	
						std_logic_vector(to_signed(-9156,N)),
						std_logic_vector(to_signed(-5969,N)),
						std_logic_vector(to_signed(-2723,N))
						);
	begin
		myFIR: fir_filter port map(Clk=>Clk,Reset=>Reset,X=>X,Y=>Y);		--instantiating the UUT
		Clk <= not Clk after CLK_PERIOD*1/2;								--Clk is driven concurrently
		drive : process 
			variable i          : integer:=0;
			begin
				Reset <= '1' after 10 ns;
      			wait until rising_edge(clk);
      			Reset <= '0' after 10 ns;
				--file_open(f,file_name,read_mode);
				--while not endfile(f) loop
				--	readline(f, l);       --reading a line from the file.
  --reading the data from the line and putting it in a real type variable.
				--	read(l,b);
				--	X <=signed(b);
				  --  wait for CLK_PERIOD*1;
				--end loop;
				--file_close(f);
				for i in 0 to Ninput-1 loop
					X <= input(i); wait for CLK_PERIOD*1;
				end loop;		
				wait;
		end process drive;	
		--commit: process(Y)
		  --  constant file_name  : string :=  "C:\Users\gioel\output.txt";  
			--variable l: line;
			--file outfile: text is out file_name;
			--begin
			--	write(l,std_logic_vector(Y));
			--	writeline(outfile,l);
			--file_close(outfile);
		--end process commit;
end TB_arc;
	--variable input    : my_array_in := (std_logic_vector(to_signed(0,N)),std_logic_vector(to_signed(3271,N)),std_logic_vector(to_signed(6510,N)),std_logic_vector(to_signed(9684,N)),std_logic_vector(to_signed(12760,N)));--	std_logic_vector(to_signed(15710	std_logic_vector(to_signed(18502	std_logic_vector(to_signed(21110	std_logic_vector(to_signed(23506	std_logic_vector(to_signed(25668	std_logic_vector(to_signed(27573	std_logic_vector(to_signed(29203	std_logic_vector(to_signed(30541	std_logic_vector(to_signed(31574	32291	32686	32754	32495	31911	31008	29796	28286	26493	24435	22134	19611	16892	14004	10977	7840	4624	1363	-1913	-5169	-8374	-11494	-14501	-17362	-20049	-22537	-24799	-26813	-28560	-30021	-31182	-32032	-32561	-32765	-32642	-32193	-31422	-30337	-28949	-27272	-25322	-23119	-20685	-18045	-15224	-12251	-9156	-5969	-2723
