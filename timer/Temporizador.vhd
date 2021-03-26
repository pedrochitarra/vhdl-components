library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Temporizador is
    port
    (
        clk      : in std_logic;
        reset    : in std_logic;
        enable   : in std_logic;
        tempo    : out integer range 0 to 255
    );
end Temporizador;

architecture comportamento of Temporizador is
begin
    process (clk)
        variable   contar : integer range 0 to 255;
    begin
        if (rising_edge(clk)) then
            if reset = '1' then
                contar := 0;
            elsif enable = '1' then
                contar := contar + 1;
            end if;
        end if;        
        tempo <= contar;
    end process;
end comportamento;