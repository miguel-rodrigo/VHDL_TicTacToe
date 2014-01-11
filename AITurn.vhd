library IEEE;
use IEEE.std_logic_1164.all;
use work.T3defs.all;

entity AITurn is
	port (
--		AItClk : in std_logic;
		AITrst : in std_logic;
		AITgrid : in T3grid;
		nMoves : in integer;
		AITMove : out T3move := NONE);
end AITurn;
		  
architecture AITurn_arch of AITurn is
	component checkTwo 
		port (
--			C2Clk : in std_logic;
			C2grid : in T3grid;
			C2Move : out T3move := NONE);
	end component;
	
	component AIpick
		port (
--			AIpClk : in std_logic;
			AIPrst : in std_logic;
			winMV, deffMV : in T3move;

			AIPgrid : in T3grid;

			numMoves : in integer;

			AIPmove : out T3move := NONE
			);
	end component;
	
	function invGrid (inG : T3grid) return T3grid is
	variable outG : T3grid;
	begin
		for i in 1 to 9 loop
			if (inG(i) = gridX or inG(i) = gridO) then
				outG(i)(0) := not inG(i)(0);
				outG(i)(1) := not inG(i)(1);
			end if;
		end loop;
		return outG;
	end invGrid;
	
	signal WINMV, DEFFMV : T3move;
	signal outMove : T3Move := NONE;
	
	begin
		U1: checkTwo port map (AITgrid,WINMV);
		U2: checkTwo port map (invGrid(AITgrid),DEFFMV); --nótese que gridX = not gridO de manera intencionada. ("not grid" era ilegal así que tuve que escribir la función).
		U3: AIpick port map(AITrst, WINMV,DEFFMV, AITgrid,nMoves,outMove);

	process(outMove, AITrst)
		begin
		if(AITrst = '1') then
			AITmove <= NONE;
		else
			AITmove <= outMove;
		end if;
	end process;
end AITurn_arch;