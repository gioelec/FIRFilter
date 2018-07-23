library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.mytypes_pkg.all;
use IEEE.MATH_REAL.ALL;

entity fir_filter is
  generic (
    coeffs    : my_array_t := (std_logic_vector(to_signed(442,N)),std_logic_vector(to_signed(2572,N)),std_logic_vector(to_signed(7894,N)),std_logic_vector(to_signed(10958,N)),std_logic_vector(to_signed(7894,N)),std_logic_vector(to_signed(2572,N)),std_logic_vector(to_signed(442,N)))-------------------------------------------------(0.0135,0.0785,0.2409,0.3344,0.2409,0.0785,0.0135)
  );
port (
	Clk: 	in std_logic; 
	Reset:  in std_logic;
	X:		in std_logic_vector(N-1 downto 0);
	Y: 		out std_logic_vector(N-1 downto 0)
);		
end entity fir_filter;	
architecture Behavioral of fir_filter is
component dff_n is
	port (
		Clk:   in std_logic;
		Reset: in std_logic;
		d:	   in std_logic_vector(N-1 downto 0);
		q:	   out std_logic_vector(N-1 downto 0)
	);
end component dff_n;
signal s_coeff:		t_coeff;
signal s_mul:	 	t_mult;
signal q:			t_add;
signal s_add:		t_add;


begin 

  	GEN_MUL: for i in 0 to Nsteps-1 generate
	   	s_coeff(i) <= coeffs(i);
	    s_mul(i)   <= std_logic_vector(resize(signed(s_coeff(i))*signed(X),N));
	end generate GEN_MUL;

	GEN_FIR: for i in 0 to Nsteps-1 generate

   		GEN_FIRST: if i = 0 generate
   			DFFI : dff_n port map (Clk,Reset,s_mul(6),q(0));--s_mul(Nsteps-1)
   			s_add(0)<= std_logic_vector(signed(resize(signed(q(0))+signed(s_mul(5)),N)));
   		end generate GEN_FIRST;

	    GEN_ADD: if i >= 2 generate  --There isn't the first add operation, hence we only have 6 istances of s_add(i)
	   		DFFI : dff_n port map (Clk,Reset,s_add(i-2),q(i-1));
	   		s_add(i-1) <=   std_logic_vector(signed(resize(signed(q(i-1))+signed(s_mul(Nsteps-1-i)),N)));
   		end generate GEN_ADD;

   	end generate GEN_FIR;
   	FFOUT: dff_n port map (Clk,Reset,s_add(Nsteps-2),Y);
	   
   	--dffIN: dff_n port map (Clk,Reset,X,Xin);
	--dff1 : dff_n port map (Clk,Reset,s_mul(6),q(0));
	--dff2 : dff_n port map (Clk,Reset,s_mul(5),q(1));
	--dff3 : dff_n port map (Clk,Reset,s_mul(4),q(2));
	--dff4 : dff_n port map (Clk,Reset,s_mul(3),q(3));
	--dff5 : dff_n port map (Clk,Reset,s_mul(2),q(4));
	--dff6 : dff_n port map (Clk,Reset,s_mul(1),q(5));

end architecture Behavioral;