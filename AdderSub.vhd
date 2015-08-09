LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY AdderSub is 
   PORT( mode          : IN std_logic; -- ou seja, CIN e seletor do modo
          X  			  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          Y   			  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          S 			  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    COUT_ADDERSUB      : OUT std_logic);
END AdderSub;

ARCHITECTURE behavior OF AdderSub is
   component fulladder is
      PORT( cin, x0, y0 : 	IN std_logic;
            s0, cout : 		OUT std_logic);
   END component;

   signal C1, C2, C3, C4				 : std_logic; --Carries intermediários
   signal X0_XOR, X1_XOR, X2_XOR, X3_XOR : std_logic;

BEGIN
   X0_XOR <= Y(0) XOR mode;
   X1_XOR <= Y(1) XOR mode;
   X2_XOR <= Y(2) XOR mode;
   X3_XOR <= Y(3) XOR mode;

   FA0: fulladder PORT map(X(0), X0_XOR, mode,S(0), C1);  -- S0
   FA1: fulladder PORT map(X(1), X1_XOR, C1,  S(1), C2);  -- S1
   FA2: fulladder PORT map(X(2), X2_XOR, C2,  S(2), C3);  -- S2
   FA3: fulladder PORT map(X(3), X3_XOR, C3,  S(3), C4);  -- S3

   COUT_ADDERSUB <= C3 XOR C4;
END behavior;