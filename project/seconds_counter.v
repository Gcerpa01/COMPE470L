module seconds_counter(input CLK_IN,
                      input sw[3:0], //data_in
                      input btn1, //btn for Reset
                      input btn2, //btn for write
                      input btn3, //btn for read
                      output wire [3:0] anode, //common anode
                      output wire dp,
                      output wire [6:0] BCD_out, //7 segment
                      output wire full,
                      output wire empty,
                      output wire error); 


    parameter WL = 4;
    parameter DEPTH = 4;

    assign anode = 4'b1110;
    assign dp = 1;

    
    wire [WL - 1 :0] dout;

    reg [25:0] count = 0;
    reg CLK_OUT;

    //basys 3 clk frequency = 100MHz = 100_000_000Hz
    //100_000_000 / 2 = 50_000_000Hz 
    //Count every second
    always @(posedge CLK_IN) begin 
        count <= count + 1;
        if (count == 50_000_000) begin
            count <= 0;
            CLK_OUT <= ~CLK_OUT;
        end
    end

    FIFO #(.WL(WL),
           .DEPTH(DEPTH))
        DUT(.CLK(CLK_OUT),
            .RST(btn1),
            .wReq(btn2),
            .rReq(btn3),
            .din(sw),
            .dout(dout),
            .empty(empty),
            .full(full),
            .error(error));

    BCD_7 DUT0(.value(dout),.OUT(BCD_out)); //show on display


endmodule