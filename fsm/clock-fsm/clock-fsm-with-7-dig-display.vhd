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
		Bipe: out std_logic;
		dig1: out std_logic;
		dig2: out std_logic;
		dig3: out std_logic;
		dig4: out std_logic;
		
		visor: out std_logic_vector (6 downto 0)
		
	);
end FSMRelo;
-------------------------------------------
architecture FSM2 of FSMRelo is
		--Declarações
		type estado is (HOrA,ALAr,CrOn,dAtA,Bipe1,Bipe2,Bipe3,Bipe4);
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
						proximo_estado<=Bipe1;
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
				when Bipe1=>
					Bipe<='1';
					proximo_estado<=ALAr;
				when ALAr=>
					if (B='1') then
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
						proximo_estado<=Bipe2;
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
				when Bipe2=>
						Bipe<='1';
						proximo_estado<=CrOn;
				when CrOn=> 
					if (B='1') then
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
						proximo_estado<=Bipe3;
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
				when Bipe3=>
					Bipe<='1';
					proximo_estado<=dAtA;
				when dAtA=>
					if(B='1') then
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
						proximo_estado<=Bipe4;
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
				when Bipe4=>
					Bipe<='1';
					proximo_estado<=HOrA;
				when others => 
					S1<= '0';
					S0<= '0';
					proximo_estado<= HOrA;
					
			end case;
		end process;
	end FSM2;