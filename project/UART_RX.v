module UART_RX #(parameter WL = 8)
            (input CLK,RST,
             input din,
             output [WL - 1:0] dout);

    reg shift;
    reg state,next_state;
    reg [3:0] bit_counter; //total number of bis is 10, 1 byte of data
    reg [1:0] sample_counter; //freq = 4 * BR
    reg [13:0] baudrate_counter; //9600
    reg [WL+1:0] rxshift_reg; //data

    reg clear_bitcounter,inc_bitcounter,inc_samplecounter,clear_samplecounter; //clear and inc bit counter

    parameter CLK_FREQ = 100_000_000;
    parameter baud_rate = 9600;
    parameter div_sample = 4;
    parameter div_counter = CLK_FREQ / (baud_rate * div_sample); //sample higher than baud_rate
    parameter mid_sample = div_sample / 2;  // sample at midpoint
    parameter div_bit = WL + 2; //start,stop, bits of data


    assign dout  = rxshift_reg [WL:1];
    
    always @ (posedge CLK) begin
        if(RST) begin
            state <= 0;
            bit_counter <= 0;
            baudrate_counter <= 0;
            sample_counter <= 0;
        end
        else begin
            baudrate_counter <= baudrate_counter + 1;
            if(baudrate_counter >= div_counter - 1) begin //BR with sampling reached
                baudrate_counter <= 0;
                state <= next_state; //receive
                if(shift)rxshift_reg <= {din,rxshift_reg[WL+1:1]};
                if(clear_samplecounter) sample_counter <= 0;
                if(inc_samplecounter) sample_counter <= bit_counter + 1;
                if(clear_bitcounter) bit_counter <= 0;
                if(inc_bitcounter) bit_counter <= bit_counter + 1;

            end
        end
    end
    
    always @ (posedge CLK) begin
        shift <= 0;
        clear_samplecounter <= 0;
        inc_samplecounter <= 0;
        clear_bitcounter <= 0;
        inc_bitcounter <= 0;
        next_state <= 0;

        case(state) 
            0: begin //IDLE
                if(din) next_state <= 0; //low start bit
                else begin
                    next_state <= 1;
                    clear_bitcounter <= 1;
                    clear_samplecounter <= 1;
                end
            end

            1: begin //RX
                next_state <= 1;
                if(sample_counter == mid_sample - 1) shift <= 1; //shift
                    if(sample_counter == div_sample - 1) begin //collect samples
                        if(bit_counter == div_bit - 1) next_state <= 0; //verify entire bits
                        inc_bitcounter <= 1;
                        clear_samplecounter <= 1; //sample again
                    end 
                    else inc_samplecounter <= 1; //proper sampling
            end
            default: next_state <= 0;
        endcase

    end

endmodule
