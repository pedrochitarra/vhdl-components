library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Deslocador is
generic (
	n: integer := 4
	);
	port (
	A: in std_logic_vector(n-1 downto 0);
	clear: in std_logic;
	load: in std_logic;
	clk: in std_logic;
	nx: in std_logic;
	direita: in std_logic;
	S: out std_logic_vector(n-1 downto 0)
	);
end Deslocador;

architecture comportamento of Deslocador is
signal aux: std_logic_vector(n-1 downto 0);
begin 
process (A,load, clk, nx, direita)
begin
		if (clear = '1') then
		aux(0) <= A(0);
		aux(1) <= A(1);
		aux(2) <= A(2);
		aux(3) <= A(3);
		else
			if (rising_edge(clk) and load='1' and direita='1') then
			aux(0) <= aux(1);
			aux(1) <= aux(2);
			aux(2) <= aux(3);
			aux(3) <= nx;
			elsif (rising_edge(clk) and load='1' and direita='0') then
			aux(3) <= aux(2);
			aux(2) <= aux(1);
			aux(1) <= aux(0);
			aux(0) <= nx;
			else
			aux(0) <= aux(0);
			aux(1) <= aux(1);
			aux(2) <= aux(2);
			aux(3) <= aux(3);
			end if;
		end if;
		S(0) <= aux(0);
		S(1) <= aux(1);
		S(2) <= aux(2);
		S(3) <= aux(3);
end process;
end comportamento;