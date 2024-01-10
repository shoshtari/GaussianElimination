library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity divider_tb is
end divider_tb;

architecture TB_ARCHITECTURE of divider_tb is
	-- Component declaration of the tested unit
	component divider
	port(
		a : in INTEGER;
		b : in INTEGER;
		c : out INTEGER );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a : INTEGER;
	signal b : INTEGER;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal c : INTEGER;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : divider
		port map (
			a => a,
			b => b,
			c => c
		);

	-- Add your stimulus here ...
	process begin
	
	wait for 100ns;
	
	a <= 2;
	b <= 4;
	wait for 100ns;
	
	a <= 1;
	b <= 5;
	wait for 100ns;
	
	a <= 3;
	b <= 9;
	wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_divider of divider_tb is
	for TB_ARCHITECTURE
		for UUT : divider
			use entity work.divider(rtl);
		end for;
	end for;
end TESTBENCH_FOR_divider;

