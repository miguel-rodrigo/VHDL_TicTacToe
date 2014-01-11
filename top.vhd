library IEEE;
use IEEE.std_logic_1164.all;
use work.T3defs.all;

entity top is
	port(
		clk : in std_logic;
		sysRst : in std_logic := '0';
		boardInput : in T3move;
		disp : out T3grid
	);
end top;

architecture top_arch of top is

component AITurn
	port(
--		AItClk : in std_logic;
		AITrst : in std_logic;
		AITgrid : in T3grid;
		nMoves : in integer;
		AITmove : out T3move := NONE
	);
end component;

component playerTurn
	port(
		PTClk : in std_logic;
		extInput : in T3move;
		extGrid : in T3grid;
		vMove : out T3move := NONE
	);
end component;

component turnMux
	port(
--		muxClk : in std_logic;
		muxRst : in std_logic;
		turn : in T3turn;
		moveP : in T3move;
		moveAI : in T3move;
		moveOut : out T3move := NONE
	);
end component;

component mainControl
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
end component;

component DtypeFlop
	port(
		flopClk: in std_logic;
		rst : in std_logic := '1';
		gridD: in T3grid := ((others => (others => '0')));
		turnD : in T3turn := "01";
		numMovesD : in integer := 0;
		gridQ : out T3grid := ((others => (others => '0')));
		turnQ : out T3turn := "01";
		numMovesQ : out integer := 0
	);
end component;

signal moveAI, moveP : T3Move;
signal realMove : T3Move := NONE;
signal topTurn : T3turn;
signal newTurn : T3turn := "01";
signal topGrid : T3grid;
signal newGrid : T3grid := ((others => (others => '0')));
signal topNMoves : integer;
signal newNMoves : integer := 0;

begin
	Flp : DtypeFlop port map(clk, sysRst , newGrid, newTurn, newNMoves, topGrid, topTurn, topNMoves);
	AIT : AITurn port map(sysRst, topGrid,topNMoves,moveAI);
	PT : playerTurn port map(clk, boardInput, topGrid, moveP);
	TM : turnMux port map(sysRst, topTurn, moveP, moveAI, realMove);
	MC : mainControl port map(sysRst, realMove, topTurn, topGrid, topNMoves, newTurn, newGrid, newNMoves);
	
	disp <= topGrid;
end top_arch;