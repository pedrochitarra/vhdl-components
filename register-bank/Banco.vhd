library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity BancoRegistradores is
generic (
	n: integer := 4;
	t_endereco: integer:= 2
	);
	port (
	cle,clk, W_enable, R_enable: in std_logic;
	W_dados: in std_logic_vector(n-1 downto 0);
	R_dados: out std_logic_vector(n-1 downto 0);
	W_endereco,R_endereco:in std_logic_vector(t_endereco downto 0)
	);
end BancoRegistradores;

architecture comportamento of BancoRegistradores is
type registradores is array(n-1 downto 0) of std_logic_vector(n-1 downto 0);
signal registra: registradores := (others => (others=>'0'));

begin

	process (cle,clk,R_endereco,R_enable)
	begin
	if(cle='1')then
		registra<=(others => (others =>'0'));
	elsif (R_enable='1' and W_enable='0')then
		R_dados <= registra(to_integer(unsigned(R_endereco)));
	elsif(rising_edge(clk))then
		if (W_enable = '1')then
			registra(to_integer(unsigned(W_endereco)))<=W_dados;
		end if;
	end if;
end process;
end comportamento;

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ComparadorCombinacional is
generic (
	n: integer :=4;
	t_endereco:integer:=2
		  );
	port(
	W_dados: in std_logic_vector(n-1 downto 0);
	maior: out std_logic_vector(t_endereco downto 0);
	menor: out std_logic_vector(t_endereco downto 0)
	);
end ComparadorCombinacional;

architecture comportamento1 of ComparadorCombinacional is
type registradores is array(n-1 downto 0) of std_logic_vector(n-1 downto 0);
signal registra: registradores := (others => (others=>'0'));

begin

maior<= "00" when(registra(0)>registra(1) and registra(0)>registra(2) and registra(0)>registra(3))else
	"01" when(registra(1)>registra(0) and registra(1)>registra(2) and registra(1)>registra(3))else
	"10" when(registra(2)>registra(0) and registra(2)>registra(1) and registra(2)>registra(3))else
	"11" when(registra(3)>registra(0) and registra(3)>registra(1) and registra(3)>registra(2));

menor<= "00" when(registra(0)<registra(1) and registra(0)<registra(2) and registra(0)<registra(3))else
	"01" when(registra(1)>registra(0) and registra(1)<registra(2) and registra(1)<registra(3))else
	"10" when(registra(2)>registra(0) and registra(2)<registra(1) and registra(2)<registra(3))else
	"11" when(registra(3)<registra(0) and registra(3)>registra(1) and registra(3)<registra(2));	
		  
end comportamento1;

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processador is
generic(
	n: integer :=4;
	t_endereco: integer:=2
	);
	port(B0,B1,B2,B3,clk: in std_logic;
		  R_dados: out std_logic_vector(n-1 downto 0)
	);
end Processador;
	
architecture comportamento2 of Processador is
signal W_enable1,R_enable1: std_logic;
signal W_dados1,R_dados1: std_logic_vector(3 downto 0);
signal W_endereco1,R_endereco1: std_logic_vector(1 downto 0);
signal bigger,smaller: std_logic_vector(1 downto 0);
type registradores is array(n-1 downto 0) of std_logic_vector(n-1 downto 0);
signal registra: registradores := (others => (others=>'0'));
type estado is (E0,E1,E2,E3,E4);
signal estado_atual, proximo_estado: estado;
signal aux_reg: std_logic_vector(1 downto 0):=(others=>'0');

begin
BANCO: work.BancoRegistradores
port map(cle=>'0',clk=>clk,W_enable=>W_enable1,R_enable=>R_enable1,W_dados=>W_dados1,R_dados=>R_dados1,
			W_endereco=>W_endereco1,R_endereco=>R_endereco1);
COMPARADOR: work.ComparadorCombinacional
port map(W_dados=>W_dados1,maior=>bigger,menor=>smaller);


---------------
	sequencial:
	process(clk)is
	--Declarações
	begin
		if(rising_edge(clk))then
		--Sentenças sequenciais sincronas
		estado_atual<=proximo_estado;
		end if;
	end process;
--------------
	combinacional:	
	process (clk,B0,B1,B2,B3) is
	begin
	--Sentenças sequenciais
	case estado_atual is
		when E0=>
			if(B0='1')then
			proximo_estado<=E1;
			elsif(B1='1')then
			proximo_estado<=E2;
			elsif(B2='1')then
			proximo_estado<=E3;
			elsif(B3='1')then
			proximo_estado<=E4;
			else
			proximo_estado<=E0;
			end if;
			
		when E1=>
			registra(0)<="0000";
			registra(1)<="0000";
			registra(2)<="0000";
			registra(3)<="0000";
			if(B0='1')then
			R_dados1<="0000";
			proximo_estado<=E1;
			elsif(B1='1')then
			R_dados1<="0000";
			proximo_estado<=E2;
			elsif(B2='1')then
			R_dados1<="0000";
			proximo_estado<=E3;
			elsif(B3='1')then
			R_dados1<="0000";
			proximo_estado<=E4;
			else
			proximo_estado<=E1;
			end if;
			
		when E2=>
			if(bigger="00")then
			R_dados1<=registra(0);
			elsif(bigger="01")then
			R_dados1<=registra(1);
			elsif(bigger="10")then
			R_dados1<=registra(2);
			else
			R_dados1<=registra(3);
			end if;
			
			if(B0='1')then
			proximo_estado<=E1;
			elsif(B1='1')then
			proximo_estado<=E2;
			elsif(B2='1')then
			proximo_estado<=E3;
			elsif(B3='1')then
			proximo_estado<=E4;
			else
			proximo_estado<=E2;
			end if;
			
		when E3=>
			if(smaller="00")then
			R_dados1<=registra(0);
			elsif(smaller="01")then
			R_dados1<=registra(1);
			elsif(smaller="10")then
			R_dados1<=registra(2);
			else
			R_dados1<=registra(3);
			end if;
			
			if(B0='1')then
			proximo_estado<=E1;
			elsif(B1='1')then
			proximo_estado<=E2;
			elsif(B2='1')then
			proximo_estado<=E3;
			elsif(B3='1')then
			proximo_estado<=E4;
			else 
			proximo_estado<=E3;
			end if;
			
		when E4=>
			if(W_enable1='1')then
				if(W_endereco1="00")then
				registra(0)<=W_dados1;
				elsif(W_endereco1="01")then
				registra(1)<=W_dados1;
				elsif(W_endereco1="10")then
				registra(2)<=W_dados1;
				else
				registra(3)<=W_dados1;
				end if;
			end if;
			
			if(B0='1')then
			proximo_estado<=E1;
			elsif(B1='1')then
			proximo_estado<=E2;
			elsif(B2='1')then
			proximo_estado<=E3;
			elsif(B3='1')then
			proximo_estado<=E4;
			else
			proximo_estado<=E4;
			end if;
			
		end case;
	end process;
end comportamento2;
