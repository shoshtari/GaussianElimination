LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE ieee.float_pkg.ALL;
USE work.arrays.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY compute_tb IS
END compute_tb;

ARCHITECTURE test OF compute_tb IS
    CONSTANT N : INTEGER := 2;
    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT computeGaussian
        GENERIC (
            N : INTEGER
        );
        PORT (
            clk : IN STD_LOGIC;
            coefficients : INOUT t_coefficients(0 TO N - 1, 0 TO N - 1);
            products : INOUT t_products(0 TO N - 1);
            result : OUT t_result(0 TO N - 1);
            data_in_changed : INOUT STD_LOGIC; -- when user changes coe and products set this to 1
            data_ready : OUT STD_LOGIC -- returns 1 when calculation is done
        );
    END COMPONENT;

    --Inputs
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL coefficients : t_coefficients(0 TO N - 1, 0 TO N - 1);
    SIGNAL products : t_products(0 TO N - 1);
    SIGNAL result : t_result(0 TO N - 1);
    SIGNAL data_in_changed : STD_LOGIC;
    SIGNAL data_ready : STD_LOGIC;
    SIGNAL RUN : STD_LOGIC := '0';

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut : computeGaussian
    GENERIC MAP(
        N => N)
    PORT MAP(
        clk => clk,
        coefficients => coefficients,
        products => products,
        result => result,
        data_in_changed => data_in_changed,
        data_ready => data_ready
    );

	PROCESS
	BEGIN
		clk <= '1';
		WAIT FOR 10ns;
		clk <= '0';
		WAIT FOR 10ns;
	END PROCESS;
	
	PROCESS BEGIN

		data_in_changed <= '0';
		WAIT FOR 50ns;
		coefficients(0, 0) <= "0" & "001111" & "000000000"; -- 2
		coefficients(0, 1) <= "0" & "001111" & "000000000";
		coefficients(1, 0) <= "0" & "001111" & "000000000";
		coefficients(1, 1) <= "0" & "001111" & "000000000";

		products(0) <= "0" & "010000" & "000000000";
		products(1) <= "0" & "010000" & "000000001";

		data_in_changed <= '1';

		WAIT;
	END PROCESS;

END ARCHITECTURE test;