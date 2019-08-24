library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
    Port( clk : in STD_LOGIC;
          sensor_echo1 : in STD_LOGIC;
          sensor_trigger1 : out STD_LOGIC;
          sensor_echo2 : in STD_LOGIC;
          sensor_trigger2 : out STD_LOGIC;
          sensor_echo3 : in STD_LOGIC;
          sensor_trigger3 : out STD_LOGIC;
          led : out STD_LOGIC;
          led2 : out STD_LOGIC;
          led3: out STD_LOGIC;
          led4: out STD_LOGIC;
          led5: out STD_LOGIC;
          led6: out STD_LOGIC;
          clk_reset: in STD_LOGIC;
          red1 : out STD_LOGIC;
          yellow1 : out STD_LOGIC;
          green1 : out STD_LOGIC;
          red2 : out STD_LOGIC;
          yellow2 : out STD_LOGIC;
          green2 : out STD_LOGIC;
          red3 : out STD_LOGIC;
          yellow3 : out STD_LOGIC;
          green3 : out STD_LOGIC;
          rfid_1 : in STD_LOGIC;
          rfid_2 : in STD_LOGIC;
          rfid_3 : in STD_LOGIC;
          is_done : out STD_LOGIC
          );
end top_module;

architecture Behavioral of top_module is

component clock_divider is
    Port(
         clk : in STD_LOGIC;
         clock_divided : out STD_LOGIC
         );
end component;

component proximity_sensor_1 is
    Port(
         clk : in STD_LOGIC;
         sensor_echo1 : in STD_LOGIC;
         sensor_trigger1 : out STD_LOGIC;
         led : out STD_LOGIC
        );
end component;
component proximity_sensor_2 is
    Port(
         clk : in STD_LOGIC;
         sensor_echo2 : in STD_LOGIC;
         sensor_trigger2 : out STD_LOGIC;
         led2 : out STD_LOGIC
        );
end component;
     
component proximity_sensor_3 is
    Port(
         clk : in STD_LOGIC;
         sensor_echo3 : in STD_LOGIC;
         sensor_trigger3 : out STD_LOGIC;
         led3 : out STD_LOGIC
        );
end component;


component traffic_lights is
    Port ( clk : in STD_LOGIC;
		clk_reset: in STD_LOGIC;
		red1 : out STD_LOGIC;
		yellow1 : out STD_LOGIC;
		green1 : out STD_LOGIC;
		red2 : out STD_LOGIC;
		yellow2 : out STD_LOGIC;
		green2 : out STD_LOGIC;
		red3 : out STD_LOGIC;
        yellow3 : out STD_LOGIC;
        green3 : out STD_LOGIC;
		count_cars_1 : in STD_LOGIC;
        count_cars_2 : in STD_LOGIC;
        count_cars_3 : in STD_LOGIC;
        rfid_1: in STD_LOGIC;
        rfid_2: in STD_LOGIC;
        rfid_3: in STD_LOGIC;
        is_done: out STD_LOGIC);
	     
end component traffic_lights;
 
signal clock_sig : STD_LOGIC := '0';
signal led_sig_1 : STD_LOGIC := '0';
signal led_sig_2 : STD_LOGIC := '0';
signal led_sig_3 : STD_LOGIC := '0';
signal led_sig_4 : STD_LOGIC := '0';
signal led_sig_5 : STD_LOGIC := '0';
signal led_sig_6 : STD_LOGIC := '0';
signal led_sig_7 : STD_LOGIC := '0';

begin
clk_divider : clock_divider port map(clk,
                                     clock_sig);
sensor_1 : proximity_sensor_1 port map(clock_sig,
                                       sensor_echo1,
                                       sensor_trigger1,
                                       led_sig_1);
sensor_2 : proximity_sensor_2 port map(clock_sig,
                                       sensor_echo2,
                                       sensor_trigger2,
                                       led_sig_2);
sensor_3 : proximity_sensor_3 port map(clock_sig,
                                       sensor_echo3,
                                       sensor_trigger3,
                                       led_sig_3);
  
traffic_ligths : traffic_lights port map ( 
                                       clk,
                                       clk_reset,         
                                       red1,
                                       yellow1,
                                       green1,
                                       red2,
                                       yellow2,
                                       green2,
                                       red3,
                                       yellow3,
                                       green3,
                                       led_sig_1,
                                       led_sig_2,
                                       led_sig_3,
                                       rfid_1,
                                       rfid_2,
                                       rfid_3,
                                       is_done
                                       );
led <= led_sig_1;
led2 <= led_sig_2;
led3 <= led_sig_3;
led4 <= rfid_1;
led5 <= rfid_2;
led6 <= rfid_3;

end Behavioral;          