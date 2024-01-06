LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.arrays.ALL;

ENTITY computeGaussian IS
    GENERIC (
        N : INTEGER := 10
    );
    PORT (
        clk : IN STD_LOGIC;
        coefficients : INOUT t_coefficients(0 TO N - 1, 0 TO N - 1);
        products : INOUT t_products(0 TO N - 1);
        result : OUT t_result(0 TO N - 1);
        data_in_changed : INOUT STD_LOGIC;
        data_ready : OUT STD_LOGIC
    );
END ENTITY computeGaussian;

ARCHITECTURE rtl OF computeGaussian IS
    SIGNAL this_row : INTEGER := 0;
    SIGNAL order : t_array(0 TO N - 1);
BEGIN
    PROCESS (clk)
        VARIABLE index : INTEGER := 0;
        VARIABLE ceo : INTEGER := 0;
    BEGIN
        IF rising_edge(clk) THEN
            IF data_in_changed = '0' THEN
                IF this_row = N THEN
                    FOR i IN 0 TO N - 1 LOOP -- maybe we should use #for generate
                        result(i) <= products(order(i));
                    END LOOP;
                    data_ready <= '1';
                    this_row <= - 1;
                ELSIF this_row /= - 1 THEN
                    data_ready <= '1';
                    index := 0;
                    WHILE coefficients(this_row, index) = 0 LOOP
                        index := index + 1;
                    END LOOP;

                    order(index) <= this_row;

                    -- divide
                    -- products[this_row] /= coefficients[this_row][index]
                    -- coefficients[this_row] = [x / coefficients[this_row][index]
                    --                           for x in coefficients[this_row]]
                    -- end divide

                    FOR row IN 0 TO N - 1 LOOP
                        IF row /= this_row THEN
                            ceo := coefficients(row, index);
                            FOR column IN 0 TO N - 1 LOOP
                                coefficients(row, column) <= coefficients(row, column) - ceo * coefficients(this_row, column);
                            END LOOP;
                        END IF;
                    END LOOP;

                    this_row <= this_row + 1;
                END IF;
            ELSIF data_in_changed = '1' THEN
                this_row <= 0;
                order <= (OTHERS => 0);
                data_in_changed <= '0';
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;