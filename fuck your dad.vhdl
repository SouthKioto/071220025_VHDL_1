LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY state_machine IS
  PORT(
    sw   : in  std_logic_vector(0 downto 0);  
    key  : in  std_logic_vector(0 downto 0);  
    ledZ : out std_logic_vector(0 downto 0);  
    ledR : out std_logic_vector(8 downto 0)
  );
END state_machine;

ARCHITECTURE Behavior OF state_machine IS

  TYPE State_type IS (A, B, C, D, E, F, G, H, I);
  SIGNAL ST : State_type := A;

BEGIN

  PROCESS(key(0))
  BEGIN
    IF rising_edge(key(0)) THEN

      IF sw(0) = '0' THEN
        CASE ST IS
          WHEN A => ST <= B;
          WHEN B => ST <= C;
          WHEN C => ST <= D;
          WHEN D => ST <= E;
          WHEN E => ST <= A;   
          WHEN OTHERS => ST <= A;
        END CASE;

      ELSE
        CASE ST IS
          WHEN F => ST <= G;
          WHEN G => ST <= H;
          WHEN H => ST <= I;
          WHEN I => ST <= F;  
          WHEN OTHERS => ST <= F;
        END CASE;

      END IF;

    END IF;
  END PROCESS;


  WITH ST SELECT
    ledR <= "000000001" WHEN A,
            "000000010" WHEN B,
            "000000100" WHEN C,
            "000001000" WHEN D,
            "000010000" WHEN E,
            "000100000" WHEN F,
            "001000000" WHEN G,
            "010000000" WHEN H,
            "100000000" WHEN I;

  ledZ(0) <= '1' WHEN (ST = E OR ST = I) ELSE '0';

END Behavior;
