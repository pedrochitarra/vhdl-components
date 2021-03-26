library ieee;
use ieee.std_logic_1164.all;

entity ProjDass1 is
port ( D: in boolean;
		 CLK: in boolean;
		 QT: buffer boolean;
		 CLE: in boolean;
		 notQT: buffer boolean
		 );
end ProjDass1;

architecture FFD1 of ProjDass1 is
begin 
	process(CLE,D,CLK)
		begin
			if(CLE) then
				QT<=false;
				notQT<=true;
			elsif (clk'event and clk = false) then
				QT <= D;
				notQT <= not D;
			else
				QT<= QT;
				notQT<= notQT;
		end if;
	end process;
end FFD1;