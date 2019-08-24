library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
    Port ( clk : in STD_LOGIC;
           clock_divided : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

signal count: integer range 0 to 500 := 1;
signal temp : STD_LOGIC := '0';

begin
process(clk)
begin
    if rising_edge(clk) then
        if count < 500 then
            count <= count + 1;
        else
            temp <= not temp;
            count <= 1;
        end if;        
    end if;
end process;
clock_divided <= temp;
end Behavioral;        