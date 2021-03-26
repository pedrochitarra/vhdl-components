library ieee;
use ieee.std_logic_1164.all;

entity FF_D is
port ( D: in boolean;
		 CLK: in boolean;
		 QT: buffer boolean;
		 notQT: buffer boolean
		 );
end FF_D;

architecture FLIPD1 of FF_D is
signal Qinter : boolean;
signal notQinter : boolean;
begin
process(D,CLK,QT,notQT)
	begin
		
		
			Qinter <= ((D and notQT) nand CLK) nand notQinter;
			notQinter <= ((not D and QT) nand CLK) nand Qinter;
	
			QT <= (Qinter nand (not CLK)) nand notQT;
			notQT <= (notQinter nand (not CLK)) nand QT;
	end process;	
end FLIPD1;