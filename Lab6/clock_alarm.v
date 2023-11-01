module clock_alarm( input [3:0] sw,
            input [3:0] H_1,
            input [3:0] H_0,
            input [3:0] M_1,
            input [3:0] M_0,
            output reg [5:0] alarm_led);

    reg[3:0] a_h0, a_h1;
    reg[3:0] a_m0, a_m1;

    always @(H_1 or H_0 or M_1 or M_0) begin
        if(sw == 0) alarm_led <= 6'b000000; //no alarm
        else if(sw == 1) begin //set alarm
            a_h0 <= H_0;
            a_h1 <= H_1;
            a_m0 <= M_0;
            a_m1 <= M_1;
            alarm_led <= 6'b111111;
        end
        
        else if(sw != 1) begin //alarm was left on
            if(a_h0 == H_0 && a_h1 == H_1 && a_m0 == M_0 && a_m1 == M_1) begin
                //blink led for 5 seconds(make module using seconds and output to alarm_led)
            end
        end
    end

endmodule
