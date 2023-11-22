-- This program blinks all LEDs on an 8x8 LED Dot Matrix Display 
-- Written by Rasoul Keshavarzi, Winter 2022 term 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stationary is 
	port(CLOCK_50_B5B:	in  std_logic ;    -- 50MHz clock on the board 
		 GPIO:			out std_logic_vector(35 downto 0)); 
end entity stationary; 

Architecture main of stationary is 
signal counter: unsigned(24 downto 0); 
signal fullrefresh: integer range 0  to 7:= 0;
signal refreshcheck: std_logic:= '0';
signal rowchange: integer range 0  to 7:= 0;
signal row_driver: std_logic_vector(0 to 7):= "10000000"; 
signal col_driver: std_logic_vector(0 to 7) := "01111111"; 
begin


--fullrefresh<= fullrefresh+1 when rising_edge(counter(24));
--refreshcheck<= '1' when fullrefresh = 0 else '0';
rowchange<= rowchange+1 when rising_edge(counter(12));
counter <= counter + 1 when rising_edge(CLOCK_50_B5B); 
col_driver <=  col_driver(7) & col_driver(0 to 6) when rising_edge(counter(12)); 

with rowchange select
row_driver<=  "00111110" when 0,
				  "01000001" when 1,
				  "01000101" when 2,
				  "01000101" when 3,
				  "00100111" when 4,
				  "00000000" when 5,
				  "00000000" when 6,
				  "00000000" when others;




GPIO( 0) <= row_driver(0);	GPIO( 1) <= row_driver(0); 	-- Pin connections between GPIO port and the PCB 
GPIO( 2) <= row_driver(1);	GPIO( 3) <= row_driver(1); 
GPIO( 4) <= row_driver(2);	GPIO( 5) <= row_driver(2); 
GPIO( 6) <= row_driver(3);	GPIO( 7) <= row_driver(3); 
GPIO( 8) <= row_driver(4);	GPIO( 9) <= row_driver(4); 
GPIO(10) <= row_driver(5);	GPIO(11) <= row_driver(5); 
GPIO(12) <= row_driver(6);	GPIO(13) <= row_driver(6); 
GPIO(14) <= row_driver(7);	GPIO(15) <= row_driver(7); 

GPIO(20) <= col_driver(0);	GPIO(21) <= col_driver(0); 
GPIO(22) <= col_driver(1);	GPIO(23) <= col_driver(1); 
GPIO(24) <= col_driver(2);	GPIO(25) <= col_driver(2); 
GPIO(26) <= col_driver(3);	GPIO(27) <= col_driver(3); 
GPIO(28) <= col_driver(4);	GPIO(29) <= col_driver(4); 
GPIO(30) <= col_driver(5);	GPIO(31) <= col_driver(5); 
GPIO(32) <= col_driver(6);	GPIO(33) <= col_driver(6); 
GPIO(34) <= col_driver(7);	GPIO(35) <= col_driver(7); 
end architecture main; 
