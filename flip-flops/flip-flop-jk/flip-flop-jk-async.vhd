library ieee;
use ieee.std_logic_1164.all;

entity FlipJKass is
port ( J: in boolean;
		 K: in boolean;
		 CLE: in boolean;
		 CLK: in boolean;
		 QT: buffer boolean;
		 notQT: buffer boolean
		 );
end FlipJKass;

architecture FLIPJK2 of FlipJKass is
signal Qinter : boolean;
signal notQinter : boolean;
begin
	process(J,K,CLE,CLK,QT,notQT)
	begin
	if(CLE) then
		QT<=false;
		notQT<= true;
	else
	
		Qinter <= ((J and notQT) nand CLK) nand notQinter;
		notQinter <= ((K and QT) nand CLK) nand Qinter;
	
		QT <= (Qinter nand (not CLK)) nand notQT;
		notQT <= (notQinter nand (not CLK)) nand QT;
		end if;
	end process;
end FLIPJK2;
