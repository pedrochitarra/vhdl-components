library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Comparador is
generic(
	n: integer :=4
	);
	port (A: in std_logic_vector (n-1 downto 0);
		  B: in std_logic_vector (n-1 downto 0);
		  IGUAL: out std_logic;
		  MAG: out std_logic;
		  MAIOR: out std_logic;
		  MENOR: out std_logic
		  );
end Comparador;

architecture comportamento of Comparador is
begin
process(A,B)
begin

if(A(3)=B(3)) then
MAG <='1';
else
MAG <='0';
end if;

if (A(3)>B(3)) then
MAIOR<='1';
MENOR<='0';
IGUAL<='0';
elsif (A(3)<B(3)) then
MAIOR<='0';
MENOR<='1';
IGUAL<='0';
elsif(A(2)>B(2))then
MAIOR<='1';
MENOR<='0';
IGUAL<='0';
elsif(A(2)<B(2))then
MAIOR<='0';
MENOR<='1';
IGUAL<='0';
elsif(A(1)>B(1))then
MAIOR<='1';
MENOR<='0';
IGUAL<='0';
elsif(A(1)<B(1))then
MAIOR<='0';
MENOR<='1';
IGUAL<='0';
elsif(A(0)>B(0))then
MAIOR<='1';
MENOR<='0';
IGUAL<='0';
elsif(A(0)<B(0))then
MAIOR<='0';
MENOR<='1';
IGUAL<='0';
elsif((A(3) = B(3)) and (A(2) = B(2)) and (A(1) = B(1)) and (A(0) = B(0))) then 
MAIOR<='0';
MENOR<='0';
IGUAL<='1';
else
MAIOR<='0';
MENOR<='0';
IGUAL<='0';


end if;
end process;
end comportamento;
