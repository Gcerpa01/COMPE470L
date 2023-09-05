`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2023 09:04:05 PM
// Design Name: 
// Module Name: seconds_counter
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


module seconds_counter(input CLK_IN,
                      output wire [3:0] anode, //common anode
                      output wire dp,
                      output wire [6:0] out); //7 segment);


    assign anode = 4'b1110;
    assign dp = 1;


    reg [25:0] count = 0;
    reg CLK_OUT;

    //basys 3 clk frequency = 100MHz = 100_000_000Hz
    //100_000_000 / 2 = 50_000_000Hz 
    always @(posedge CLK_IN) begin 
        count <= count + 1;
        if (count == 50_000_000) begin
            count <= 0;
            CLK_OUT <= ~CLK_OUT;
        end

    end

    counter DUT (.CLK(CLK_OUT), .OUT(out));

endmodule
