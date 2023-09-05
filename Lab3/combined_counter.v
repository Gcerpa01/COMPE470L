//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2023 09:04:05 PM
// Design Name: 
// Module Name: combined_counter
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

module combined_counter(
    input CLK_IN,
    output wire [3:0] anode, //common anode
    output wire dp,
    output wire [6:0] out
);

assign anode = 4'b1110;
assign dp = 1;

reg [25:0] count = 0;
reg CLK_OUT;
reg [3:0] current_state, next_state;

always @(posedge CLK_IN) begin 
    count <= count + 1;
    if (count == 50_000_000) begin
        count <= 0;
        CLK_OUT <= ~CLK_OUT;
    end
end

always @(posedge CLK_OUT) begin 
    current_state <= next_state;
end

always @(posedge CLK_OUT or current_state) begin
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
        0: out = 7'b0000001;
        1: out = 7'b1001111;
        2: out = 7'b0010010;
        3: out = 7'b0000110;
        4: out = 7'b1001100;
        5: out = 7'b0100100;
        6: out = 7'b0100000;
        7: out = 7'b0001111;
        8: out = 7'b0000000;
        9: out = 7'b0000100;
        10: out = 7'b0001000;
        11: out = 7'b1100000;
        12: out = 7'b0110001;
        13: out = 7'b1000010;
        14: out = 7'b0110000;
        15: out = 7'b0111000;
        default: out = 7'b0111000;
    endcase
end

endmodule
