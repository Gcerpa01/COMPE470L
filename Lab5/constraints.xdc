# Clock signal
set_property PACKAGE_PIN W5 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]
create_clock -add -name sys_clk_pin -period 10.00 [get_ports CLK]




#USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports uart_rx]                        
    set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]
set_property PACKAGE_PIN A18 [get_ports putty]                        
    set_property IOSTANDARD LVCMOS33 [get_ports putty]
    
set_property PACKAGE_PIN U18 [get_ports RST]
set_property IOSTANDARD LVCMOS33 [get_ports RST]
