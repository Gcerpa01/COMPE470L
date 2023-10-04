module rx_uart#(parameter WL = 8,BAUD_RATE = 9600,
             CLK_FREQ = 100000000)(input CLK,RST,
             input uart_rx,
             output reg data_vld,
             output reg par_err,
             output reg [WL-1:0] dout);
            
   localparam idle = 3'b000; localparam start= 3'b001;
   localparam rx = 3'b010; localparam parity = 3'b011;
   localparam stop = 3'b100;


   localparam clock_max = $ceil((CLK_FREQ/BAUD_RATE))/2;
   localparam bits = $clog2((CLK_FREQ/BAUD_RATE));


   reg [$clog2(bits) - 1:0] bit_counter;
   reg [($clog2(clock_max)) - 1:0] clock_counter;
   reg [2:0] state;
   reg [WL-1:0] sample;
   reg check_parity;
   reg rx_parity;

   always @(posedge CLK or RST) begin
       if(RST) begin
           state <= idle;
           data_vld <= 1'b0;
           par_err <= 1'b0;
           dout <= 0;
           sample <= 0;
           bit_counter <= 0;
           clock_counter <= 0;
       end

       else begin

           case(state)
               idle: begin
                   par_err <= 1'b0;
                   data_vld <= 1'b0;
                   dout <= 0;
                   if(!uart_rx) begin
                        clock_counter <= clock_counter + 1;
                        state <= start;
                   end                 
               end


               start:begin
                   if(clock_counter == clock_max/2) begin
                       state <= rx;
                       clock_counter <= 0;
                   end
                   else clock_counter <= clock_counter + 1;
               end


               rx: begin
                   if(clock_counter == clock_max) begin
                       clock_counter <= 0;
                       sample <= {uart_rx,sample[WL-1:1]};
                       if(bit_counter == WL) begin
                           state <= parity;
                           bit_counter <= 0;
                       end
                       else bit_counter <= bit_counter + 1;
                   end
                   else clock_counter <= clock_counter + 1;
               end


               parity: begin
                   if(clock_counter == clock_max) begin
                       clock_counter <= 0;
                       rx_parity <= uart_rx;
                       check_parity <= ^sample;
                       state <= stop;
                   end
                   else clock_counter <= clock_counter + 1;
               end

                stop: begin

                if(clock_counter == clock_max) begin
                    clock_counter <= 0;
                    if(check_parity == rx_parity) begin
                        par_err <= 1'b0;
                        data_vld <= 1'b1;
                    end
                    else begin
                        par_err <= 1'b1;
                        data_vld <= 1'b0;
                    end
                    state <= idle;
                    dout <= sample;
                end
                else clock_counter <= clock_counter + 1;

                end
           endcase
       end

   end
endmodule