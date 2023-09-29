module tx_uart#(parameter WL = 8,BAUD_RATE = 9600,
             CLK_FREQ = 100000000)(input CLK,RST,
             input data_vld,
             input [WL-1:0] tx_word,
             output reg data_rdy,
             output reg uart_tx);


   localparam idle = 3'b000; localparam start= 3'b001;
   localparam tx = 3'b010; localparam parity = 3'b011;
   localparam stop = 3'b100;

   localparam clock_max = $ceil((CLK_FREQ/BAUD_RATE));
   localparam bits = $clog2((CLK_FREQ/BAUD_RATE));

   reg [$clog2(bits) - 1:0] bit_counter;
   reg [($clog2(clock_max)) - 1:0] clock_counter;
   reg [WL-1:0] sample;
   reg parity_bit;
   reg [2:0] state;


   always @(posedge CLK or RST) begin
       if(RST) begin
           state <= idle;
           data_rdy <= 1'b1;
           uart_tx <= 1'b1;
           clock_counter <= 0;
           bit_counter <= 0;
           sample <= 0;
       end
       else begin
            case(state)
                idle:begin                  
                    if (clock_counter == clock_max) begin
                        if(data_vld) begin
                            sample <= tx_word;
                            state <= start;
                            data_rdy <= 1'b0;
                        end
                    end
                    else clock_counter <= clock_counter + 1;
                end
                start: begin
                    uart_tx <= 1'b0;
                    if(clock_counter == clock_max) begin
                        clock_counter <= 0;
                        state <= tx;
                        parity_bit <= ^(sample);
                    end
                    else clock_counter <= clock_counter + 1;
                end

                tx: begin
                    if(clock_counter == clock_max) begin
                        clock_counter <= 0;
                        uart_tx <= sample[0];
                        sample <= {1'b0,sample[WL-1:1]};
                        if(bit_counter == WL) begin
                            bit_counter <= 0;
                            state <= parity;
                        end
                        else bit_counter <= bit_counter + 1;
                    end
                    else clock_counter <= clock_counter + 1;
                end

                parity: begin
                    uart_tx <= parity_bit;
                    if(clock_counter == clock_max) begin
                        clock_counter <= 0;
                        state <= stop;
                    end
                    else clock_counter <= clock_counter + 1;
                end

                stop: begin
                    uart_tx <= 1'b1;
                    if(clock_counter == clock_max) begin
                        clock_counter <= 0;
                        state <= idle;
                        data_rdy <= 1'b1;
                    end
                    else clock_counter <= clock_counter + 1;  
                end

            endcase
       end

   end
endmodule

