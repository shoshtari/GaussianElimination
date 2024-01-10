LIBRARY ieee;
USE ieee.NUMERIC_STD.ALL;
USE ieee.std_logic_1164.ALL;

-- Add your library and packages declaration here ...

ENTITY divider_tb IS
END divider_tb;

ARCHITECTURE TB_ARCHITECTURE OF divider_tb IS
	-- Component declaration of the tested unit
	COMPONENT divider
		PORT (
			a : IN INTEGER;
			b : IN INTEGER;
			c : OUT INTEGER);
	END COMPONENT;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	SIGNAL a : INTEGER;
	SIGNAL b : INTEGER;
	-- Observed signals - signals mapped to the output ports of tested entity
	SIGNAL c : INTEGER;

	-- Add your code here ...

BEGIN

	-- Unit Under Test port map
	UUT : divider
	PORT MAP(
		a => a,
		b => b,
		c => c
	);

	-- Add your stimulus here ...
	PROCESS BEGIN

		WAIT FOR 100ns;

		a <= 2;
		b <= 4;
		WAIT FOR 100ns;

		a <= 1;
		b <= 5;
		WAIT FOR 100ns;

		a <= 3;
		b <= 9;
		WAIT;
	END PROCESS;

END TB_ARCHITECTURE;

CONFIGURATION TESTBENCH_FOR_divider OF divider_tb IS
	FOR TB_ARCHITECTURE
		FOR UUT : divider
			USE ENTITY work.divider(rtl);
		END FOR;
	END FOR;
END TESTBENCH_FOR_divider;