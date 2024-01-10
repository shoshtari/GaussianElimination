LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY divider IS
	PORT (
		a : IN INTEGER;
		b : IN INTEGER;

		c : OUT INTEGER
	);
END ENTITY divider;

ARCHITECTURE rtl OF divider IS
BEGIN

	calculate : PROCESS (a, b)
		VARIABLE ans_var : INTEGER;
		VARIABLE step : INTEGER;
	BEGIN
		IF (b < 0 AND a > 0) OR (a < 0 AND b > 0) THEN
			step := - 1;
		ELSE
			step := 1;
		END IF;

		ans_var := 0;
		FOR count IN 0 TO 7 LOOP
			IF a * ans_var /= b THEN
				ans_var := ans_var + step;
			END IF;
		END LOOP;

		c <= ans_var;

	END PROCESS;

END ARCHITECTURE rtl;