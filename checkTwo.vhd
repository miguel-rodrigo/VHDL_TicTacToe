library IEEE;
use IEEE.std_logic_1164.all;
use work.T3defs.all;

--El objetivo de esta entidad es comprobar si existe algún movimiento ganador
--para la entrada X siendo el rival la entrada O. No discrimina según esa entrada
--sea el jugador real o la IA.

entity checkTwo is
	port(
--		C2Clk : in std_logic;
		C2grid : in T3grid;
		C2Move : out T3move
	);
end checkTwo;

architecture checkTwo_arch of checkTwo is
begin --comprobando cada una de las 4 esquinas y el centro queda todo comprobado.
	process (C2grid) is
	begin
--		if C2Clk'event and C2Clk = '1' then
		--casos de casillas contiguas desde las esquinas. 
			if C2grid(Move11) = gridX then
				if C2grid(Move12) = gridX AND C2grid(Move13) /= gridO then
					C2Move <= Move13;
				elsif C2grid(Move21) = gridX AND C2grid(Move31) /= gridO then
					C2Move <= Move31;
				elsif C2grid(Move22) = gridX AND C2grid(Move33) /= gridO then
					C2Move <= Move33;
				elsif C2grid(Move13) = gridX AND C2grid(Move12) /= gridO then
					C2Move <= Move12;
				elsif C2grid(Move31) = gridX AND C2grid(Move21) /= gridO then
					C2Move <= Move21;
				elsif C2grid(Move33) = gridX AND C2grid(Move22) /= gridO then
					C2Move <= Move22;
				else
					C2Move <= NONE;
				end if;
			elsif C2grid(Move13) = gridX then
				if C2grid(Move12) = gridX AND C2grid(Move11) /= gridO then
					C2Move <= Move11;
				elsif C2grid(Move23) = gridX AND C2grid(Move33) /= gridO then
					C2Move <= Move33;
				elsif C2grid(Move22) = gridX AND C2grid(Move31) /= gridO then
					C2Move <= Move31;
				elsif C2grid(Move11) = gridX AND C2grid(Move12) /= gridO then
					C2Move <= Move12;
				elsif C2grid(Move31) = gridX AND C2grid(Move22) /= gridO then
					C2Move <= Move22;
				elsif C2grid(Move33) = gridX AND C2grid(Move23) /= gridO then
					C2Move <= Move23;
			    	else
			        	C2Move <= NONE;
				end if;
			elsif C2grid(Move31) = gridX then
				if C2grid(Move21) = gridX AND C2grid(Move11) /= gridO then
					C2Move <= Move11;
				elsif C2grid(Move32) = gridX AND C2grid(Move33) /= gridO then
					C2Move <= Move33;
				elsif C2grid(Move22) = gridX AND C2grid(Move13) /= gridO then
					C2Move <= Move13;
				elsif C2grid(Move11) = gridX AND C2grid(Move23) /= gridO then
					C2Move <= Move23;
				elsif C2grid(Move13) = gridX AND C2grid(Move22) /= gridO then
					C2Move <= Move22;
				elsif C2grid(Move33) = gridX AND C2grid(Move32) /= gridO then
					C2Move <= Move32;
				else
                    			C2Move <= NONE;
				end if;
			elsif C2grid(Move33) = gridX then
				if C2grid(Move23) = gridX AND C2grid(Move13) /= gridO then
					C2Move <= Move13;
				elsif C2grid(Move32) = gridX AND C2grid(Move31) /= gridO then
					C2Move <= Move31;
				elsif C2grid(Move22) = gridX AND C2grid(Move11) /= gridO then
					C2Move <= Move11;
				elsif C2grid(Move11) = gridX AND C2grid(Move22) /= gridO then
					C2Move <= Move22;
				elsif C2grid(Move31) = gridX AND C2grid(Move32) /= gridO then
					C2Move <= Move32;
				elsif C2grid(Move13) = gridX AND C2grid(Move23) /= gridO then
					C2Move <= Move23;
				else
                    			C2Move <= NONE;
				end if;
			else
			    C2Move <= NONE;
			end if;
			
			--Ahora compruebo el centro.
			if C2grid(Move22) = gridX then
				if C2grid(Move21) = gridX then
					C2Move <= Move23;
				elsif C2grid(Move12) = gridX then
					C2Move <= Move32;
				elsif C2grid(Move23) = gridX then
					C2Move <= Move21;
				elsif C2grid(Move32) = gridX then
					C2Move <= Move12;
				else
				    C2Move <= NONE;
				end if;
			elsif (C2grid(Move21) = gridX AND C2grid(Move23) = gridX) OR (C2grid(Move12) = gridX AND C2grid(Move32) = gridX) then --uniones que atraviesan el centro desde los bordes
				C2Move <= Move22;  																				  --nótese que desde las esquinas ya ha sido tratado.
			--else
			    --Move <= NONE; --claro esto hace que siempre valga NONE :(
			end if;
--		end if;
	end process;
end checkTwo_arch;