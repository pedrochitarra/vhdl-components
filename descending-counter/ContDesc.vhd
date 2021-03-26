library ieee; 
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 
 
entity ContDesc is
generic(
	n: integer :=4
	);  
  port(clk, clear : in  std_logic;  
       Valor : out std_logic_vector(n-1 downto 0));  
end ContDesc;
 
architecture comportamento of ContDesc is  
  signal contar: std_logic_vector(n-1 downto 0);  
  begin  
    process (clk)  
      begin  
        if (clk'event and clk='1') then  
          if (clear='1') then 
            contar <= "1111";  
          else  
            contar <= contar - 1;  
          end if;  
        end if;  
    end process;  
    Valor <= contar;  
end Comportamento; 