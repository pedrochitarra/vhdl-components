library IEEE;
use IEEE.std_logic_1164.all;
-------------------------------------------
entity ReloMealy is
	port
	(
		-- Portas de entrada
		B: in std_logic;
		clear: in std_logic;
		clk: in std_logic;
		
		--Portas de saida
		S1: out std_logic;
		S0: out std_logic;
		dig1: out std_logic;
		dig2: out std_logic;
		dig3: out std_logic;
		dig4: out std_logic;
		
		visor: out std_logic_vector (6 downto 0);
		bipe: out std_logic
		
	);
end ReloMealy;
-------------------------------------------
architecture FSM2 of ReloMealy is
		--Declarações
		type estado is (HOrA,ALAr,CrOn,dAtA);
		signal estado_atual, proximo_estado: estado;
		signal aux_dig : std_logic_vector(3 downto 0):=(others=>'0');
		-------------------------------------------
begin
		sequencial:
		process(clear,clk,aux_dig) is
			--Declarações
		begin 
			if(clear='1')then
				--Sentenças sequenciais assincronas
				estado_atual<=HOrA;
				aux_dig <= (others=>'0');
			elsif (rising_edge(clk)) then
				--Sentenças sequenciais sincronas
				case aux_dig is
					when "0001" =>
						aux_dig <= "0010";
					when "0010" =>
						aux_dig <= "0100";
					when "0100" =>
						aux_dig <= "1000";
					when "1000" =>
						aux_dig <= "0001";
					when others =>
						aux_dig <= "0000";
				end case;
				estado_atual<= proximo_estado;
			end if;
		dig1<=aux_dig(0);
		dig2<=aux_dig(1);
		dig3<=aux_dig(2);
		dig4<=aux_dig(3);
		end process;
		
		
		-------------------------------------------
		
		combinacional:
		process(B,estado_atual,aux_dig) is
			--Declarações
		begin
			--Sentenças sequenciais
			case estado_atual is
				when HOrA=>
					if (B='1') then
					bipe<='1';
						S1<='0';
						S0<='0';
						if (aux_dig="0001") then
							visor<= "0110111" ;
						elsif (aux_dig="0010") then
							visor<="1111110" ;
						elsif (aux_dig="0100") then
							visor<="0000101" ;
						 elsif (aux_dig<="1000") then
							visor<="1110111" ;
						else
							visor<="0000000";
						 
						end if;
						proximo_estado<=ALAr;
					else
						S1<='0';
						S0<='0';
						if (aux_dig="0001") then
							visor<= "0110111" ;
						elsif (aux_dig="0010") then
							visor<="1111110" ;
						elsif (aux_dig="0100") then
							visor<="0000101" ;
						 elsif (aux_dig="1000") then
							visor<="1110111" ;
						else
							visor<="0000000";
						 
						end if;
						proximo_estado<=HorA;
					end if;
				when ALAr=>
					if (B='1') then
						bipe<='1';
						S1<='0';
						S0<='1';
						if (aux_dig="0001") then
							visor<= "1110111" ;
						elsif (aux_dig="0010") then
							visor<= "0001110" ;
						elsif (aux_dig="0100") then
							visor<= "1110111" ;
						elsif (aux_dig="1000") then
							visor<= "0000101" ;
						else
							visor<="0000000";
						end if;
						proximo_estado<=CrOn;
					else
						S1<='0';
						S0<='1';
						if (aux_dig="0001") then
							visor<= "1110111" ;
						elsif (aux_dig="0010") then
							visor<= "0001110" ;
						elsif (aux_dig="0100") then
							visor<= "1110111" ;
						elsif (aux_dig="1000") then
							visor<= "0000101" ;
						else
							visor<="0000000";
						end if;
						proximo_estado<=ALAr;
					end if;
				when CrOn=> 
					if (B='1') then
						bipe<='1';
						S1<='1';
						S0<='0';
						if (aux_dig="0001") then
							visor<="1001110" ;
						elsif (aux_dig="0010") then
							visor<="0000101" ;
						elsif (aux_dig="0100") then
							visor<="1111110" ;
						elsif (aux_dig="1000") then
							visor<="0010101" ;
						else
							visor<="0000000";
						end if;
						proximo_estado<=dAtA;
					else
						S1<='1';
						S0<='1';
						if (aux_dig="0001") then
							visor<="1001110" ;
						elsif (aux_dig="0010") then
							visor<="0000101" ;
						elsif (aux_dig="0100") then
							visor<="1111110" ;
						elsif (aux_dig="1000") then
							visor<="0010101" ;
						else
							visor<="0000000";
						end if;
						proximo_estado<=CrOn;
					end if;
				when dAtA=>
					if(B='1') then
						bipe<= '1';
						S1<='1';
						S0<='1';
						if (aux_dig="0001") then
							visor<="0111101" ;
						elsif (aux_dig="0010") then
							visor<="1110111" ;
						elsif (aux_dig="0100") then
							visor<="0001111" ;
						elsif (aux_dig="1000") then
							visor<="1110111" ;
						else
							visor<="0000000";
						end if;
						proximo_estado<=HOrA;
					else
						S1<='1';
						S0<='1';
						if (aux_dig="0001") then
							visor<="0111101" ;
						elsif (aux_dig="0010") then
							visor<="1110111" ;
						elsif (aux_dig="0100") then
							visor<="0001111" ;
						elsif (aux_dig="1000") then 
							visor<="1110111" ;
						else
							visor<="0000000";
						end if;
						proximo_estado<=dAtA;
					end if;
				when others => 
					S1<= '0';
					S0<= '0';
					proximo_estado<= HOrA;
					
			end case;
		end process;
	end FSM2;