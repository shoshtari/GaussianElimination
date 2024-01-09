LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE ieee.float_pkg.ALL;
USE work.arrays.ALL;

ENTITY computeGaussian IS
    PORT (
        clk : IN STD_LOGIC;

        a1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        b1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        a2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        b2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        p1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        p2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        ans1 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        ans2 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);

        data_in_changed : IN STD_LOGIC;
        data_ready : OUT STD_LOGIC;
    );
END ENTITY computeGaussian;

ARCHITECTURE rtl OF computeGaussian IS
    SIGNAL this_row : INTEGER := 0;
    SIGNAL order : t_array(0 TO N - 1);

BEGIN
    PROCESS (clk)

        VARIABLE common_a1, common_a2, common_b1, common_b2, common_p1, common_p2 : STD_LOGIC_VECTOR(4 DOWNTO 0);
        VARIABLE ans1_var, ans2_var : STD_LOGIC_VECTOR(4 DOWNTO 0);
    BEGIN
        IF rising_edge(calculate) THEN
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
            END LOOP

            common_p1 := common_p1 - common_b1 * ans2_var;
            ans1_var := 0;
            WHILE common_a1 * ans1_var < common_p1 LOOP
                ans1_var := ans1_var + 1;
            END LOOP

            ans1 <= ans1_var;
            ans2 <= ans2_var;

        END IF;
    END PROCESS;

END ARCHITECTURE rtl;