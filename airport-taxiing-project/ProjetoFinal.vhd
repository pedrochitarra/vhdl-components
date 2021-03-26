library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity SomadorP is
port (P: in std_logic_vector(2 downto 0);
		Display: out std_logic_vector(0 to 6)
		);
end SomadorP;

architecture comportamento2 of SomadorP is
begin 
with P select
Display<=
"0000001" when "000","1001111" when "001","0010010" when "010","0000110" when "011",
"1001100" when "100","0000001" when others;
end comportamento2;

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Display10 is
port(Valor: in std_logic_vector(3 downto 0);
	  Unidade10: out std_logic_vector(0 to 6);
	  Dezena10: out std_logic_vector(0 to 6)
	  );
end Display10;

architecture DisplayDez of Display10 is

begin

with Valor select
Unidade10<= "0000001" when "0000","1001111" when "0001","0010010" when "0010",
"0000110" when "0011","1001100" when "0100","0100100" when "0101",
"0100000" when "0110","0001111" when "0111","0000000" when "1000",
"0000100" when "1001","0000001" when others;

with Valor select					 
Dezena10<= "1001111" when "1010", "0000001" when others;

end DisplayDez;

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity DisplayPortoes is
port(Portoes: in std_logic_vector(2 downto 0);
	  A,B,C,D: out std_logic
	  );
end DisplayPortoes;

architecture DP of DisplayPortoes is
begin

with Portoes select
A<='0' when "001", '0' when "010", '0' when "011", '0' when "100", '1' when others;

with Portoes select
B<='0' when "010", '0' when "011", '0' when "100", '1' when others;

with Portoes select
C<='0' when "011", '0' when "100", '1' when others;

with Portoes select 
D<='0' when "100", '1' when others; 

end DP;
 
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Display5 is
port(Valor: in std_logic_vector(3 downto 0);
	  Unidade5:out std_logic_vector(0 to 6)
	  );
end Display5;

architecture DisplayCinco of Display5 is

begin
with Valor select
Unidade5<="0000001" when "0000", "1001111" when "0001", "0010010" when "0010", "0000110" when "0011",
"1001100" when "0100", "0100100" when "0101", "0000001" when others;			 
end DisplayCinco;


library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ProjetoFinal is
port(
		EnviaFPGA: out std_logic_vector(7 downto 0);
		RecebeFPGA: in std_logic_vector(7 downto 0);
		clk:in std_logic;
		LEDvdP,LEDvmD,Adisp,Bdisp,Cdisp,Ddisp,AviaoAguarda: out std_logic;
		Unidade10,Dezena10,Unidade5,QtdAv: out std_logic_vector(0 to 6)
		);
end ProjetoFinal;

architecture ControleAereo of ProjetoFinal is
type estado is (estadozero,Voo,AguardaPouso,Pouso,TaxiamentoDireitaPou,DesembarqueDireita,DesembarqueEsquerda,
TaxiamentoHangarDir,TaxiamentoHangarEsq,GATEA,GATEB,GATEC,GATED,TaxiamentoDireitaA,TaxiamentoEsquerdaA,
TaxiamentoDireitaB,TaxiamentoEsquerdaB,TaxiamentoDireitaC,TaxiamentoEsquerdaC,TaxiamentoDireitaD,
TaxiamentoEsquerdaD,EmbarqueDireito1,EmbarqueEsquerdo1,EmbarqueDireito2,EmbarqueEsquerdo2,TaxiamentoEsquerdaDir,
Decolagem,AguardaDecolagem);
signal PistaPD,PistaTaxiamentoDir,EmbarqueDir,PistaTaxiamentoEsq,EmbarqueEsq: std_logic;
signal estado_atual,proximo_estado: estado:=estadozero; 
signal Cnt10_st,Cnt5_st,clear10,clear5,reset,resetf,enable,enablef :std_logic;
signal PortoesOut: std_logic_vector(2 downto 0); 
signal Stemp10: std_logic_vector (3 downto 0):="1010";
signal Stemp5: std_logic_vector(3 downto 0):="0101";
signal aux_clk10,aux_clk5 : integer range 0 to 50000000;
signal contar10: std_logic_vector(3 downto 0):= "1010";
signal contar5: std_logic_vector(3 downto 0):="0101";
  
