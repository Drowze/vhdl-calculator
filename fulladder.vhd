LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fulladder IS

	port 	(cin, x0, y0	: IN BIT;
			 s0, cout		: OUT BIT);
END fulladder;

ARCHITECTURE soma OF fulladder IS
	
BEGIN
	s0 <= (x0 xor y0) xor cin;
	cout <= (x0 and (y0 or cin)) or (cin and y0);
END soma;