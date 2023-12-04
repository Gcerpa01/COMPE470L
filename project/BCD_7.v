module BCD_7 #(parameter DL = 4)
            (input [DL-1:0] ones,
            input [DL-1:0] ten,
            input [DL-1:0] hund,
            input CLK,
            input RST,
            output reg [3:0] anode,
            output reg[6:0] OUT);

        parameter NULL = 7'b1111111;
        parameter ZERO = 7'b0000001;
        parameter ONE = 7'b1001111;
        parameter TWO = 7'b0010010;
        parameter THREE = 7'b0000110;
        parameter FOUR = 7'b1001100;
        parameter FIVE = 7'b0100100;
        parameter SIX = 7'b0100000;
        parameter SEVEN = 7'b0001111;
        parameter EIGHT = 7'b0000000;
        parameter NINE = 7'b0000100;


        reg[1:0] anode_select;
        reg[16:0] anode_timer;

        //go through anodes
        always @ (posedge CLK or posedge RST) begin
            if(RST) begin
                anode_select <= 0;
                anode_select <= 0;
            end
            else begin
                if(anode_timer == 99_999) begin
                    anode_timer <= 0;
                    if(anode_select == 2) anode_select <= 0;
                    else anode_select <= anode_select + 1;
                end
                else anode_timer <= anode_timer + 1;
            end
        end

        always @(anode_select) begin
            case(anode_select) 
                0: anode = 4'b1110;
                1: anode = 4'b1101;
                2: anode = 4'b1011;
            endcase
        end


        always @* begin
            case(anode_select)
                0: begin
                    case(ones)
                        0: OUT = ZERO;
                        1: OUT = ONE;
                        2: OUT = TWO;
                        3: OUT = THREE;
                        4: OUT = FOUR;
                        5: OUT = FIVE;
                        6: OUT = SIX;
                        7: OUT = SEVEN;
                        8: OUT = EIGHT;
                        9: OUT = NINE;
                    endcase
                end
                1: begin
                    case(ten)
//                        0: OUT = ZERO;
                        0:begin
                            if(hund != 0) OUT = ZERO;
                            else OUT = NULL;
                        end
                        1: OUT = ONE;
                        2: OUT = TWO;
                        3: OUT = THREE;
                        4: OUT = FOUR;
                        5: OUT = FIVE;
                        6: OUT = SIX;
                        7: OUT = SEVEN;
                        8: OUT = EIGHT;
                        9: OUT = NINE;
                    endcase 
                end
                
                2: begin
                    case(hund)
//                        0: OUT = ZERO;
                        0: OUT = NULL;
                        1: OUT = ONE;
                        2: OUT = TWO;
                    endcase
                end
            endcase
        end


endmodule
