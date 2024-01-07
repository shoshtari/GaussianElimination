LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.float_pkg.ALL;

PACKAGE arrays IS
  TYPE t_coefficients IS ARRAY (NATURAL RANGE <>, NATURAL RANGE <>) OF float(6 DOWNTO -9);
  TYPE t_products IS ARRAY (NATURAL RANGE <>) OF float(6 DOWNTO -9);
  TYPE t_result IS ARRAY (NATURAL RANGE <>) OF float(6 DOWNTO -9);
  TYPE t_array IS ARRAY (NATURAL RANGE <>) OF INTEGER;
END PACKAGE;