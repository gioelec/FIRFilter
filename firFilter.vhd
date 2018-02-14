library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

constant C0:=0.0135;
constant C1:=0.0785;
constant C2:=0.2409;
constant C3:=0.3344;
constant C4:=0.2409;
constant C5:=0.0785;
constant C6:=0.0135;
entity fir_filter is
port (
  clock       : in  std_logic;
  reset       : in  std_logic;
  -- coefficient
  C0   : in  std_logic_vector( 15 downto 0);
  C1   : in  std_logic_vector( 15 downto 0);
  C2   : in  std_logic_vector( 15 downto 0);
  C3   : in  std_logic_vector( 15 downto 0);  
  C4   : in  std_logic_vector( 15 downto 0);
  C5   : in  std_logic_vector( 15 downto 0);
  C6   : in  std_logic_vector( 15 downto 0);
  -- data input
  input_data      : in  std_logic_vector( 15 downto 0);
  -- filtered data 
  y       : out std_logic_vector( 9 downto 0));
end fir_filter;
