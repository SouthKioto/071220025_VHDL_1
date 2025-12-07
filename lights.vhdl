LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY state_machine IS
    PORT(
        slider   : IN  std_logic_vector(2 downto 0);
        leds     : OUT std_logic_vector(2 downto 0);
        display  : OUT std_logic_vector(6 downto 0)
    );
END state_machine;

ARCHITECTURE behavior OF state_machine IS

    TYPE State_type IS (RED, YELLOW, GREEN, BLINKING, RED_YELLOW);
    SIGNAL state : State_type := RED;

BEGIN

    PROCESS(slider)
    BEGIN
        CASE slider IS
            WHEN "000" => state <= RED;
            WHEN "001" => state <= YELLOW;
            WHEN "010" => state <= GREEN;
            WHEN "011" => state <= BLINKING;
            WHEN "100" => state <= RED_YELLOW;
            WHEN OTHERS => state <= RED_YELLOW;
        END CASE;
    END PROCESS;

    PROCESS(state)
    BEGIN
        CASE state IS
            WHEN RED =>
                leds    <= "100";
                display <= "0000001";
            WHEN YELLOW =>
                leds    <= "010";
                display <= "1001111";
            WHEN GREEN =>
                leds    <= "001";
                display <= "0010010";
            WHEN BLINKING =>
                leds    <= "110";
                display <= "0000110";
            WHEN RED_YELLOW =>
                leds    <= "110";
                display <= "1110001";
        END CASE;
    END PROCESS;

END behavior;
