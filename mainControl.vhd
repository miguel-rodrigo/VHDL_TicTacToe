library IEEE;
use IEEE.std_logic_1164.all;
use work.T3defs.all;

entity mainControl is
	port(
--		mcClk : in std_logic;
		mcRst : in std_logic;
		Move : in T3move;
		TURNin : in T3Turn;
		gridIn : in T3grid;
		numMovesIn : in integer;
		TURNout : out T3Turn := "01";
		gridOut : out T3grid := ((others => (others => '0')));
		numMovesOut : out integer := 0
	);
end mainControl;

architecture mainC_arch of mainControl is
begin
	process(Move, mcRst)is
	begin
--		if mcClk'event and mcClk = '1' then
	if mcRst = '1' then
		turnOut <= TURNAI;
		gridOut <= (others => gridNone);
		numMovesOut <= 0;
	else
		if Move <= 9 and Move >= 1 then
			gridOut <= gridIn;

			case TURNin is
			when TURNAI =>
				if Move /= NONE then
					TURNout <= TURNPLY1;
					gridOut(Move) <= gridX;
					numMovesOut <= numMovesIn + 1;
				else
                    			TURNout <= TURNin; --para evitar el latch;
                    			--El latch es inevitable para numMovesOut
				end if;
				

			when TURNPLY1 => 
				if Move /= NONE then
					TURNout <= TURNPLY2;
					gridOut(Move) <= gridYell;
					--numMovesOut <= numMovesIn + 1;
				else
                    			TURNout <= TURNin;
				end if;

			when TURNPLY2 =>
				if Move /= NONE then
					if gridIn(Move) = gridYell then
						TURNout <= TURNAI;
						gridOut(Move) <= gridO;
						numMovesOut <= numMovesIn + 1;
					else
						gridOut(Move) <= gridYell;
						for i in 1 to 9 loop
							if gridIn(i) = gridYell then
								gridOut(i) <= gridNone;
								exit;
							end if; 
						end loop;
					end if;
				else
				    TURNout <= TURNin;
				end if;
			when others =>

			end case;
		end if;
--		end if;
	end if;
	end process;
end mainC_arch;
