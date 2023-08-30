module BCD_main (input [3:0] sw,
                output wire [6:0] out, //7 segment
                output wire [7:0] anode, //common anode
                output wire dp);

    assign anode = 8'b11111110;
    assign dp = 1;
    BCD_7 DUT(.sw(sw),.out(out));

endmodule