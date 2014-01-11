library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.T3defs.all;

entity AIpick is

	port(
		AIPrst : in std_logic;
		winMV, deffMV : in T3move;
		AIPgrid : in T3grid;
		numMoves : in integer;
		AIPmove : out T3move := NONE
	);

end AIpick;

architecture AIpick_arch of AIpick is
begin
	process(AIPrst, AIPgrid)
	begin
	
	if(AIPrst = '1') then
		AIPmove <= NONE;
	else
		if(winMV /= NONE) then
			AIPmove <= winMV;
		elsif(deffMV /= NONE) then
			AIPmove <= deffMV;
		else
			case numMoves is
				when 0 =>
					if AIPgrid(Move11) = gridNone then
						AIPmove <= Move11;
					else
						AIPmove <= Move22;
						end if;
				when 2 => 
					if to_integer(unsigned(AIPgrid(Move21)))+to_integer(unsigned(AIPgrid(Move12)))+to_integer(unsigned(AIPgrid(Move23)))+to_integer(unsigned(AIPgrid(Move32))) > to_integer(unsigned(gridNone)) then
						AIPmove <= Move22;
					elsif AIPgrid(Move33) = gridNone then
						AIPmove <= Move33;
					elsif AIPgrid(Move13) <= gridNone then
						AIPmove <= Move13;
					else
						AIPmove <= Move31;
					end if;
				when others =>
					for i in 1 to 9 loop
						if AIPgrid(i) = gridNone then
							AIPmove <= i;
							exit;
						end if;
					end loop;
			end case;
		end if;
	end if;
	end process;
end AIpick_arch;
