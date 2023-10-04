module rx_test_tb;

parameter WL = 8;
parameter BAUD_RATE = 9600;
parameter CLK_FREQ = 100000000;
reg CLK, RST, uart_rx;

wire [7:0] uart_word;
wire data_vld, par_err;

wire [2:0] state;
rx_uart r001 (
    .uart_rx (uart_rx),
    .data_vld (data_vld),
    .CLK (CLK),
    .RST (RST),
    .dout (uart_word),
    .par_err (par_err)
);

assign state = r001.state;
parameter ClkPeriod = 10;
initial CLK = 1;
always #(ClkPeriod / 2) CLK = ~CLK;

// Test sequence for sending "C" (ASCII 12)
initial begin
    RST = 1; uart_rx = 1'b1;
    
    @(posedge CLK) RST = 0;
    @(posedge CLK) uart_rx = 1'b0;
    @(posedge data_vld) uart_rx = 1'b1;
    
    @(posedge CLK) uart_rx = 1'b0;
    @(posedge CLK) uart_rx = 1'b1;
    @(posedge data_vld) uart_rx = 1'b1;
    
    @(posedge CLK);
    
    $finish;
    end
    
endmodule
