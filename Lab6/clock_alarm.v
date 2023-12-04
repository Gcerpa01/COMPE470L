module clock_alarm( input [3:0] sw,
            input [3:0] H_1,
            input [3:0] H_0,
            input [3:0] M_1,
            input [3:0] M_0,
            input [3:0] sec_led,
            output reg [5:0] alarm_led);

    reg[3:0] a_h0, a_h1;
    reg[3:0] a_m0, a_m1;

    reg alarm_trigerred;
    reg[2:0] blink_counter = 0;


    always @(H_1 or H_0 or M_1 or M_0) begin
        if(sw == 0) begin
            alarm_led <= 6'b000000; //no alarm
            alarm_trigerred <= 1'b0;
        end
        else if(sw == 1) begin //set alarm
            a_h0 <= H_0;
            a_h1 <= H_1;
            a_m0 <= M_0;
            a_m1 <= M_1;
            alarm_led <= 6'b111111;
            alarm_trigerred <= 1'b0;
        end
        
        else if(sw != 1) begin //alarm was left on
            if(a_h0 == H_0 && a_h1 == H_1 && a_m0 == M_0 && a_m1 == M_1) alarm_trigerred <= 1'b1;
        end
    end

    always @(sec_led) begin
        if(alarm_trigerred) begin
            if(blink_counter == 5) begin
                blink_counter <= 0;
                alarm_trigerred <= 1'b0; //alarm gets untriggered
            end
            else begin 
                blink_counter <= blink_counter + 1;
                alarm_led <= ~alarm_led;
            end
        end
    end

endmodule
