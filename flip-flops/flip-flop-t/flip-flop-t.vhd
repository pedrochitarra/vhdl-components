library ieee;
use ieee.std_logic_1164.all;

entity FFP_T is
port ( T: in boolean;
		 CLK: in boolean;
		 QT: buffer boolean;
		 notQT: buffer boolean
		 );
end FFP_T;

architecture FLIPT1 of FFP_T is
signal Qinter : boolean;
signal notQinter : boolean;
begin
process(T,CLK,QT,notQT)
	begin
		
		
			Qinter <= ((T and notQT) nand CLK) nand notQinter;
			notQinter <= ((T and QT) nand CLK) nand Qinter;
	
			QT <= (Qinter nand (not CLK)) nand notQT;
			notQT <= (notQinter nand (not CLK)) nand QT;
	end process;	
end FLIPT1;