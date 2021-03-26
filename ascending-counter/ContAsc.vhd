library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
 
entity ContAsc is
generic (
	n: integer :=4
	); 
  port(clk , clear : in  std_logic;
        Valor : out std_logic_vector(n-1 downto 0));  
end ContAsc; 

architecture comportamento of ContAsc is  
  signal contar: std_logic_vector(n-1 downto 0); 
  begin  
      process (clear, clk) 
        begin  
          if (clear='1') then  
            contar <= "0000";  
          elsif (clk'event and clk='1') then  
            contar <= contar + 1; 
          end if;  
      end process; 
      Valor <= contar;  
end comportamento; 