library ieee;
use ieee.std_logic_1164.all;

entity FFJK1 is
port ( J: in boolean;
		 K: in boolean;
		 CLK: in boolean;
		 QT: buffer boolean;
		 notQT: buffer boolean
		 );
end FFJK1;

architecture FLIPJK of FFJK1 is
signal Qinter : boolean;
signal notQinter : boolean;
begin
	
	Qinter <= ((J and notQT) nand CLK) nand notQinter;
	notQinter <= ((K and QT) nand CLK) nand Qinter;
	
	QT <= (Qinter nand (not CLK)) nand notQT;
	notQT <= (notQinter nand (not CLK)) nand QT;

	end FLIPJK;
