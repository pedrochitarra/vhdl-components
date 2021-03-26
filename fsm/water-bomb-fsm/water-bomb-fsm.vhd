library IEEE;
use IEEE.std_logic_1164.all;
------------------------------------------
entity FSMAgua is
	port
	(
		-- Portas de entrada
		BOMBA: in std_logic;
		AQUECE: in std_logic;
		VALV: in std_logic;
		clear: in std_logic;
		clk: in std_logic;
		
		--Portas de saida
		NMAX: out std_logic;
		STEMP: out std_logic;
		NMIN: out std_logic
		
	);
end FSMAgua;
----------------------------------------------
architecture FSM of FSMAgua is
		--Declarações
		type estado is (E1,E2,E3);
		signal estado_atual, proximo_estado: estado;
begin
		---------------------------------
		sequencial:
		process(clear,clk) is
			--Declarações
		begin 
			if(clear='1')then
				--Sentenças sequenciais assincronas
				estado_atual<=E1;
			elsif (rising_edge(clk)) then
				--Sentenças sequenciais sincronas
				estado_atual<= proximo_estado;
			end if;
		end process;
		---------------------------------
		combinacional:
		process(BOMBA,AQUECE,VALV,estado_atual) is
			--Declarações
		begin
			--Sentenças sequenciais
			case estado_atual is
				when E1=>
					if(BOMBA='1') then
						NMAX<='0';
						STEMP<='0';
						NMIN<='1';
						proximo_estado<=E2;
					else
						NMAX<='0';
						STEMP<='0';
						NMIN<='1';
						proximo_estado<=E1;
					end if;
				when E2=>
					if(AQUECE='1') then
						NMAX<='1';
						STEMP<='0';
						NMIN<='0';
						proximo_estado<=E3;
					else
						NMAX<='1';
						STEMP<='0';
						NMIN<='0';
						proximo_estado<=E2;
					end if;
				when E3=> 
					if(VALV='1')then
						NMAX<='1';
						STEMP<='1';
						NMIN<='0';
						proximo_estado<=E1;
					else 
						NMAX<='1';
						STEMP<='1';
						NMIN<='0';
						proximo_estado<=E3;
					end if;
			end case;
		end process;
	end FSM;
		