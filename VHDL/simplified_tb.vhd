library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity computegaussian_tb is
end computegaussian_tb;

architecture TB_ARCHITECTURE of computegaussian_tb is
	-- Component declaration of the tested unit
	component computegaussian
	port(					
		a1 : in INTEGER;
		b1 : in INTEGER;
		a2 : in INTEGER;
		b2 : in INTEGER;
		p1 : in INTEGER;
		p2 : in INTEGER;
		ans1 : out INTEGER;
		ans2 : out INTEGER;
		start_calculate : in STD_LOGIC;
		data_ready : inout STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a1 : INTEGER;
	signal b1 : INTEGER;
	signal a2 : INTEGER;
	signal b2 : INTEGER;
	signal p1 : INTEGER;
	signal p2 : INTEGER;
	signal start_calculate : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ans1 : INTEGER;
	signal ans2 : INTEGER;
	signal data_ready : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : computegaussian
		port map (		
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
		wait for 100ns;
	
		a1 <= 2;
		b1 <= 3;
		p1 <= 8;
	
		a2 <= 3;
		b2 <= 2;
		p2 <= 7;
	
		start_calculate <= '1';	
							   
		wait until data_ready = '1';
		start_calculate <= '0';
		wait for 100ns;
		
		a1 <= -1;
		b1 <= 3;
		p1 <= 7;
		
		a2 <= 2;
		b2 <= 2;
		p2 <= 10;
		
		start_calculate <= '1';
		
		wait until data_ready = '1';
		start_calculate <= '0';
		
		wait for 100 ns;
		
		a1 <= 2;
		b1 <= 3;
		p1 <= 20;
		
		a2 <= 1;
		b2 <= 1;
		p2 <= 8;
		
		start_calculate <= '1';
		
		wait until data_ready = '1';
		start_calculate <= '0';
		
		wait for 100 ns;
		
		a1 <= 3;
		b1 <= 2;
		p1 <= -2;
		
		a2 <= 1;
		b2 <= 1;
		p2 <= 1;
		
		start_calculate <= '1';
		
		wait;
	END PROCESS;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_computegaussian of computegaussian_tb is
	for TB_ARCHITECTURE
		for UUT : computegaussian
			use entity work.computegaussian(rtl);
		end for;
	end for;
end TESTBENCH_FOR_computegaussian;

