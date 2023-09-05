module second_counter(input CLK_IN,
                      output wire [3:0] anode, //common anode
                      output wire dp,
                      output wire [6:0] out) //7 segment);


    assign anode = 4'b1110;
    assign dp = 1;


    reg [25:0] count = 0;
    reg CLK_OUT;

    always @(posedge CLK_IN) begin 
        count <= count + 1;
        if (count == 50_000_000) begin
            count <= 0;
            CLK_OUT <= ~CLK_OUT;
        end

    end

    counter DUT (.CLK(CLK_OUT), .OUT(out));

endmodule