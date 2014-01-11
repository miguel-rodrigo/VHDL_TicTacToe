library IEEE;
use IEEE.std_logic_1164.all;
use work.T3defs.all;

entity playerTurn is
	port(
		PTClk : in std_logic;
		extInput : in T3move;
		extGrid : in T3grid;
		vMove : out T3move := NONE
	);
end playerTurn;

architecture playerTurn_arch of playerTurn is

component validateMove
	port(
		valMoveClk : in std_logic;
		input : in T3move;
		grid : in T3grid;
		valMove : out T3move
	);
end component;

begin
	U1 : validateMove port map(PTClk, extInput, extGrid, vMove);
end playerTurn_arch;