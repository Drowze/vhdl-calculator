LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bcd IS
	PORT 	(S													: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 F													: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END bcd;

ARCHITECTURE Behavor OF bcd IS

BEGIN
	WITH S SELECT
		F<=	"0000001" WHEN "0000", --0
		
				"1001111" WHEN "0001", --1
				"0010010" WHEN "0010", --2
				"0000110" WHEN "0011", --3
				"1001100" WHEN "0100", --4
				"0100100" WHEN "0101", --5
				"0100000" WHEN "0110", --6
				"0001111" WHEN "0111", --7
				
				"1001111" WHEN "1111", --(-1)
				"0010010" WHEN "1110", --(-2)
				"0000110" WHEN "1101", --(-3)
				"1001100" WHEN "1100", --(-4)
				"0100100" WHEN "1011", --(-5)
				"0100000" WHEN "1010", --(-6)
				"0001111" WHEN "1001", --(-7)
				"0000000" WHEN "1000", --(-8)
				
				"0110000" WHEN OTHERS; --E
END Behavor;