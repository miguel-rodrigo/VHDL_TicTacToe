library IEEE;
use IEEE.std_logic_1164.all;
use work.T3defs.all;

entity DtypeFlop is
	port(
		flopClk: in std_logic;
		rst : in std_logic := '1';
		gridD: in T3grid := ((others => (others => '0')));
		turnD : in T3turn := "01";
		numMovesD : in integer := 0;
		gridQ : out T3grid := ((others => (others => '0')));
		turnQ : out T3turn := "01";
		numMovesQ : out integer := 0
	);
end DtypeFlop;

architecture DtypeFlop_arch of DtypeFlop is
begin
	process(flopClk, rst)
	begin
		if(rst = '1') then
			gridQ <= (others => gridNone);
			turnQ <= "01";
			numMovesQ <= 0;
			--rst <= '0' en la entrada, para evitar que vuelva a resetearse.
		elsif(flopClk'event and flopClk='1') then
			gridQ <= gridD;
			turnQ <= turnD;
			numMovesQ <= numMovesD;
		end if;
	end process;
end DtypeFlop_arch;