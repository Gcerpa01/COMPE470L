//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/4/2023 10:54:10 PM
// Design Name: 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(input CLK,
            output reg[6:0] OUT);



reg [3:0] current_state,next_state;

always @(posedge CLK) begin 
    current_state <= next_state;
end

always @(CLK or current_state) begin
    case (current_state)
        0: next_state <= 15;

        1: next_state <= 0;

        2: next_state <= 1;

        3: next_state <= 2;

        4: next_state <= 3;

        5: next_state <= 4;

        6: next_state <= 5;

        7: next_state <= 6;

        8: next_state <= 7;

        9: next_state <= 8;
        
        10: next_state <= 9;

        11: next_state <= 10;

        12: next_state <= 11;
        
        13: next_state <= 12;

        14: next_state <= 13;

        15: next_state <= 14;

        default: next_state <= 15;
    endcase
end


always @(current_state) begin
    case (current_state)
        0: OUT = 7'b0000001;

        1: OUT = 7'b1001111;

        2: OUT = 7'b0010010;

        3: OUT = 7'b0000110;

        4: OUT = 7'b1001100;

        5: OUT = 7'b0100100;

        6: OUT = 7'b0100000;

        7: OUT = 7'b0001111;

        8: OUT = 7'b0000000;

        9: OUT = 7'b0000100;

        10: OUT = 7'b0001000;

        11: OUT = 7'b1100000;

        12: OUT = 7'b0110001;

        13: OUT = 7'b1000010;

        14: OUT = 7'b0110000;

        15: OUT = 7'b0111000;

        default: OUT = 7'b0111000;
    endcase
end


endmodule
