LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity somador is
port (cin : in std_logic;
		x,y : in std_logic_vector (3 down to 0);
		s   : out std_logic_vector (3 down to 0);
		cout: out std_logic);
end somador;

architecture structure of somador is
	signal c1,c2,c3 : std_logic;
	component fulladder
		port (cin, x, y: in std_logic;
				s, count : out std_logic);
		end component;
signal z1,z2,z3,z4 std_logic;
begin
	z1
		