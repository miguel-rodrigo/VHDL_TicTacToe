--Además de validar movimientos, este bloque hace que mainControl distinga entre
--dos pulsaciones seguidas de la misma tecla al hacer valer "NONE" a la entrada
--inmediatamente tras renovarse el valor de "grid".

library IEEE;
use IEEE.std_logic_1164.all;
use work.T3defs.all;

entity validateMove is
	port (
		valMoveClk : in std_logic;
		INPUT : in T3move;
		grid : in T3grid;
		valMove : out T3move := NONE);
end validateMove;

architecture validateMove_arch of validateMove is
	begin
		process (grid, INPUT, valMoveclk) IS
		begin
		--if(valMoveClk'event) then
			if(INPUT /= NONE) then
				if (grid(INPUT) = gridNone or grid(input) = gridYell) then
					valMove <= INPUT;
				else
					valMove <= NONE;
				end if;
			else
				valMove <= NONE;
			end if;
		--end if;
		end process;
end validateMove_arch;