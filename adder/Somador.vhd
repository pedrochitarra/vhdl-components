library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Somador is
generic (
	n: integer :=4
	);
	port (A: in std_logic_vector(n-1 downto 0);
			B: in std_logic_vector(n-1 downto 0);
			S: out std_logic_vector(n-1 downto 0);
			co: buffer std_logic_vector(n-1 downto 0);
			ci: buffer std_logic_vector(n-1 downto 0) 
			);
end Somador;

architecture comportamento of Somador is
begin
process(A,B,ci,co)
begin 

ci(0) <='0';
S(0) <= A(0) xor B(0) xor ci(0);
co(0) <= (A(0) and B(0)) xor (A(0) and ci(0)) xor (B(0)and ci(0));

ci(1) <= co(0);
S(1) <= A(1) xor B(1) xor ci(1);
co(1) <= (A(1) and B(1)) xor (A(1) and ci(1)) xor (B(1)and ci(1));

ci(2) <= co(1);
S(2) <= A(2) xor B(2) xor ci(2);
co(2) <= (A(2) and B(2)) xor (A(2) and ci(2)) xor (B(2)and ci(2));

ci(3) <= co(2);
S(3) <= A(3) xor B(3) xor ci(3);
co(3) <= (A(3) and B(3)) xor (A(3) and ci(3)) xor (B(3)and ci(3));

end process;
end comportamento; 