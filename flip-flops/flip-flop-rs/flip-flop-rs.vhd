library ieee;
use ieee.std_logic_1164.all;

entity FFP_RS is 
port ( S: IN boolean;
		 R: IN boolean;
		 ENABLE: in std_logic;
		 QT1: buffer boolean;
		 notQT1: buffer boolean
		 );
end FFP_RS;
		 
architecture FLIP1 of FFP_RS is
begin
	process(S,R,ENABLE,QT1,notQT1)
		begin 
			if ((S and not R) and ENABLE= '1') then 
				QT1<= true;
				notQT1<= false;
			elsif (QT1 and ENABLE='0') then
				QT1<= true;
				notQT1<= false;
			elsif (S and R) then
				QT1<= true;
				notQT1<=true;
			else
				QT1<= false;
				notQT1<= true;
		end if;
	end process;
end FLIP1;
