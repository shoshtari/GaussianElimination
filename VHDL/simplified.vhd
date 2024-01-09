											   LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE ieee.float_pkg.ALL;	

ENTITY computeGaussian IS
    PORT (
        clk : IN STD_LOGIC;

        a1 : IN INTEGER;
        b1 : IN INTEGER;

        a2 : IN INTEGER;
        b2 : IN INTEGER;

        p1 : IN INTEGER;
        p2 : IN INTEGER;

        ans1 : OUT INTEGER;
        ans2 : OUT INTEGER;

        start_calculate : IN STD_LOGIC;
        data_ready : OUT STD_LOGIC
    );
END ENTITY computeGaussian;

ARCHITECTURE rtl OF computeGaussian IS

BEGIN
    PROCESS (start_calculate)

        VARIABLE common_a1, common_a2, common_b1, common_b2, common_p1, common_p2 : INTEGER;
        VARIABLE ans1_var, ans2_var : INTEGER;
    BEGIN
        IF rising_edge(start_calculate) THEN
            common_a1 := a1 * a2;
            common_b1 := b1 * a2;
            common_p1 := p1 * a2;

            common_a2 := a2 * a1;
            common_b2 := b2 * a1;
            common_p2 := p2 * a1;

            common_a2 := common_a2 - common_a1;
            common_b2 := common_b2 - common_b1;
            common_p2 := common_p2 - common_p1;

            -- til now:
            -- ax + by = c 
            -- dy = e;
            ans2_var := 0;
            WHILE common_b2 * ans2_var < common_p2 LOOP
                ans2_var := ans2_var + 1;
            END LOOP;

            common_p1 := common_p1 - common_b1 * ans2_var;
            ans1_var := 0;
            WHILE common_a1 * ans1_var < common_p1 LOOP
                ans1_var := ans1_var + 1;
            END LOOP;

            ans1 <= ans1_var;
            ans2 <= ans2_var;

        END IF;
    END PROCESS;

END ARCHITECTURE rtl;