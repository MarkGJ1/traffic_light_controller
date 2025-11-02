library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light_circuit_tb is
end entity;

architecture simulation of traffic_light_circuit_tb is

	constant clkFrequency: integer := 100;
	constant clkPeriod : time   := 1000 ms / clkFrequency;
	signal clk      : std_logic := '1';
	signal rst_n    : std_logic := '0';
	signal btn	: std_logic := '0';
	signal Red_R    : std_logic;
	signal Yellow_R : std_logic; 
	signal Green_R  : std_logic;
	signal Red_P	: std_logic;
	signal Green_P  : std_logic; 

begin
	
	tfc_test : entity work.traffic_light_circuit(tfcarch)
	generic map (clkFrequency => clkFrequency)
	port map (
		clk      => clk,
		rst_n    => rst_n,
		btn      => btn,
		Red_R    => Red_R,
		Yellow_R => Yellow_R,
		Green_R  => Green_R,
		Red_P    => Red_P,
		Green_P  => Green_P );
		
	clk <= not clk after clkPeriod / 2;
	
	process is
	begin
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		
		rst_n <= '1';
		
		btn <= not btn after 15000 ms;
		wait until rising_edge(btn);
		btn <= not btn after 2000 ms;
		wait;

	end process;
	
end architecture;



