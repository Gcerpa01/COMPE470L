`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2023 10:53:40 PM
// Design Name: 
// Module Name: BCD_main
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


module BCD_main (input [3:0] sw,
                output wire [6:0] out, //7 segment
                output wire [3:0] anode, //common anode
                output wire dp);

    assign anode = 4'b1110;
    assign dp = 1;
    BCD_7 DUT(.sw(sw),.out(out));

endmodule
