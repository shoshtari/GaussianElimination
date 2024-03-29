LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE ieee.float_pkg.ALL;
USE work.arrays.ALL;

ENTITY computeGaussian IS
    GENERIC (
        N : INTEGER := 2
    );
    PORT (
        clk : IN STD_LOGIC;
        coefficients_in : IN t_coefficients(0 TO N - 1, 0 TO N - 1);
        products_in : IN t_products(0 TO N - 1);
        result : OUT t_result(0 TO N - 1);
        data_in_changed : IN STD_LOGIC; -- when user changes coe and products set this to 1
        data_ready : OUT STD_LOGIC := '0' -- returns 1 when calculation is done
    );
END ENTITY computeGaussian;

ARCHITECTURE rtl OF computeGaussian IS
    SIGNAL this_row : INTEGER := 0;
    SIGNAL order : t_array(0 TO N - 1);
BEGIN
    PROCESS (clk)
        VARIABLE index : INTEGER RANGE 0 TO N - 1 := 0;
        VARIABLE ceo : float(6 DOWNTO -9);
        VARIABLE coefficients : t_coefficients(0 TO N - 1, 0 TO N - 1);
        VARIABLE products : t_products(0 TO N - 1);
    BEGIN
        IF rising_edge(clk) THEN
            IF data_in_changed = '0' THEN
                IF this_row = N THEN
                    -- after n clock cycle this_row would become N and we should calculate 
                    -- result array based on products buffer
                    FOR i IN 0 TO N - 1 LOOP -- maybe we should use #for generate
                        result(i) <= products(order(i));
                    END LOOP;
                    data_ready <= '1';
                    this_row <= - 1;
                ELSIF this_row /= - 1 THEN
                    data_ready <= '0';
                    index := 0;
                    FOR i IN N - 1 DOWNTO 0 LOOP
                        IF coefficients(this_row, index) /= 0 THEN
                            index := i;
                        END IF;
                    END LOOP;

                    order(index) <= this_row;

                    -- divide
                    products(this_row) := products(this_row) / coefficients(this_row, index);
                    ceo := coefficients(this_row, index);
                    FOR i IN 0 TO N - 1 LOOP
                        coefficients(this_row, i) := coefficients(this_row, i) / ceo;
                    END LOOP;

                    -- setting coe of index for other equations to 0
                    FOR row IN 0 TO N - 1 LOOP
                        IF row /= this_row THEN
                            ceo := coefficients(row, index);
                            FOR column IN 0 TO N - 1 LOOP
                                coefficients(row, column) := coefficients(row, column) - ceo * coefficients(this_row, column);
                            END LOOP;
                        END IF;
                    END LOOP;

                    this_row <= this_row + 1;
                END IF;

            ELSIF data_in_changed = '1' THEN
                -- when input data changed 
                coefficients := coefficients_in;
                products := products_in;
                this_row <= 0;
                order <= (OTHERS => 0);
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;