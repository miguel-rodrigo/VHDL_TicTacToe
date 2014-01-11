library IEEE;

use IEEE.std_logic_1164.all;

use IEEE.numeric_std.all;

use work.T3defs.all;


entity AIpick is

	port(
--		AIpClk : in std_logic;
		AIPrst : in std_logic;

		winMV, deffMV : in T3move;

		AIPgrid : in T3grid;

		numMoves : in integer;

		AIPmove : out T3move := NONE

	);

end AIpick;



architecture AIpick_arch of AIpick is

--variable gmb : integer;
 --identificación de la estrategia que se está llevando a cabo.

						  --esta variable ya no se usa, sólo era de utilidad con el algoritmo antiguo. Estas

						  --cosas las dejo sólo para que sepa lo que ha ido cambiando.


begin

	process(AIPrst, AIPgrid)

	begin

--		if AIpClk'event and AIpClk = '1' then

--			numMoves <= 0;

--			for i in 1 to 9 loop

--				if(AIPgrid(i) /= gridNone) then

--					numMoves <= numMoves+1; --saber cuántos turnos lleva la máquina.De momento siempre empieza ella.

--				end if;

--			end loop;

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

							AIPmove <= Move22; --si se da este caso ha habido algún error, ya que la máquina empieza siempre de momento.

						end if;

					when 2 => 

						if to_integer(unsigned(AIPgrid(Move21)))+to_integer(unsigned(AIPgrid(Move12)))+to_integer(unsigned(AIPgrid(Move23)))+to_integer(unsigned(AIPgrid(Move32))) > to_integer(unsigned(gridNone)) then --si el jugador ha puesto en un borde.

							AIPmove <= Move22;

						elsif AIPgrid(Move33) = gridNone then

							AIPmove <= Move33;

						elsif AIPgrid(Move13) <= gridNone then

							AIPmove <= Move13; --el orden de los dos últimos casos es indiferente corresponden a paralelas respecto a la diagonal.

						else

							AIPmove <= Move31;

						end if;

					when others =>
 
						for i in 1 to 9 loop

							if AIPgrid(i) = gridNone then
 --En los casos en los que no toca, por asegurarme que nada falla, elige un movimiento
								AIPmove <= i;
         --aunque sea poner en el primer sitio que encuentre libre.
								exit;

							end if;

						end loop;
				end case;

			end if;
end if;

--		end if;

	end process;


end AIpick_arch;