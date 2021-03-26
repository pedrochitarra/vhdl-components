library IEEE;
use IEEE.std_logic_1164.all;
------------------------------------------
entity Semaforo is
	port
	(
		-- Portas de entrada
		
		clear: in std_logic;
		clk: in std_logic;
		
		--Portas de saida
		AMARELO: out std_logic;
		VERMELHO: out std_logic;
		VERDE: out std_logic
		
	);
end Semaforo;
----------------------------------------------
architecture FSM of Semaforo is
		--Declarações
		type estado is (AMA,VRM,VRD);
		signal estado_atual, proximo_estado: estado;
		signal aux_sem: std_logic_vector (3 downto 0):=(others=>'0');
begin
		---------------------------------
		sequencial:
		process(clear,clk) is
			--Declarações
		begin 
			if(clear='1')then
				--Sentenças sequenciais assincronas
				estado_atual<=VRM;
			elsif (rising_edge(clk)) then
				--Sentenças sequenciais sincronas
				case aux_sem is
					when "0001" =>
					aux_sem <= "0010";
					when "0010" =>
					aux_sem <= "0011";
					when "0011" =>
					aux_sem <= "0100";
					when "0100" =>
					aux_sem <= "0101";
					when "0101" =>
					aux_sem <= "0110";
					when "0110" =>
					aux_sem <= "0111";
					when "0111" =>
					aux_sem <= "1000";
					when "1000" =>
					aux_sem <= "1001";
					when "1001" =>
					aux_sem <= "1010";
					when "1010" =>
					aux_sem <= "1011";
					when "1011" =>
					aux_sem <= "1100";
					when "1100" =>
					aux_sem <= "1101";
					when "1101" =>
					aux_sem <= "1110";
					when "1110" =>
					aux_sem <= "0001";
					when others =>
					aux_sem <= "0000";
					end case;
					
				estado_atual<= proximo_estado;
			end if;
		end process;
		---------------------------------
		combinacional:
		process(clk,estado_atual,aux_sem) is
			--Declarações
		begin
			--Sentenças sequenciais
			case estado_atual is
				when VRM=>
					if(aux_sem = "0001") then
						VERDE<='0';
						AMARELO<='0';
						VERMELHO<='1';
						proximo_estado<=VRM;
					elsif (aux_sem = "0010") then
						VERDE<='0';
						AMARELO<='0';
						VERMELHO<='1';
						proximo_estado<=VRM;
					elsif (aux_sem = "0011") then
						VERDE<='0';
						AMARELO<='0';
						VERMELHO<='1';
						proximo_estado<=VRM;
					elsif (aux_sem = "0100") then
						VERDE<='0';
						AMARELO<='0';
						VERMELHO<='1';
						proximo_estado<=VRM;
					elsif (aux_sem = "0101") then
						VERDE<='0';
						AMARELO<='0';
						VERMELHO<='1';
						proximo_estado<=VRD;
					else
						VERDE<='0';
						AMARELO<='0';
						VERMELHO<='1';
						proximo_estado<=VRM;
					end if;
					
				when VRD=>
					if (aux_sem = "0101") then
						VERDE<='1';
						AMARELO<='0';
						VERMELHO<='0';
						proximo_estado<=VRD;
					elsif (aux_sem = "0111") then
						VERDE<='1';
						AMARELO<='0';
						VERMELHO<='0';
						proximo_estado<=VRD;
					elsif (aux_sem = "1000") then
						VERDE<='1';
						AMARELO<='0';
						VERMELHO<='0';
						proximo_estado<=VRD;
					elsif (aux_sem = "1001") then
						VERDE<='1';
						AMARELO<='0';
						VERMELHO<='0';
						proximo_estado<=VRD;
					elsif (aux_sem = "1010") then
						VERDE<='1';
						AMARELO<='0';
						VERMELHO<='0';
						proximo_estado<=VRD;
					elsif (aux_sem = "1011") then
						VERDE<='1';
						AMARELO<='0';
						VERMELHO<='0';
						proximo_estado<=VRD;
					elsif (aux_sem = "1100") then
						VERDE<='1';
						AMARELO<='0';
						VERMELHO<='0';
						proximo_estado<=AMA;
					else 
						VERDE<='1';
						AMARELO<='0';
						VERMELHO<='0';
						proximo_estado<=VRD;
					end if;
					
				when AMA=>
					if (aux_sem = "1101") then
						VERDE<='0';
						AMARELO<='1';
						VERMELHO<='0';
						proximo_estado<=AMA;
					elsif (aux_sem = "1110") then
						VERDE<='0';
						AMARELO<='1';
						VERMELHO<='0';
						proximo_estado<=VRM;
					else 
						VERDE<='1';
						AMARELO<='0';
						VERMELHO<='0';
						proximo_estado<=AMA;
					end if;
					
				when others =>
						VERDE<='1';
						AMARELO<='1';
						VERMELHO<='1';
						proximo_estado<=VRM;
						
			end case;
		end process;
	end FSM;
		