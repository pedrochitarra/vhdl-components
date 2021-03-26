library ieee;
use ieee.std_logic_1164.all;

entity JKsin is
port ( J: in boolean;
		 K: in boolean;
		 CLE: in boolean;
		 CLK: in boolean;
		 QT: buffer boolean;
		 notQT: buffer boolean
		 );
end JKsin;

architecture FLIPJK3 of JKsin is
signal Qinter : boolean;
signal notQinter : boolean;
signal Q2: boolean;
signal notQ2: boolean;
begin
	process(J,K,CLE,CLK,QT,notQT)
	begin
	
		Qinter <= ((J and notQT) nand CLK) nand notQinter;
		notQinter <= ((K and QT) nand CLK) nand Qinter;
	
		Q2 <= ((Qinter nand (not CLK)) nand notQT);
		notQ2 <= ((notQinter nand (not CLK)) nand QT);
		
		QT<= Q2 and (not CLE);
		notQT<= notQ2 or CLE;
		
		
	end process;
end FLIPJK3;