begin

SOMADOR: work.SomadorP port map (P=>Portoesout,Display=>QtdAv);
DIS10: work.Display10 port map(Valor=>Stemp10,Unidade10=>Unidade10,Dezena10=>Dezena10);
DIS5: work.Display5 port map(Valor=>Stemp5,Unidade5=>Unidade5);
DISH: work.DisplayPortoes port map(Portoes=>Portoesout,A=>ADisp,B=>BDisp,C=>CDisp,D=>DDisp);
--REGS: work.RegistradorFinal port map(clk=>clk,rst=>reset,enable=>enable,D=>Portoes,Q=>PortoesOut);
--REGF: work.RegistradorFPGA port map(clk=>clk,rst=>reset,enable=>enablef,D=>EnviaF,Q=>EnviaFPGA);

    process(clk, reset, enable)
    begin
        if (reset = '1') then
            Portoesout <= (others => '0');
        elsif (rising_edge(clk)and enable='1') then
		       if (estado_atual=GATEA) then
               Portoesout <= "001"; 
				elsif(estado_atual=GATEB) then
					Portoesout<="010";
				elsif(estado_atual=GATEC) then
					Portoesout<="011";
				elsif(estado_atual=GATED) then
					Portoesout<="100";
				elsif(estado_atual=TaxiamentoDireitaA) then
					Portoesout<="000";
				elsif(estado_atual=TaxiamentoDireitaB) then
					Portoesout<="001";
				elsif(estado_atual=TaxiamentoDireitaC) then
					Portoesout<="010";
				elsif(estado_atual=TaxiamentoDireitaD) then
					Portoesout<="011";
				elsif(estado_atual=TaxiamentoEsquerdaA) then
					Portoesout<="000";
				elsif(estado_atual=TaxiamentoEsquerdaB) then
					Portoesout<="001";
				elsif(estado_atual=TaxiamentoEsquerdaC) then
					Portoesout<="010";
				elsif(estado_atual=TaxiamentoEsquerdaD) then
					Portoesout<="011";
				end if;
        end if;
    end process;
		
	Cnt10_st <= '1' when (estado_atual = Pouso) else
					'0';
	Cnt5_st <= '1' when (estado_atual = Decolagem) else
				  '0';
	clear10 <= '0' when (estado_atual = Pouso) else
				  '1';
	clear5  <= '0' when (estado_atual = Decolagem) else
				  '1';
				  
	 process(clk, resetf,enablef)
    begin
        if resetf = '1' then
            EnviaFPGA <= (others => '0');
        elsif (rising_edge(clk)and enablef='1') then
            if(estado_atual=Pouso)then
					EnviaFPGA<="00000001";
				elsif(estado_atual=GATEA)then
					EnviaFPGA<="00000101";
				elsif(estado_atual=GATEB)then
					EnviaFPGA<="00000100";
				elsif(estado_atual=GATEC)then
					EnviaFPGA<="00000011";
				elsif(estado_atual=GATED)then
					EnviaFPGA<="00000010";
				elsif(estado_atual=Decolagem)then
					EnviaFPGA<="00001000";
				elsif(estado_atual=AguardaPouso) then
					if(Portoesout="000")then EnviaFPGA<="00000110"; 
					elsif(Portoesout="001")then EnviaFPGA<="00000101";
					elsif(Portoesout="010")then EnviaFPGA<="00000100";
					elsif(Portoesout="011")then EnviaFPGA<="00000011";
					elsif(Portoesout="100")then EnviaFPGA<="00000010";
					else EnviaFPGA<="00000000";
					end if;
				elsif(estado_atual=TaxiamentoDireitaPou)then
					if(Portoesout="000")then EnviaFPGA<="00000110";
					elsif(Portoesout="001")then EnviaFPGA<="00000101";
					elsif(Portoesout="010")then EnviaFPGA<="00000100";
					elsif(Portoesout="011")then EnviaFPGA<="00000011";
					elsif(Portoesout="100")then EnviaFPGA<="00000010";
				--else EnviaFPGA<="00000000";
					end if;
				end if;
        end if;
    end process;
	 
	 process(clk,Cnt10_st,clear10)    
      begin
		if (clear10='1') then 
            contar10 <= "1010";
		elsif(Cnt10_st='1')then
        if (clk'event and clk='1') then  
            aux_clk10 <= aux_clk10 + 1;
				if (aux_clk10 = 50000000)then
					aux_clk10 <= 0;
					contar10 <= contar10 - '1';
				end if;
					Stemp10 <= contar10;
				if(contar10="0000")then
					contar10<="1010";
				end if;
        end if; 
		end if;
    end process;  

	 process(clk,Cnt5_st,clear5)    
      begin
		if (clear5='1') then 
            contar5 <= "0101";
		elsif(Cnt5_st='1')then
        if (clk'event and clk='1') then  
            aux_clk5 <= aux_clk5 + 1;
				if (aux_clk5 = 50000000)then
					aux_clk5 <= 0;
					contar5 <= contar5 - '1';
				end if;
					Stemp5 <= contar5;
				if(contar5="0000")then
					contar5<="0101";
				end if;
        end if; 
		end if;
    end process;  
---------------
	sequencial:
	process(clk)is
	--Declarações
	begin
		if(rising_edge(clk))then
		--Sentenças sequenciais sincronas
			estado_atual<=proximo_estado;
		end if;
	end process;
--------------
	combinacional:
	
	process(RecebeFPGA,Cnt10_st,Cnt5_st,clear10,clear5,Stemp10,Stemp5,PistaPD,reset,resetf,enablef,
	PistaTaxiamentoDir,EmbarqueDir,PistaTaxiamentoEsq,EmbarqueEsq,enable,PortoesOut,estado_atual,proximo_estado)is
	begin
	--Sentenças sequenciais
	PistaPD <= '0';PistaTaxiamentoDir <= '0';EmbarqueDir<='0';PistaTaxiamentoEsq<='0';EmbarqueEsq<='0';reset<='0';enable<='0';
	enablef<='0';LEDvdP<='0';LEDvmD<='0';AviaoAguarda<='0';
	
	case estado_atual is
		when estadozero=>
			reset<='1';
			proximo_estado<=Voo;
			
		when Voo=>
			if(RecebeFPGA="00000001")then proximo_estado<=AguardaPouso;
			elsif(RecebeFPGA="00000011" and Portoesout="001")then proximo_estado<=GATEA;
			elsif(RecebeFPGA="00000011" and Portoesout="010")then proximo_estado<=GATEB;
			elsif(RecebeFPGA="00000011" and Portoesout="011")then proximo_estado<=GATEC;
			elsif(RecebeFPGA="00000011" and Portoesout="100")then proximo_estado<=GATED;
			else proximo_estado<=Voo;
			end if;
			
		when AguardaPouso=>
			AviaoAguarda<='1';enablef<='1';
			if(PistaPD='0' or (EmbarqueEsq='0' or EmbarqueDir='0'))then proximo_estado<=Pouso;
			else proximo_estado<=AguardaPouso;
			end if;
		
		when Pouso=>
			enablef<='1';PistaPD<='1';LEDvdP<='1';
			if(PistaTaxiamentoDir='0' and Stemp10="0000")then proximo_estado<=TaxiamentoDireitaPou;
			else proximo_estado<=Pouso;
			end if;
			
		when TaxiamentoDireitaPou=>
			PistaTaxiamentoDir<='1';enablef<='1';
			if(EmbarqueDir='0')then proximo_estado<=DesembarqueDireita;
			elsif(EmbarqueDir='1' and EmbarqueEsq='0')then proximo_estado<=DesembarqueEsquerda;
			else proximo_estado<=TaxiamentoDireitaPou;
			end if;
		
		when DesembarqueDireita=>
			EmbarqueDir<='1';
			if(PistaTaxiamentoDir='0')then proximo_estado<=TaxiamentoHangarDir;
			else proximo_estado<=DesembarqueDireita;
			end if;
		
		when DesembarqueEsquerda=>
			EmbarqueEsq<='1';EmbarqueDir<='1';
			if(PistaTaxiamentoDir='0')then proximo_estado<=TaxiamentoHangarEsq;
			else proximo_estado<=DesembarqueEsquerda;
			end if;
		
		when TaxiamentoHangarDir=>
			PistaTaxiamentoDir<='1';
			if(Portoesout="000")then proximo_estado<=GATEA;
			elsif(Portoesout="001")then proximo_estado<=GATEB;
			elsif(Portoesout="010")then proximo_estado<=GATEC;
			elsif(Portoesout="011")then proximo_estado<=GATED;
			else proximo_estado<=TaxiamentoHangarDir;
			end if;
			
		when TaxiamentoHangarEsq=>
			EmbarqueDir<='1';PistaTaxiamentoDir<='1';
			if(Portoesout="000")then proximo_estado<=GATEA;
			elsif(Portoesout="001")then proximo_estado<=GATEB;
			elsif(Portoesout="010")then proximo_estado<=GATEC;
			elsif(Portoesout="011")then proximo_estado<=GATED;
			else proximo_estado<=TaxiamentoHangarEsq;
			end if;
			
		when GATEA=>
			enablef<='1';enable<='1';
			if(RecebeFPGA="00000001")then proximo_estado<=AguardaPouso;
			elsif(RecebeFPGA="00000011" and PistaTaxiamentoDir='0')then proximo_estado<=TaxiamentoDireitaA;
			elsif(RecebeFPGA="00000011" and PistaTaxiamentoDir='1' and PistaTaxiamentoEsq='0')then 
			proximo_estado<=TaxiamentoEsquerdaA;
			else proximo_estado<=GATEA;
			end if;
			
		when GATEB=>
			enablef<='1';enable<='1';
			if(RecebeFPGA="00000001")then 
			proximo_estado<=AguardaPouso;
			elsif(RecebeFPGA="00000011" and PistaTaxiamentoDir='0')then 
			proximo_estado<=TaxiamentoDireitaB;
			elsif(RecebeFPGA="00000011" and PistaTaxiamentoDir='1' and PistaTaxiamentoEsq='0')then
			proximo_estado<=TaxiamentoEsquerdaB;
			else 
			proximo_estado<=GATEB;
			end if;
		
		when GATEC=>
			enablef<='1';enable<='1';
			if(RecebeFPGA="00000001")then proximo_estado<=AguardaPouso;
			elsif(RecebeFPGA="00000011" and PistaTaxiamentoDir='0')then 
			proximo_estado<=TaxiamentoDireitaC;
			elsif(RecebeFPGA="00000011" and PistaTaxiamentoDir='1' and PistaTaxiamentoEsq='0')then
			proximo_estado<=TaxiamentoEsquerdaC;
			else 
			proximo_estado<=GATEC;
			end if;
			
		when GATED=>
			enablef<='1';enable<='1';
			if(RecebeFPGA="00000011" and PistaTaxiamentoDir='0')then proximo_estado<=TaxiamentoDireitaD;
			elsif(RecebeFPGA="00000011" and PistaTaxiamentoDir='1' and PistaTaxiamentoEsq='0')then
			proximo_estado<=TaxiamentoEsquerdaD;
			else proximo_estado<=GATED;
			end if;
		
		when TaxiamentoDireitaA=>
			PistaTaxiamentoDir<='1';enable<='1';
			if(EmbarqueDir='0')then proximo_estado<=EmbarqueDireito1;
			elsif(EmbarqueDir='1' and EmbarqueEsq='0')then proximo_estado<=EmbarqueEsquerdo1;
			else proximo_estado<=TaxiamentoDireitaA;
			end if;
			
		when TaxiamentoDireitaB=>
			PistaTaxiamentoDir<='1';enable<='1';
			if(EmbarqueDir='0')then proximo_estado<=EmbarqueDireito1;
			elsif(EmbarqueDir='1' and EmbarqueEsq='0')then proximo_estado<=EmbarqueEsquerdo1;
			else proximo_estado<=TaxiamentoDireitaB;
			end if;
		
		when TaxiamentoDireitaC=>
			PistaTaxiamentoDir<='1';enable<='1';
			if(EmbarqueDir='0')then proximo_estado<=EmbarqueDireito1;
			elsif(EmbarqueDir='1' and EmbarqueEsq='0')then proximo_estado<=EmbarqueEsquerdo1;
			else proximo_estado<=TaxiamentoDireitaC;
			end if;
		
		when TaxiamentoDireitaD=>
			PistaTaxiamentoDir<='1';enable<='1';
			if(EmbarqueDir='0')then proximo_estado<=EmbarqueDireito1;
			elsif(EmbarqueDir='1' and EmbarqueEsq='0')then proximo_estado<=EmbarqueEsquerdo1;
			else proximo_estado<=TaxiamentoDireitaD;
			end if;
			
		when TaxiamentoEsquerdaA=>
			PistaTaxiamentoEsq<='1';enable<='1';
			if(EmbarqueDir='0')then proximo_estado<=EmbarqueDireito2;
			elsif(EmbarqueDir='1' and EmbarqueEsq='0')then proximo_estado<=EmbarqueEsquerdo2;
			else proximo_estado<=TaxiamentoEsquerdaA;
			end if;
		
		when TaxiamentoEsquerdaB=>
			PistaTaxiamentoEsq<='1';enable<='1';
			if(EmbarqueDir='0')then proximo_estado<=EmbarqueDireito2;
			elsif(EmbarqueDir='1' and EmbarqueEsq='0')then proximo_estado<=EmbarqueEsquerdo2;
			else proximo_estado<=TaxiamentoEsquerdaB;
			end if;
	
		when TaxiamentoEsquerdaC=>
			PistaTaxiamentoEsq<='1';enable<='1';
			if(EmbarqueDir='0')then proximo_estado<=EmbarqueDireito2; 
			elsif(EmbarqueDir='1' and EmbarqueEsq='0')then proximo_estado<=EmbarqueEsquerdo2;
			else proximo_estado<=TaxiamentoEsquerdaC;
			end if;
			
		when TaxiamentoEsquerdaD=>
			PistaTaxiamentoEsq<='1';enable<='1';
			if(EmbarqueDir='0')then proximo_estado<=EmbarqueDireito2;
			elsif(EmbarqueDir='1' and EmbarqueEsq='0')then proximo_estado<=EmbarqueEsquerdo2;
			else proximo_estado<=TaxiamentoEsquerdaD;
			end if;
			
		when EmbarqueDireito1=>
			EmbarqueDir<='1';
			if(RecebeFPGA="00000010")then
			proximo_estado<=AguardaDecolagem;
			else
			proximo_estado<=EmbarqueDireito1;
			end if;
			
		when EmbarqueEsquerdo1=>
			EmbarqueDir<='1';EmbarqueEsq<='1';
			if(RecebeFPGA="00000010")then
			proximo_estado<=AguardaDecolagem;
			else
			proximo_estado<=EmbarqueEsquerdo1;
			end if;
			
		when EmbarqueDireito2=>
			EmbarqueDir<='1';
			if(RecebeFPGA="00000010")then
			proximo_estado<=AguardaDecolagem;
			else
			proximo_estado<=EmbarqueDireito2;
			end if;
			
		when EmbarqueEsquerdo2=>
			EmbarqueDir<='1';EmbarqueEsq<='1';
			if(RecebeFPGA="00000010")then
			proximo_estado<=AguardaDecolagem;
			else
			proximo_estado<=EmbarqueEsquerdo2;
			end if;

		when AguardaDecolagem=>
			if(PistaTaxiamentoEsq='0')then 
			proximo_estado<=TaxiamentoEsquerdaDir;
			else 
			proximo_estado<=AguardaDecolagem;
			end if;
		
		when TaxiamentoEsquerdaDir=>
			PistaTaxiamentoEsq<='1';
			if(PistaPD='0')then 
				proximo_estado<=Decolagem;
			else
				proximo_estado<=TaxiamentoEsquerdaDir;
			end if;
		
		when Decolagem=>
			PistaPD<='1';enablef<='1';LEDvmD<='1';
			if (Stemp5="0000")then
				proximo_estado<=Voo;
			else
				proximo_estado<=Decolagem;
			end if;
		end case;
	end process;
end ControleAereo;