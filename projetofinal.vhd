LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY projetofinal IS
PORT 	(X1								: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 X2								: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 somador							: IN STD_LOGIC;
		 subtrator						: IN STD_LOGIC;
		 modulo							: IN STD_LOGIC;
		 salvar							: IN STD_LOGIC;
		 carregar						: IN STD_LOGIC;
		 LED1								: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 LED2								: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 LED3								: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 LED_SALVO                 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 SINAL_DE_MENOS            : OUT STD_LOGIC_VECTOR(0 TO 3) -- 0: X1, 1: X2, 2: Resultado, 3: salvo
		);
END projetofinal;

ARCHITECTURE behavior OF projetofinal IS
	COMPONENT bcd
		PORT 	(S													: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				 F													: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT AdderSub is 
   PORT( mode             : IN std_logic;
          X  			  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          Y   			  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          S 			  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
                  COUT_ADDERSUB : OUT std_logic);
END COMPONENT;

	signal overflow		 : std_logic; --deu ruim
	signal mode				 : std_logic; --0: soma || 1: sub
	signal ONOFF 			 : std_logic; --BCD ligado?
	signal resultado		 : std_logic_vector(3 DOWNTO 0);
	signal LED3_aux				 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	signal sinal_resultado : std_logic;
	signal LED1_aux       : STD_LOGIC_VECTOR(6 DOWNTO 0);
	signal salvo			 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	signal sinal_salvo    : std_logic;
	signal is_it_salvo    : std_logic;
BEGIN
		process(mode, somador, subtrator) begin
			IF (subtrator = '1') THEN
				mode <= '1';
			ELSE
				mode <= '0';
			END IF;
		end process;
		
			
		stage0: bcd port map(X1, LED1_aux);
		stage1: bcd port map(X2, LED2);
		stage2: AdderSub port map(mode, X1, X2, resultado, overflow);
		stage3: bcd port map(resultado, LED3_aux);
		
		ONOFF <= somador OR subtrator OR modulo;
		SINAL_DE_MENOS(0) <= NOT(X1(3));
		SINAL_DE_MENOS(1) <= NOT(X2(3));
		
		process(ONOFF, overflow, modulo, salvar) begin
			IF (ONOFF = '0') THEN
				LED3(0) <= '1'; LED3(1) <= '1'; LED3(2) <= '1'; LED3(3) <= '1'; LED3(4) <= '1'; LED3(5) <= '1'; LED3(6) <= '1';
				
			ELSIF (modulo = '1') THEN
				SINAL_DE_MENOS(2) <= '1';
				LED3 <= LED1_aux;
			
			ELSIF (overflow = '1') THEN
				LED3(0) <= '0'; LED3(1) <= '0'; LED3(2) <= '0'; LED3(3) <= '0'; LED3(4) <= '1'; LED3(5) <= '1'; LED3(6) <= '0';
			
			ELSE
				LED3 <= LED3_aux;
				SINAL_DE_MENOS(2) <= NOT(resultado(3) AND ONOFF AND NOT overflow);
			END IF;
			----------------
			IF (modulo = '0') THEN
				SINAL_DE_MENOS(2) <= NOT(resultado(3) AND ONOFF AND NOT overflow);
			END IF;
			----------------
			IF (salvar = '1' AND ONOFF = '1') THEN
				IF (modulo = '1') THEN
					sinal_salvo <= '1';
					salvo <= LED1_aux;
					is_it_salvo <= '1';
				ELSIF (overflow = '0') THEN
					sinal_salvo <= NOT(resultado(3) AND ONOFF AND NOT overflow);
					salvo <= LED3_aux;
					is_it_salvo <= '1';
				END IF;
			END IF;
			
			IF (carregar = '1' AND is_it_salvo = '1') THEN
				LED_SALVO <= salvo;
				SINAL_DE_MENOS(3) <= sinal_salvo;
			ELSIF (carregar = '1' AND is_it_salvo = '0') THEN
				LED_SALVO(0) <= '1'; LED_SALVO(1) <= '1'; LED_SALVO(2) <= '1'; LED_SALVO(3) <= '1'; LED_SALVO(4) <= '1'; LED_SALVO(5) <= '1'; LED_SALVO(6) <= '1';
			END IF;
				
			LED1 <= LED1_aux;
		end process;
				
END behavior;