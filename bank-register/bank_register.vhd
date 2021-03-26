library ieee;
use ieee.std_logic_1164.all;

entity Vhdl1 is
	generic (
	m : integer := 2;
		n : integer := 4 
	);
	port(
		reset : in std_logic;
		W_enable : in std_logic;
		clk : in std_logic; 
		R_ende : in std_logic_vector(m-1 downto 0);
		W_dados : in std_logic_vector(n-1 downto 0);
		R_enable : in std_logic;
		R_dados : out std_logic_vector(n-1 downto 0);
		W_ende :in std_logic_vector(m-1 downto 0)

	);
end Vhdl1;

architecture behaviour of Vhdl1 is
	signal S1 : std_logic_vector(n-1 downto 0);
	signal S2 : std_logic_vector(n-1 downto 0);
	signal S3 : std_logic_vector(n-1 downto 0);
	signal S : std_logic_vector(n-1 downto 0);
	
	begin
	process(clk,R_enable,W_enable,reset)
		begin
			if(clk'event and clk = '1') then
				if(reset = '1') then
					S <= (others =>'0');
					S1 <= (others =>'0');
					S2 <= (others =>'0');
					S3 <= (others =>'0');
				elsif(W_enable = '1') then
					if(W_ende = "00") then
						S <= W_dados;
					elsif(W_ende ="01")then
						S1 <= W_dados;
					elsif(W_ende ="10")then
						S2 <= W_dados;
					elsif(W_ende ="11")then
						S3 <= W_dados;
					end if;
				elsif(R_enable ='1') then
					if(R_ende = "00") then
						R_dados <= S;
					elsif(R_ende ="01")then
						R_dados <= S1;
					elsif(R_ende ="10")then
						R_dados <= S2;
					elsif(R_ende ="11")then
						R_dados <= S3;
					end if;
				end if;
			end if;
	end process;
end behaviour;	