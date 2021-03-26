library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
entity RegisDesl is
generic (
	n: integer :=4
	);
	port (C: in std_logic;
			clk: in std_logic;
			nx: in std_logic;
			clear: in std_logic;
			ini: in std_logic_vector(n-1 downto 0);
			sai: out std_logic_vector(n-1 downto 0)
			);
end RegisDesl;

architecture comportamento of RegisDesl is
	signal car: std_logic_vector(n-1 downto 0);
	begin
		process(C, clk, nx, clear, ini)
			begin
			if(clear ='1') then
				car(0) <= ini(0);
				car(1) <= ini(1);
				car(2) <= ini(2);
				car(3) <= ini(3);
			else
				if (rising_edge(clk) and C='1') then
					car(0)<=car(1);
					car(1)<=car(2);
					car(2)<=car(3);
					car(3)<=nx;
				else
					car(0) <= car(0);
					car(1) <= car(1);
					car(2) <= car(2);
					car(3) <= car(3);
				end if;
			end if;
			sai(0) <= car(0);
			sai(1) <= car(1);
			sai(2) <= car(2);
			sai(3) <= car(3);
		end process;
	end comportamento;