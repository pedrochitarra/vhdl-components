library IEEE;
use IEEE.std_logic_1164.all;
-------------------------------------------
entity FSMRelo is
	port
	(
		-- Portas de entrada
		B: in std_logic;
		clear: in std_logic;
		clk: in std_logic;
		
		--Portas de saida
		S1: out std_logic;
		S0: out std_logic;
		visor: out std_logic_vector (6 downto 0)
		
	);
end FSMRelo;
-------------------------------------------
architecture FSM2 of FSMRelo is
		--Declarações
		type estado is (HOrA,ALAr,CrOn,dAtA);
		signal estado_atual, proximo_estado: estado;
		-------------------------------------------
begin
		sequencial:
		process(clear,clk) is
			--Declarações
		begin 
			if(clear='1')then
				--Sentenças sequenciais assincronas
				estado_atual<=HOrA;
			elsif (rising_edge(clk)) then
				--Sentenças sequenciais sincronas
				estado_atual<= proximo_estado;
			end if;
		end process;
		-------------------------------------------
		
		combinacional:
		process(B,estado_atual) is
			--Declarações
		begin
			--Sentenças sequenciais
			case estado_atual is
				when HOrA=>
					if (B='1') then
						S1<='0';
						S0<='0';
						
						visor<= "0110111" after 500 ms;
						
						visor<="1111110" after 500 ms;
						 
						visor<="0000101" after 500 ms;
						 
						visor<="1110111" after 500 ms;
						 
						visor<="0000000" after 500 ms;
						proximo_estado<=ALAr;
					else
						S1<='0';
						S0<='0';
						 
						visor<= "0110111" after 500 ms;
						 
						visor<="1111110" after 500 ms;
						 
						visor<="0000101" after 500 ms;
						 
						visor<="1110111" after 500 ms;
						 
						visor<="0000000" after 500 ms;
						proximo_estado<=HorA;
					end if;
				when ALAr=>
					if (B='1') then
						S1<='0';
						S0<='1';
						 
						visor<= "1110111" after 500 ms;
						 
						visor<= "0001110" after 500 ms;
						 
						visor<= "1110111" after 500 ms;
						 
						visor<= "0000101" after 500 ms;
						 
						visor<="0000000" after 500 ms;
						proximo_estado<=CrOn;
					else
						S1<='0';
						S0<='1';
						 
						visor<= "1110111" after 500 ms;
						 
						visor<= "0001110" after 500 ms;
						 
						visor<= "1110111" after 500 ms;
						 
						visor<= "0000101" after 500 ms;
						 
						visor<="0000000" after 500 ms;
						proximo_estado<=ALAr;
					end if;
				when CrOn=> 
					if (B='1') then
						S1<='1';
						S0<='0';
						 
						visor<="1001110" after 500 ms;
						 
						visor<="0000101" after 500 ms;
						 
						visor<="1111110" after 500 ms;
						 
						visor<="0010101" after 500 ms;
						 
						visor<="0000000" after 500 ms;
						proximo_estado<=dAtA;
					else
						S1<='1';
						S0<='1';
						 
						visor<="1001110" after 500 ms;
						 
						visor<="0000101" after 500 ms;
						 
						visor<="1111110" after 500 ms;
						 
						visor<="0010101" after 500 ms;
						 
						visor<="0000000" after 500 ms;
						proximo_estado<=CrOn;
					end if;
				when dAtA=>
					if(B='1') then
						S1<='1';
						S0<='1';
						 
						visor<="0111101" after 500 ms;
						 
						visor<="1110111" after 500 ms;
						 
						visor<="0001111" after 500 ms;
						 
						visor<="1110111" after 500 ms;
						 
						visor<="0000000" after 500 ms;
						proximo_estado<=HOrA;
					else
						S1<='1';
						S0<='1';
						 
						visor<="0111101" after 500 ms;
						 
						visor<="1110111" after 500 ms;
						 
						visor<="0001111" after 500 ms;
						 
						visor<="1110111" after 500 ms;
						 
						visor<="0000000" after 500 ms;
						proximo_estado<=dAtA;
					end if;
			end case;
		end process;
	end FSM2;