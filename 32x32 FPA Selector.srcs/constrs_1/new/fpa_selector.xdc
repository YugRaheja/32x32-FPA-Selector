# ==============================================================================
# 1. Clock Definition & Constraints
# ==============================================================================
create_clock -period 10.000 -name sys_clk [get_ports clk]

# BYPASS DRC ERROR: Allows Vivado to route the clock from regular IO pin A4
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]

# ==============================================================================
# 2. Device Configuration Voltage Properties
# ==============================================================================
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# ==============================================================================
# 3. Global I/O Standard and Slew Settings
# ==============================================================================
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports {col_sel[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row_sel[*]}]

set_property SLEW SLOW [get_ports {col_sel[*]}]

# ==============================================================================
# 4. System Pin Placements (Clock & Reset)
# ==============================================================================
set_property PACKAGE_PIN A4 [get_ports clk]
set_property PACKAGE_PIN A5 [get_ports rst]

# ==============================================================================
# 5. Column Select (col_sel) Pin Placements
# ==============================================================================
set_property PACKAGE_PIN A1  [get_ports {col_sel[31]}]
set_property PACKAGE_PIN A3  [get_ports {col_sel[30]}]
set_property PACKAGE_PIN A6  [get_ports {col_sel[29]}]
set_property PACKAGE_PIN A8  [get_ports {col_sel[28]}]
set_property PACKAGE_PIN A9  [get_ports {col_sel[27]}]
set_property PACKAGE_PIN A10 [get_ports {col_sel[26]}]
set_property PACKAGE_PIN A11 [get_ports {col_sel[25]}]
set_property PACKAGE_PIN A13 [get_ports {col_sel[24]}]
set_property PACKAGE_PIN A14 [get_ports {col_sel[23]}]
set_property PACKAGE_PIN A15 [get_ports {col_sel[22]}]
set_property PACKAGE_PIN A16 [get_ports {col_sel[21]}]
set_property PACKAGE_PIN A18 [get_ports {col_sel[20]}]
set_property PACKAGE_PIN B1  [get_ports {col_sel[19]}]
set_property PACKAGE_PIN B2  [get_ports {col_sel[18]}]
set_property PACKAGE_PIN B3  [get_ports {col_sel[17]}]
set_property PACKAGE_PIN B4  [get_ports {col_sel[16]}]
set_property PACKAGE_PIN B6  [get_ports {col_sel[15]}]
set_property PACKAGE_PIN B7  [get_ports {col_sel[14]}]
set_property PACKAGE_PIN B8  [get_ports {col_sel[13]}]
set_property PACKAGE_PIN B9  [get_ports {col_sel[12]}]
set_property PACKAGE_PIN B11 [get_ports {col_sel[11]}]
set_property PACKAGE_PIN B12 [get_ports {col_sel[10]}]
set_property PACKAGE_PIN B13 [get_ports {col_sel[9]}]
set_property PACKAGE_PIN B14 [get_ports {col_sel[8]}]
set_property PACKAGE_PIN B16 [get_ports {col_sel[7]}]
set_property PACKAGE_PIN B17 [get_ports {col_sel[6]}]
set_property PACKAGE_PIN B18 [get_ports {col_sel[5]}]
set_property PACKAGE_PIN C1  [get_ports {col_sel[4]}]
set_property PACKAGE_PIN C2  [get_ports {col_sel[3]}]
set_property PACKAGE_PIN C4  [get_ports {col_sel[2]}]
set_property PACKAGE_PIN C5  [get_ports {col_sel[1]}]
set_property PACKAGE_PIN C6  [get_ports {col_sel[0]}]

# ==============================================================================
# 6. Row Select (row_sel) Pin Placements
# ==============================================================================
set_property PACKAGE_PIN F1  [get_ports {row_sel[31]}]
set_property PACKAGE_PIN F3  [get_ports {row_sel[30]}]
set_property PACKAGE_PIN F4  [get_ports {row_sel[29]}]
set_property PACKAGE_PIN F5  [get_ports {row_sel[28]}]
set_property PACKAGE_PIN F6  [get_ports {row_sel[27]}]
set_property PACKAGE_PIN F13 [get_ports {row_sel[26]}]
set_property PACKAGE_PIN F14 [get_ports {row_sel[25]}]
set_property PACKAGE_PIN F15 [get_ports {row_sel[24]}]
set_property PACKAGE_PIN F16 [get_ports {row_sel[23]}]
set_property PACKAGE_PIN F18 [get_ports {row_sel[22]}]
set_property PACKAGE_PIN G1  [get_ports {row_sel[21]}]
set_property PACKAGE_PIN G2  [get_ports {row_sel[20]}]
set_property PACKAGE_PIN G3  [get_ports {row_sel[19]}]
set_property PACKAGE_PIN G4  [get_ports {row_sel[18]}]
set_property PACKAGE_PIN G6  [get_ports {row_sel[17]}]
set_property PACKAGE_PIN G13 [get_ports {row_sel[16]}]
set_property PACKAGE_PIN G14 [get_ports {row_sel[15]}]
set_property PACKAGE_PIN G16 [get_ports {row_sel[14]}]
set_property PACKAGE_PIN G17 [get_ports {row_sel[13]}]
set_property PACKAGE_PIN G18 [get_ports {row_sel[12]}]
set_property PACKAGE_PIN H1  [get_ports {row_sel[11]}]
set_property PACKAGE_PIN H2  [get_ports {row_sel[10]}]
set_property PACKAGE_PIN H4  [get_ports {row_sel[9]}]
set_property PACKAGE_PIN H5  [get_ports {row_sel[8]}]
set_property PACKAGE_PIN H6  [get_ports {row_sel[7]}]
set_property PACKAGE_PIN H14 [get_ports {row_sel[6]}]
set_property PACKAGE_PIN H15 [get_ports {row_sel[5]}]
set_property PACKAGE_PIN H16 [get_ports {row_sel[4]}]
set_property PACKAGE_PIN H17 [get_ports {row_sel[3]}]
set_property PACKAGE_PIN J2  [get_ports {row_sel[2]}]
set_property PACKAGE_PIN J3  [get_ports {row_sel[1]}]
set_property PACKAGE_PIN J4  [get_ports {row_sel[0]}]