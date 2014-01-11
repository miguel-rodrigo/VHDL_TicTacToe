library IEEE;
use IEEE.std_logic_1164.all;
use work.T3defs.all;

entity input is
	port(	
		inputClk : in std_logic;
		matrixRow : in std_logic_vector(1 to 3);
		matrixCol : out std_logic_vector(1 to 3) := (others => '0');
		convInput : out T3move
	);
end input;

architecture input_arch of input is
begin
	process(inputClk)

	variable currCol : integer := 1;
	begin
		if(inputClk'event and inputClk = '1') then
			matrixCol(currCol) <= '1';
			if matrixRow(1) = '1' then
				convInput <= Move11 + (currCol - 1);
			elsif matrixRow(2) = '1' then
				convInput <= Move21 + (currCol - 1);
			elsif matrixRow(3) = '1' then
				convInput <= Move31 + (currCol - 1);
			else
				convInput <= NONE;
			end if;
			matrixCol(currCol) <= '0';

			if currCol = 3 then
				currCol := 1;
			else
				currCol := currCol+1;
			end if;
		end if;
	end process;

end input_arch;