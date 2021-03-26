library ieee;
use ieee.std_logic_1164.all;

entity and3 is
port ( A: 		in boolean;
		 B: 		in boolean;
		 C: 		in boolean;
		 S: 		out boolean
);
end and3;

architecture behaviour of and3 is
begin
	process(A,B,C)
		begin
			if (A and B and C) then
				S<= true;
			else 
				S<= false;
			end if;
		end process;
end behaviour;

