module clock_counter(input CLK,
            input btn1,
            input btn2,
            output reg [5:0] sec_led, //track seconds
            output reg [26:0] counter, 
            output reg [3:0] H_1, //12:35 - will be the first hour digit(1)
            output reg [3:0] H_0, //12:35 - will be the second hour digit(2)
            output reg [3:0] M_0, //12:35 - will be the first min digit(3)
            output reg [3:0] M_1); //12:35 - will be the second min digit(5)

    always @(posedge CLK) begin
        counter <= counter + 1;
        if(counter == 100_000_000) begin //check clock frequency for counting
            counter <= 0;
            if(sec_led == 60) begin //minute has passed
                sec_led <= 0;

                if(M_0 == 9) begin //check if second minute digit has hit cap
                    M_0 <= 0;
                    if(M_1 == 5) begin //check if there is a change in hour
                        M_1 <= 0;
                        if(H_0 < 9 && !(H1 > 1 && H_0 > 2)) H_0 <= H_0 + 1; // change second hour digit 
                        else begin //set second hour digit to 0 and change first hour digit
                            H_0 <= 0;
                            if(H_1 == 2) H_1 <= 0;
                            else H_1 <= H1 + 1;
                        end
                    end
                    else M_1 <= M_1 + 1; //add to minutes
                end
                else M_0 <= M_0 + 1; //add to minutes
            end

            else begin 
                sec_led <= sec_led + 1; //count second

                if(btn1 && (H_0 < 9 && !(H_1 > 1 && H_0 > 2))) H_0 <= H_0 + 1; //
                else if(btn1 && H_0 == 9 && H_1 < 2) begin
                    H_0 <= 0;
                    H_1 <= H_1 + 1;
                end
                else if(btn1 && H_1 == 2 && H_0 == 3) begin //24 hour clock
                    H_0 <= 0;
                    H_1 <= 0;
                end

                if(btn2 && (M_0 < 9 && !(M_1 > 5 && M_0 > 9))) M_0 <= M_0 + 1;
                else if(btn2 && M_0 == 9 && M_1 < 5) begin
                    M_0 <= 0;
                    M_1 <= H_1 + 1;
                end
                else if(btn2 && M_1 == 5 && H_0 == 9) begin //60 minutes
                    M_0 <= 0;
                    M_1 <= 0;
                end
            end 

        end 
    end

endmodule
