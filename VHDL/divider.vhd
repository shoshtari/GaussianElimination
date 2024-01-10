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
    
	calculate: PROCESS (a, b)
		VARIABLE ans_var : integer;
		VARIable step : integer;
    BEGIN										


			if (b < 0 and a > 0) or (a < 0 and b > 0) then 
				step := -1;
			else 
				step := 1;
			end if;
			
			ans_var := 0;
			FOR count in 0 to 7 LOOP 
				if 	a * ans_var /= b then
					ans_var := ans_var + step;
				END IF;
			END LOOP;
			
			c <= ans_var;

    END PROCESS;

END ARCHITECTURE rtl;