--De momento es totalmente inútil.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.T3defs.all;
 
entity display is
	port(
		inputClk : in std_logic;
		dispGrid : in T3grid;
		A : out  std_logic_vector (5 downto 0)
	);
end display;

architecture display_arch of display is

 signal counter : std_logic_vector(8 downto 0) := (others => '0');
 signal row : std_logic_vector(2 downto 0) := "110";
 signal col : std_logic_vector(2 downto 0) := "001";

begin
   process(inputClk)
   begin
     if inputClk'event and inputClk = '1' then
       counter <= counter+1;
            if counter = 0 then
                col <= col(1 downto 0) & col(2);
                if col = "100" then
                    row <= row(1 downto 0) & row(2);
                end if;
            end if;
            A(2 downto 0) <= row;
            A(5 downto 3) <= col;
     end if;
   end process;
 
 
end display_arch;