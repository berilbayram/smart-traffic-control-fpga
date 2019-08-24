library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity proximity_sensor_1 is
    Port ( clk : in STD_LOGIC;
           sensor_echo1 : in STD_LOGIC;
           sensor_trigger1 : out STD_LOGIC;
           led : out STD_LOGIC);
end proximity_sensor_1;

architecture Behavioral of proximity_sensor_1 is

signal s : STD_LOGIC := '0';
signal count : integer range 0 to 580 := 0;

begin
process(clk)
begin
    if rising_edge(clk) then
        if s = '0' then
            sensor_trigger1 <= '1';
            s <= '1';
        else 
            sensor_trigger1 <= '0';
            if sensor_echo1 = '1'  then
                count <= count + 1;
            elsif sensor_echo1 = '0'  and count /= 0 then
                if count <= 58 then
                    led <= '1';
                else 
                    led <= '0';
                end if;
                s <= '0';
                count <= 0;
            end if;
         end if;
    end if;
end process;
end Behavioral;                    
                
