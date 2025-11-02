library ieee;
use ieee.std_logic_1164.all;

entity traffic_light_circuit is

generic ( clkFrequency : integer );

	port(
	clk       : in  std_logic;
	btn	      : in  std_logic;    
	rst_n     : in  std_logic;
	Red_R     : out std_logic;
	Yellow_R  : out std_logic;
	Green_R   : out std_logic;
	Red_P	  : out std_logic;
	Green_P	  : out std_logic);
	
end entity;

architecture tfcarch of traffic_light_circuit is

	type light_t is (RedR_RedP,YellowR_RedP,GreenR_RedP,
	YellowR_RedP2,RedR_RedP2,RedR_GreenP);
	signal light_s : light_t;
	signal counter : integer range 0 to clkFrequency*60;


begin

	process (clk) is
	
	begin 
		if(rst_n = '0') then
			
			light_s   <= RedR_RedP;
			counter   <= 0;
			Red_R     <='1';
			Yellow_R  <='0';
			Green_R   <='0';
			Red_P	  <='1';
			Green_P   <='0';
			
		elsif rising_edge(clk) then
			
			counter <= counter + 1;
			
			case light_s is
			
				when RedR_RedP =>
					Red_R     <='1';
					Yellow_R  <='0';
					Green_R   <='0';
					Red_P	  <='1';
					Green_P   <='0';

					if rising_edge(btn) then
						counter <= 0;
						light_s <= RedR_RedP2;
					end if;

					if (counter >= clkFrequency * 30 - 1) then
						counter <= 0;
						light_s <= YellowR_RedP;
					end if;
				
				when YellowR_RedP =>
					Red_R     <='0';
					Yellow_R  <='1';
					Green_R   <='0';
					Red_P	  <='1';
					Green_P   <='0';

					if rising_edge(btn) then
						counter <= 0;
						light_s <= YellowR_RedP2;
					end if;

					if(counter >= clkFrequency *3 - 1) then
						counter <= 0;
						light_s <= GreenR_RedP;
					end if;
					
				when GreenR_RedP =>
					Red_R     <='0';
					Yellow_R  <='0';
					Green_R   <='1';
					Red_P	  <='1';
					Green_P   <='0';

					if rising_edge(btn) then
						counter <= 0;
						light_s <= YellowR_RedP2;
					end if;

					if(counter >= clkFrequency *27 - 1) then
						counter <= 0;
						light_s <= YellowR_RedP2;
					end if;
					
				when YellowR_RedP2 =>
					Red_R     <='0';
					Yellow_R  <='1';
					Green_R   <='0';
					Red_P	  <='1';
					Green_P   <='0';

					if rising_edge(btn) then
						counter <= 0;
						light_s <= YellowR_RedP2;
					end if;

					if(counter >= clkFrequency *3 - 1) then
						counter <= 0;
						light_s <= RedR_RedP2;
						
					end if;

				when RedR_RedP2 =>
					Red_R     <='1';
					Yellow_R  <='0';
					Green_R   <='0';
					Red_P	  <='1';
					Green_P   <='0';

					if rising_edge(btn) then
						counter <= 0;
						light_s <= YellowR_RedP2;
					end if;

					if(counter >= clkFrequency *5 - 1) then
						counter <= 0;
						light_s <= RedR_GreenP;
						
					end if;

				when RedR_GreenP =>
					Red_R     <='1';
					Yellow_R  <='0';
					Green_R   <='0';
					Red_P	  <='0';
					Green_P   <='1';

					if rising_edge(btn) then
						counter <= 0;
						light_s <= YellowR_RedP2;
					end if;

					if(counter >= clkFrequency *10 - 1) then
						counter <= 0;
						light_s <= RedR_RedP;
						
					end if;
			end case;
		end if;
	end process;
	
	process 
	
end architecture;
						
					
				
				
