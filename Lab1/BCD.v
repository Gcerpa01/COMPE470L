module BCD #(parameter WL = 4)(
    input CLK, ENABLE, UP, CLR, LOAD,
    input [WL - 1:0] D_IN,
    output reg CO,
    output reg [WL - 1:0] Q
);

    reg [WL - 1:0] counter;
    
    always @(posedge CLK or negedge CLR) begin
        if (!CLR) begin
            CO <= 1'b0;
            counter <= 0;
            Q <= 0;
        end
        else begin
            if (LOAD && ENABLE) begin
                counter <= D_IN;
                Q <= D_IN;
            end

            if (!LOAD && ENABLE && UP) begin
                if (counter == 9) begin
                    CO <= 1'b1;
                    counter <= 0;
                    Q <= 0;
                end
                else begin
                    CO <= 1'b0;
                    counter <= counter + 1;
                    Q <= counter + 1;
                end
            end

            if (!LOAD && ENABLE && !UP) begin
                if (counter == 0) begin
                    CO <= 1'b1;
                    counter <= 0;
                    Q <= 0;
                end
                else begin
                    CO <= 1'b0;
                    counter <= counter - 1;
                    Q <= counter - 1;
                end
            end
        end
    end
endmodule