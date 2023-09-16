`timescale 1ns / 1ns

module tx_uart_tb;
    parameter WL = 8;
    parameter BAUD_RATE = 9600;
    parameter CLK_FREQ = 100000000;
    reg CLK,RST,data_vld;
    reg [WL - 1:0] tx_word;
    // parameter CLK_PER_BIT = $ceil((CLK_FREQ/BAUD_RATE));
    parameter  clock_max = $ceil((CLK_FREQ/BAUD_RATE));

    wire data_rdy,uart_tx;
    
    
    parameter ClkPeriod = 10;
    initial CLK =  1;
    always #(ClkPeriod / 2) CLK = ~CLK;
    
    tx_uart #(.WL(WL))
    DUT (.CLK(CLK),
         .RST(RST),
         .data_vld(data_vld),
         .tx_word(tx_word),
         .data_rdy(data_rdy),
         .uart_tx(uart_tx));


    initial begin
        RST = 1;  tx_word = 0; data_vld = 1'b0;
        @(posedge CLK) RST = 0;

        @(posedge CLK) data_vld = 1'b1; tx_word = 8'h43; // C
        @(negedge data_rdy) data_vld = 1'b0;
        
        @(posedge data_rdy) data_vld = 1'b1; tx_word = 8'h45; //E
        @(negedge data_rdy) data_vld = 1'b0;

        @(posedge data_rdy) data_vld = 1'b1; tx_word = 8'h52; //R
        @(negedge data_rdy) data_vld = 1'b0;


         @(posedge data_rdy) data_vld = 1'b1; tx_word = 8'h50; //P
         @(negedge data_rdy) data_vld = 1'b0;


         @(posedge data_rdy) data_vld = 1'b1; tx_word = 8'h41; //A
         @(negedge data_rdy) data_vld = 1'b0;


        @(posedge CLK);
        
        $finish;
    end


endmodule

