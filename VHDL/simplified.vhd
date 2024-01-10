											   LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
	

ENTITY computeGaussian IS
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
        data_ready : INOUT STD_LOGIC
    );
END ENTITY computeGaussian;

ARCHITECTURE rtl OF computeGaussian IS
	COMPONENT divider IS
    	PORT (					  
    	    a : IN INTEGER;
	        b : IN INTEGER;

			c : OUT INTEGER
    	);
	END COMPONENT divider;
BEGIN
    
	calculate: PROCESS (start_calculate)

        VARIABLE common_a1, common_a2, common_b1, common_b2, common_p1, common_p2 : INTEGER;
        VARIABLE ans1_var, ans2_var : INTEGER;
		VARIable step : integer;
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

			if (common_b2 < 0 and common_p2 > 0) or (common_p2 < 0 and common_b2 > 0) then 
				step := -1;
			else 
				step := 1;
			end if;
			
			FOR count in 0 to 7 LOOP 
				if 	common_b2 * ans2_var /= common_p2 then
					ans2_var := ans2_var + step;
				END IF;
			END LOOP;
			
			
			common_p1 := common_p1 - (common_b1 * ans2_var);
            ans1_var := 0;
			
			if (common_a1 < 0 and common_p1 > 0) or (common_p1 < 0 and common_a1 > 0) then 
				step := -1;
			else 
				step := 1;
			end if;
			
			FOR count in 0 to 7 LOOP 
				if 	common_a1 * ans1_var /= common_p1 then 
					ans1_var := ans1_var + step;
				END IF;
			END LOOP;

            ans1 <= ans1_var;
            ans2 <= ans2_var;
			
			data_ready <= '1';
		ELSE
			data_ready <= '0';
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;