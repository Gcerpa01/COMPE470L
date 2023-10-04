module uart_top( input CLK, RST, 
            input uart_rx,    
            output reg uart_tx);

    reg data_vld;      
    reg par_err;       
    reg [7:0] rx_data; 
    wire data_rdy;     

    // Instantiate the receiver module
    rx_uart #(.WL(8),        
        .BAUD_RATE(9600),
        .CLK_FREQ(100000000)) 
    receiver (.CLK(CLK),
            .RST(RST),
            .uart_rx(uart_rx),
            .data_vld(data_vld),
            .par_err(par_err),
            .dout(rx_data));

    // Instantiate the transmitter module
    tx_uart #(.WL(8),        
        .BAUD_RATE(9600), 
        .CLK_FREQ(100000000)) 
    transmitter (.CLK(CLK),
            .RST(RST),
            .data_vld(data_vld),
            .tx_word(rx_data), 
            .data_rdy(data_rdy),
            .uart_tx(uart_tx));

    always @(posedge CLK) begin
        if (data_vld && !par_err) begin
            uart_tx <= rx_data;
        end
    end

endmodule
