LIBRARY ieee;
USE ieee.NUMERIC_STD.ALL;
USE ieee.std_logic_1164.ALL;

-- Add your library and packages declaration here ...

ENTITY computegaussian_tb IS
END computegaussian_tb;

ARCHITECTURE TB_ARCHITECTURE OF computegaussian_tb IS
	-- Component declaration of the tested unit
	COMPONENT computegaussian
		PORT (
			a1 : IN INTEGER;
			b1 : IN INTEGER;
			a2 : IN INTEGER;
			b2 : IN INTEGER;
			p1 : IN INTEGER;
			p2 : IN INTEGER;
			ans1 : OUT INTEGER;
			ans2 : OUT INTEGER;
			start_calculate : IN STD_LOGIC;
			data_ready : INOUT STD_LOGIC);
	END COMPONENT;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	SIGNAL a1 : INTEGER;
	SIGNAL b1 : INTEGER;
	SIGNAL a2 : INTEGER;
	SIGNAL b2 : INTEGER;
	SIGNAL p1 : INTEGER;
	SIGNAL p2 : INTEGER;
	SIGNAL start_calculate : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	SIGNAL ans1 : INTEGER;
	SIGNAL ans2 : INTEGER;
	SIGNAL data_ready : STD_LOGIC;

	-- Add your code here ...

BEGIN

	-- Unit Under Test port map
	UUT : computegaussian
	PORT MAP(
		a1 => a1,
		b1 => b1,
		a2 => a2,
		b2 => b2,
		p1 => p1,
		p2 => p2,
		ans1 => ans1,
		ans2 => ans2,
		start_calculate => start_calculate,
		data_ready => data_ready
	);

	-- Add your stimulus here ...
	PROCESS BEGIN
		start_calculate <= '0';
		WAIT FOR 100ns;

		a1 <= 2;
		b1 <= 3;
		p1 <= 8;

		a2 <= 3;
		b2 <= 2;
		p2 <= 7;

		start_calculate <= '1';

		WAIT UNTIL data_ready = '1';
		start_calculate <= '0';
		WAIT FOR 100ns;

		a1 <= - 1;
		b1 <= 3;
		p1 <= 7;

		a2 <= 2;
		b2 <= 2;
		p2 <= 10;

		start_calculate <= '1';

		WAIT UNTIL data_ready = '1';
		start_calculate <= '0';

		WAIT FOR 100 ns;

		a1 <= 2;
		b1 <= 3;
		p1 <= 20;

		a2 <= 1;
		b2 <= 1;
		p2 <= 8;

		start_calculate <= '1';

		WAIT UNTIL data_ready = '1';
		start_calculate <= '0';

		WAIT FOR 100 ns;

		a1 <= 3;
		b1 <= 2;
		p1 <= - 2;

		a2 <= 1;
		b2 <= 1;
		p2 <= 1;

		start_calculate <= '1';

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