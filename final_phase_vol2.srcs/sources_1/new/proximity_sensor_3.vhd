library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity proximity_sensor_3 is
    Port ( clk : in STD_LOGIC;
           sensor_echo3 : in STD_LOGIC;
           sensor_trigger3 : out STD_LOGIC;
           led3 : out STD_LOGIC);
end proximity_sensor_3;

architecture Behavioral of proximity_sensor_3 is

signal s : STD_LOGIC := '0';
signal count : integer range 0 to 580 := 0;

begin
process(clk)
begin
    if rising_edge(clk) then
        if s = '0' then
            sensor_trigger3 <= '1';
            s <= '1';
        else 
            sensor_trigger3 <= '0';
            if sensor_echo3 = '1' then
                count <= count + 1;
            elsif sensor_echo3 = '0' and count /= 0 then
                if count <= 58 then
                    led3 <= '1';
                else 
                    led3 <= '0';
                end if;
                s <= '0';
                count <= 0;
            end if;
         end if;
    end if;
end process;
end Behavioral;                    
                
