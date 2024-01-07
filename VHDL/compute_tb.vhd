LIBRARY gaussian;
LIBRARY ieee;
USE gaussian.arrays.ALL;
USE ieee.float_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.arrays.ALL;

-- Add your library and packages declaration here ...

ENTITY computegaussian_tb IS
    -- Generic declarations of the tested unit
    GENERIC (
        N : INTEGER := 2);
END computegaussian_tb;

ARCHITECTURE TB_ARCHITECTURE OF computegaussian_tb IS
    -- Component declaration of the tested unit
    COMPONENT computegaussian
        GENERIC (
            N : INTEGER := 2);
        PORT (
            clk : IN STD_LOGIC;
            coefficients_in : IN t_coefficients(0 TO N - 1, 0 TO N - 1);
            products_in : IN t_products(0 TO N - 1);
            result : OUT t_result(0 TO N - 1);
            data_in_changed : IN STD_LOGIC;
            data_ready : OUT STD_LOGIC);
    END COMPONENT;

    -- Stimulus signals - signals mapped to the input and inout ports of tested entity
    SIGNAL clk : STD_LOGIC;
    SIGNAL coefficients_in : t_coefficients(0 TO N - 1, 0 TO N - 1);
    SIGNAL products_in : t_products(0 TO N - 1);
    SIGNAL data_in_changed : STD_LOGIC;
    -- Observed signals - signals mapped to the output ports of tested entity
    SIGNAL result : t_result(0 TO N - 1);
    SIGNAL data_ready : STD_LOGIC;

    -- Add your code here ...

BEGIN

    -- Unit Under Test port map
    UUT : computegaussian
    GENERIC MAP(
        N => N
    )

    PORT MAP(
        clk => clk,
        coefficients_in => coefficients_in,
        products_in => products_in,
        result => result,
        data_in_changed => data_in_changed,
        data_ready => data_ready
    );

    -- Add your stimulus here ...

    PROCESS
    BEGIN
        clk <= '1';
        WAIT FOR 10ns;
        clk <= '0';
        WAIT FOR 10ns;
    END PROCESS;

    PROCESS BEGIN

        data_in_changed <= '1';
        WAIT FOR 50ns;
        coefficients_in(0, 0) <= "0" & "001111" & "000000000"; -- 2
        coefficients_in(0, 1) <= "0" & "001111" & "000000000";
        coefficients_in(1, 0) <= "0" & "001111" & "000000000";
        coefficients_in(1, 1) <= "0" & "001111" & "000000000";

        products_in(0) <= "0" & "010000" & "000000000";
        products_in(1) <= "0" & "010000" & "000000001";

        data_in_changed <= '0';

        WAIT;
    END PROCESS;
END TB_ARCHITECTURE;

CONFIGURATION TESTBENCH_FOR_computegaussian OF computegaussian_tb IS
    FOR TB_ARCHITECTURE
        FOR UUT : computegaussian
            USE ENTITY work.computegaussian(rtl);
        END FOR;
    END FOR;
END TESTBENCH_FOR_computegaussian;