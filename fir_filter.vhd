library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mytypes_pkg.all;


entity fir_filter is
  generic (
    coeffs    : my_array_t := (0.0135,0.0785,0.2409,0.3344,0.2409,0.0785,0.0135);
    N         : integer    := 16;
    NUM_S0    : integer    := 3;
    NUM_S1    : integer    := 2
  );
  port (
    clock     : in  std_logic;
    reset     : in  std_logic;
    -- coefficient
   -- C0        : in  std_logic_vector(N-1 downto 0);
   -- C1        : in  std_logic_vector(N-1 downto 0);
   -- C2        : in  std_logic_vector(N-1 downto 0);
   -- C3        : in  std_logic_vector(N-1 downto 0);  
   -- C4        : in  std_logic_vector(N-1 downto 0);
   -- C5        : in  std_logic_vector(N-1 downto 0);
   -- C6        : in  std_logic_vector(N-1 downto 0);
    -- data input
    x         : in  std_logic_vector(N-1 downto 0);
    -- filtered data  -----still to size-------------------------------------------------------------------------------
    y         : out std_logic_vector(2*N+3 downto 0)   
  );
end fir_filter;
architecture rtl of fir_filter is
  constant NUM_TAPS : natural := coeffs'length;
  signal r_coeff              : t_coeff ;
  signal data                 : t_data;
  signal r_mult               : t_mult;
  signal r_add_st0            : t_add_st0;
  signal r_add_st1            : t_add_st1;
  signal r_add_st2            : signed(2*N+2  downto 0);                    --last step of addition we have a single one
  begin
  p_input : process (reset,clock)
  begin
    if(reset='0') then
      data         <= (others=>(others=>'0'));                              --at reset we put to 0 all coeff and stored inputs
      r_coeff      <= (others=>(others=>'0'));
    elsif(rising_edge(clock)) then
      data      <= signed(x)&data(0 to data'length-2);                      --shift right and add new input to vector data
      for i in 0 to NUM_TAPS-1 loop------------------------------------------MAy be to remove -----------------------------------------------------------------
        r_coeff(i) <= coeffs(i);
      end loop;
    end if;
  end process p_input;
  ------MULTIPLICATION----------------------------------------------------
  p_mult : process (reset,clock)
  begin
    if(reset='0') then
      r_mult       <= (others=>(others=>'0'));                             --reset mul signal bit
    elsif(rising_edge(clock)) then
      for k in 0 to NUM_TAPS-1 loop
        r_mult(k)  <= data(k) * r_coeff(k);                                --multiply each input data with the correspondent coefficient
      end loop;
    end if;
  end process p_mult;
  ------STEP 0------------------------------------------------------------
  p_add_st0 : process (reset,clock)                                       --first step addition
  begin
    if(reset='0') then
      r_add_st0     <= (others=>(others=>'0'));
    elsif(rising_edge(clock)) then
      for k in 0 to NUM_S0-1 loop
                                                                          --addition of a multiplication result with his neighbor
        r_add_st0(k)     <= resize(r_mult(2*k),2*N+1)  + resize(r_mult(2*k+1),2*N+1);
      end loop;
      r_add_st0(NUM_S0)  <= resize(r_mult(NUM_TAPS-1),2*N+1);             --extend the last input, we have an odd number of inputs
    end if;
  end process p_add_st0;
  ------STEP 1------------------------------------------------------------
  p_add_st1 : process (reset,clock)                                       --second step addition
  begin
    if(reset='0') then
      r_add_st1     <= (others=>(others=>'0'));
    elsif(rising_edge(clock)) then
      for k in 0 to NUM_S1-1 loop
        r_add_st1(k)     <= resize(r_add_st0(2*k),2*N+2)  + resize(r_add_st0(2*k+1),2*N+2);
      end loop;
    end if;
  end process p_add_st1;
  ------STEP 2------------------------------------------------------------
  p_add_st2 : process (reset,clock)
  begin
    if(reset='0') then
      r_add_st2     <= (others=>'0');
    elsif(rising_edge(clock)) then
      r_add_st2     <= resize(r_add_st1(0),2*N+3)  + resize(r_add_st0(1),2*N+3);
    end if;
  end process p_add_st2;
  ------OUTPUT------------------------------------------------------------
  p_output : process (reset,clock)
  begin
    if(reset='0') then
      y     <= (others=>'0');
    elsif(rising_edge(clock)) then
      y     <= std_logic_vector(r_add_st2);
    end if;
  end process p_output;
end rtl;
