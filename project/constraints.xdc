
## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property PACKAGE_PIN W5 [get_ports CLK_IN]							
	set_property IOSTANDARD LVCMOS33 [get_ports CLK_IN]
 
# Switches
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]

#7 segment display
set_property PACKAGE_PIN W7 [get_ports {BCD_out[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD_out[6]}]
set_property PACKAGE_PIN W6 [get_ports {BCD_out[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD_out[5]}]
set_property PACKAGE_PIN U8 [get_ports {BCD_out[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD_out[4]}]
set_property PACKAGE_PIN V8 [get_ports {BCD_out[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD_out[3]}]
set_property PACKAGE_PIN U5 [get_ports {BCD_out[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD_out[2]}]
set_property PACKAGE_PIN V5 [get_ports {BCD_out[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD_out[1]}]
set_property PACKAGE_PIN U7 [get_ports {BCD_out[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {BCD_out[0]}]

set_property PACKAGE_PIN V7 [get_ports dp]							
	set_property IOSTANDARD LVCMOS33 [get_ports dp]

set_property PACKAGE_PIN U2 [get_ports {anode[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[0]}]
set_property PACKAGE_PIN U4 [get_ports {anode[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[1]}]
set_property PACKAGE_PIN V4 [get_ports {anode[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[2]}]
set_property PACKAGE_PIN W4 [get_ports {anode[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {anode[3]}]


# Button constraints (adjust as needed)
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {btn1}]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {btn2}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {btn3}]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {btn4}]


set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {full}]
set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {empty}]
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports {error}]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {seconds}]
