-- TRAFFIC LIGHTS CONTROLLER
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity traffic_lights is
	port(
		clk : in STD_LOGIC;
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
        is_done: out STD_LOGIC
        );
	    
end entity traffic_lights;
architecture Behavioral of traffic_lights is
type state_type is (s0, s1, s2, s3, s4, s5,s6,s7,s8,s9,s10); -- defined state for each combination possible
type ambulance_type is (a1,a2,a3);
signal state : state_type := s0; -- initial state is s0
signal ambulance: ambulance_type:= a1;
signal count : integer := 0; -- represents time
constant one_second:  integer:= 100000000;
signal lights: std_logic_vector(0 to 8); -- a vector that represents a state
signal is_done_s: std_logic:= '0';
signal count_cars_1_signal_pre: std_logic;
signal count_cars_2_signal_pre: std_logic;
signal count_cars_3_signal_pre: std_logic;
signal ambulance_1: std_logic;
signal ambulance_2: std_logic;
signal ambulance_3: std_logic;
shared variable road_1_sum : integer := 0;
shared variable road_2_sum : integer := 0;
shared variable road_3_sum : integer := 0;


begin
process ( count_cars_1 , clk, clk_reset)
begin  
    if rising_edge( clk ) then 
     if ( count_cars_1_signal_pre = '0' and count_cars_1 = '1' and is_done_s = '0' )then
           road_1_sum := road_1_sum + 1;
     end if;
        count_cars_1_signal_pre <= count_cars_1;
     end if;
end process;

process ( count_cars_2 , clk, clk_reset)
begin       
  if rising_edge(clk) then 
     if ( count_cars_2_signal_pre = '0' and count_cars_2 = '1' and is_done_s = '0' )then
           road_2_sum := road_2_sum + 1;
      end if;
        count_cars_2_signal_pre <= count_cars_2;
  end if;
 end process;
 
process ( count_cars_3, clk, clk_reset)
begin  
    if clk_reset = '1' then
       road_3_sum := 0;
    end if;
    if rising_edge( clk ) then
      if ( count_cars_3_signal_pre = '0' and count_cars_3 = '1' and is_done_s = '0' )then
            road_3_sum := road_3_sum + 1;
      end if;
         count_cars_3_signal_pre <= count_cars_3;
    end if;
 end process;


process (clk , rfid_1)
    begin 
        if rising_edge(clk) then 
            ambulance_1 <= rfid_1;
         end if;
end process;


process (clk , rfid_2)
    begin 
        if rising_edge(clk) then 
            ambulance_2 <= rfid_2;
         end if;
end process;


process (clk , rfid_3)
    begin 
        if rising_edge(clk) then 
            ambulance_3 <= rfid_3;
         end if;
end process;


process(clk, clk_reset)
    begin
        if clk_reset = '1' then
            state <= s0;
            count <= 0;
        elsif clk'event and clk = '1' then
            case state is
                when s0 =>
                    if count < one_second * 10 then
                        state <= s0;
                        count <= count + 1;
                    else
                        state <= s1;
                        count <= 0;
                    end if;
                when s1 =>
                        if count < one_second * 4 then
                            state <= s1;
                            count <= count + 1;
                        else
                            state <= s2;
                            count <= 0;
                        end if;
                 when s2 =>  
                        if ambulance_2 = '1' then  
                            state <= s3;
                        elsif ambulance_3 = '1' then 
                            state <= s8;
                        else
                        if road_1_sum > road_2_sum and road_1_sum > road_3_sum  then
                            is_done_s <= '1';
                            if count < one_second * 10 then
                                state <= s2;
                                count <= count + 1;   
                            else 
                                state <= s3;
                                count <= 0;
                            end if; 
                        else 
                            if count < one_second * 6 then
                                state <= s2;
                                count <= count + 1;   
                            else 
                                state <= s3;
                                count <= 0;
                            end if;
                        end if; 
                    end if;   
                        
                    when s3 =>
                        if count < one_second * 4 then
                            state <= s3;
                            count <= count + 1;
                        else 
                            state <= s4;
                            count <= 0;
                        end if;
                  when s4 =>
                    if ambulance_1 = '1' then
                        state <= s9;
                    elsif ambulance_3 = '1' then
                        state <= s5;
                    else
                        if road_2_sum > road_1_sum and road_2_sum > road_3_sum  then  
                            is_done_s <= '1';     
                            if count < one_second * 10 then
                                count <= count + 1;
                            else 
                                state <= s5;
                                count <= 0;
                            end if;
                        else 
                            if count < one_second * 6  then
                                count <= count + 1;
                            else 
                                state <= s5;
                                count <= 0;
                            end if;
                    end if;
                 end if;
                  when s5 =>
                        if count < one_second * 4 then 
                            state <= s5;
                            count <= count + 1;
                        else 
                            state <= s6;
                            count <= 0;
                        end if;
                  when s6 =>
                        if ambulance_1 = '1' then
                            state <= s7;
                         elsif ambulance_2 = '1' then
                            state <= s10;
                         else 
                               if road_3_sum > road_1_sum and road_3_sum > road_2_sum then 
                                is_done_s <= '1'; 
                                    if count < one_second * 10 then
                                        state <= s6;
                                        count <= count + 1;
                                    else 
                                        state <= s7;
                                        count <= 0;
                                end if;
                          else
                                if count < one_second * 6 then
                                    state <= s6;
                                    count <= count + 1;
                                else 
                                    state <= s7;
                                    count <= 0;
                                end if; 
                            end if;
                       end if;
                  when s7 => 
                        if count < one_second * 4 then
                            state <= s7;
                            count <= count + 1;
                        else 
                            state <= s2;
                            count <= 0;
                            is_done_s <= '1';
                    end if;
                    when s8 =>
                        if count < one_second * 4 then
                            state <= s8;
                            count <= count + 1;
                         else 
                             state <= s6;
                             count <= 0;
                         end if;
                    when s9 =>
                        if count < one_second * 4 then
                             state <= s9;
                             count <= count + 1;
                         else 
                            state <= s2;
                            count <= 0;
                         end if;
                     when s10 =>
                        if count < one_second * 4 then
                            state <= s10;
                            count <= count + 1;
                        else 
                           state <= s4;
                           count <= 0;
                        end if;
                     when others =>
                        state <= s0;
                    end case; 
        end if; 
   end process;
    
        C2: process(state)
        begin
        case state is
         when s0 => lights <= "100100100";
         when s1 => lights <= "110100100";
         when s2 => lights <= "001100100";
         when s3 => lights <= "010110100";
         when s4 => lights <= "100001100";
         when s5 => lights <= "100010110";
         when s6 => lights <= "100100001";
         when s7 => lights <= "110100010";
         when s8 => lights <= "010100110";
         when s9 => lights <= "110010100";
         when s10 => lights <= "100110010";
         when others => lights <= "100100100";
        end case;
        end process;
         red1 <= lights(0);
         yellow1 <= lights(1);
         green1 <= lights(2);
         red2 <= lights(3);
         yellow2 <= lights(4);
         green2 <= lights(5);
         red3 <= lights(6);
         yellow3 <= lights(7);
         green3 <= lights(8);
end architecture Behavioral;