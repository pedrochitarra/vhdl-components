library ieee;
use ieee.std_logic_1164.all;

entity decoder7 is
port(     numbin: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    numexb: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
end decoder7;
  
architecture decod7 of decoder7 is
begin
WITH numbin SELECT
numexb <=    "1111110" WHEN "0000",
             "0110000" WHEN "0001",
             "1101101" WHEN "0010",
             "1111001" WHEN "0011",
             "0110011" WHEN "0100",
             "1011011" WHEN "0101",
             "1011111" WHEN "0110",
             "1110000" WHEN "0111",
             "1111111" WHEN "1000",
             "1111011" WHEN "1001",
             "1111110" WHEN OTHERS;    
end decod7;
