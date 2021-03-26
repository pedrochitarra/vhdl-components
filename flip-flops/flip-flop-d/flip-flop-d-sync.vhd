library ieee;
use ieee.std_logic_1164.all;

entity ProjDsin is
port ( D: in boolean;
		 CLK: in boolean;
		 QT: out boolean;
		 CLE: in boolean;
		 notQT: out boolean
		 );
end ProjDsin;

architecture FFD2 of ProjDsin is
begin 
	process(CLE,D,CLK)
		begin
			
				QT<= not CLE and (D and CLK) ;
				notQT<=CLE or (not CLE and not D and CLK) or (not CLE and D and not CLK) or 
				(not CLE and not D and not CLK);
				

	end process;
end FFD2;

