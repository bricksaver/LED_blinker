library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity led_blinker_mini_project_zybo7020_tb is
end led_blinker_mini_project_zybo7020_tb;
 
architecture behave of led_blinker_mini_project_zybo7020_tb is
 
  -- 100 MHz = 10 nanoseconds period
  constant c_CLOCK_PERIOD : time := 10 ns; 
 
  signal r_SYS_CLK   : std_logic := '0';
  signal r_RESET     : std_logic := '0';
  signal r_SWITCH    : std_logic := '0';
  signal w_LED_DRIVE : std_logic; 
 
  -- Component declaration for the Unit Under Test (UUT)
  component led_blinker_mini_project_zybo7020 is
    port (
      sys_clk     : in  std_logic;
      i_reset     : in  std_logic;
      i_switch    : in  std_logic;
      o_led_drive : out std_logic);
  end component led_blinker_mini_project_zybo7020;
  
begin
 
  -- Instantiate the Unit Under Test (UUT)
  UUT : led_blinker_mini_project_zybo7020
    port map (
      sys_clk     => r_SYS_CLK,
      i_reset     => r_RESET,
      i_switch    => r_SWITCH,
      o_led_drive => w_LED_DRIVE
      );
 
  p_CLK_GEN : process is
  begin
    wait for c_CLOCK_PERIOD/2;
    r_SYS_CLK <= not r_SYS_CLK;
  end process p_CLK_GEN; 
   
  process                               -- main testing
  begin
  -- Run for 3.75 seconds (because clock freq is so high, just simulate one part from below at at time)
  
    -- test 2HZ frequency signal
    --r_RESET <= '0';
    wait for 100ns; -- wait for new_sys_clk to be stable (locked = '1')
    r_SWITCH <= '0';
    wait for 1 sec;
 
    -- test 4HZ frequency signal
    r_SWITCH <= '1';
    wait for 1 sec;
    
    -- test RESET switch
    r_SWITCH <= '0';
    wait for 0.75 sec;
    r_RESET <= '1';
    wait for 0.01 sec;
    r_RESET <= '0';

  end process;

end behave;
