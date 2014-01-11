library IEEE;

use IEEE.std_logic_1164.all;

use work.T3defs.all;


entity testBench is

end testBench;



architecture tB_arch of testBench is

	component top

		port(

			clk : in std_logic;

			sysRst : in std_logic := '0';
			boardInput : in T3move;

			disp : out T3grid

		);

	end component;

	

	signal simInput : T3move := NONE;

	signal simClk, simRst : std_logic;

	signal simDisp : T3grid;


	
constant ciclo : time := 100 ns;
 
	
begin

	U1 : top port map(simClk, simRst, simInput, simDisp);

	

	GenCLK: process --copiado directamente de las prácticas.

	begin		
		simClk <= '0';
		wait for ciclo/2;		
		simClk <= '1';
		wait for ciclo/2;

	end process GenCLK;

	

	tb : process

	begin

		----Inicializaciones----


		simRst <= '1';
		wait for 20 ns;
		simRst <= '0';
		----Comienzo----

		--Aquí debería haber tan solo una X en la esquina y todo lo demás vacío

		wait for 1 us;

		simInput <= Move22;


		--wait for 1 us;

		--simInput <= NONE;
	
		wait for 1 us; --el jugador confirma el movimiento.
		simInput <= Move22;

		wait for 1 us;

		simInput <= Move13;


	
		wait for 1 us;

	
	
end process tb;

end tb_arch;