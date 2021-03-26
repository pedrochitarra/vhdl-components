library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Banco is
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
end Banco;

architecture comportamento of Banco is
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



