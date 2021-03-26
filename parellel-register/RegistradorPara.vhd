library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegistradorPara is
generic (
	n: integer := 4
	);
	port (
	A: in std_logic_vector(n-1 downto 0);
	load: in std_logic;
	clk: in std_logic;
	S: out std_logic_vector(n-1 downto 0)
	);
end RegistradorPara;

architecture comportamento of RegistradorPara is

begin

process (A,load)
begin

if(rising_edge(clk))then 
if (load='1') then
S(0) <= A(0);
S(1) <= A(1);
S(2) <= A(2);
S(3) <= A(3);


end if;
end if;
end process;
end comportamento;
