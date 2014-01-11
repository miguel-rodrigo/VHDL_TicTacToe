library IEEE;
use IEEE.std_logic_1164.all;
use work.T3defs.all;

entity turnMux is
	port(
--		muxClk : in std_logic;
		muxRst : in std_logic;
		turn : in T3turn;
		moveP : in T3move;
		moveAI : in T3move;
		moveOut : out T3move := NONE
	);
end turnMux;

architecture turnMux_arch of turnMux is

begin
	process(turn, moveP, moveAI, muxRst) --es casi seguro que los 'move' cambiarán a mitad de un turno y no simultáneamente, especialmente en el caso del jugador.
	begin
						--if muxClk'event and muxClk = '1' then
	if(muxRst = '1') then
		moveOut <= NONE;
	else
		if(turn = TURNAI) then
			moveOut  <= moveAI;
		elsif(turn = TURNPLY1 or turn = TURNPLY2) then
			moveOut <= moveP;
		else
		    moveOut <= NONE; 
		end if;
	end if;
						--end if;
	end process;
end turnMux_arch;