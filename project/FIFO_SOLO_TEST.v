
module FIFO_SOLO_TEST(
    input CLK_IN,
    input [7:0] sw,        // 8-bit data_in
    input btn1,            // btn for Reset (CENTER)
    input btn2,            // btn for write (UP)
    input btn3,            // btn for read (DOWN)
    input btn4,             //auto(RIGHT)
    output wire [3:0] anode,// common anode
    output wire dp,
    output wire [6:0] BCD_out, // 7 segment
    output wire full,
    output wire empty,
    output wire error,
    output wire seconds
);

///////// FIFO purposes /////////////////////
    parameter WL = 8;
    parameter DL = 400; //for display purposes
    parameter DEPTH = 4;
    reg [7:0] din; // Updated to 8 bits for the switch value
//////////////////////////////////////////


    assign dp = 1;

////// DISPLAY PURPOSES /////////////////////
    wire [WL - 1 :0] dout;
    wire [DL-1:0] ones;
    wire [DL-1:0] ten;
    wire [DL-1:0] hund;
//////////////////////////////////////////


    reg [25:0] count = 0;
    reg CLK_OUT;

    reg second = 0;

    // basys 3 clk frequency = 100MHz = 100_000_000Hz
    // 100_000_000 / 2 = 50_000_000Hz
    // Count every second
    always @(posedge CLK_IN) begin
        count <= count + 1;
        if (count == 50_000_000) begin
            count <= 0;
            CLK_OUT <= ~CLK_OUT;
            second <= ~second;
        end
    end

    assign seconds = second;

    FIFO #(.WL(WL),
           .DEPTH(DEPTH))
        DUT0(.CLK(CLK_OUT),
            .RST(btn1),
            .wReq(btn2),
            .rReq(btn3),
            .auto(btn4),
            .din(din),
            .dout(dout),
            .empty(empty),
            .full(full),
            .error(error));
                  
    BCD_7 #(.DL(DL)) DUT2(.ones(ones),.ten(ten),.hund(hund),.CLK(CLK_IN),.RST(btn1),.anode(anode),.OUT(BCD_out)); // show on display
      
    // Assign the value of sw to din
    always @(posedge CLK_IN) begin
        din <= sw;
    end
    
    assign ones = dout % 10;
    assign ten = (dout/10) % 10;
    assign hund = (dout/100);

endmodule
