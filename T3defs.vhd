library IEEE;
use IEEE.std_logic_1164.all;

package T3defs is
type T3grid is array (1 to 9) of std_logic_vector(0 to 1);
subtype T3move is integer;
subtype T3Turn is std_logic_vector (0 to 1);
                                  
constant MOVE11: T3move := 1;
constant MOVE12: T3move := 2;
constant MOVE13: T3move := 3;
constant MOVE21: T3move := 4;
constant MOVE22: T3move := 5;
constant MOVE23: T3move := 6;
constant MOVE31: T3move := 7;
constant MOVE32: T3move := 8;
constant MOVE33: T3move := 9;
constant NONE: T3move := 0;

constant TURNAI: T3Turn := "01";
constant TURNPLY1: T3Turn := "10";
constant TURNPLY2: T3Turn := "11"; --turno en el que el jugador confirma su jugada. Con el cambio de grid, puede ser prescindible in convertir T3turn en std_logic
constant TURNNONE : T3Turn := "00";

constant gridX : std_logic_vector(0 to 1) := "01";
constant gridO : std_logic_vector(0 to 1) := "10";
constant gridYell : std_logic_vector(0 to 1) := "11";
constant gridNone : std_logic_vector(0 to 1) := "00";

end T3defs;                       