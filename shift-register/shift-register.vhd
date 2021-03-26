library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registrador is
port( CLK, CLE,S: in boolean;
		P0,P1,P2,P3: buffer boolean
		);
end Registrador;

architecture Reg of Registrador is
begin
FLIPD1:work.ProjDass1 port map (D=>P1,CLK=>CLK,CLE=>CLE,QT=>P0);
FLIPD2:work.ProjDass1 port map (D=>P2,CLK=>CLK,CLE=>CLE,QT=>P1);
FLIPD3:work.ProjDass1 port map (D=>P3,CLK=>CLK,CLE=>CLE,QT=>P2);
FLIPD4:work.ProjDass1 port map (D=>S,CLK=>CLK,CLE=>CLE,QT=>P3);
end Reg;