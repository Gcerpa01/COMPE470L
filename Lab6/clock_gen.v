//200hz clock
module clock_gen(input CLK_IN,
                      output reg CLK_OUT);


    // reg [25:0] count = 0;
    reg [31:0] count = 0;

    // basys 3 clk frequency = 100MHz = 100_000_000Hz
    // 100_000_000 / 2 = 50_000_000Hz 
    
    always @(posedge CLK_IN) begin 
        count <= count + 1;
        if (count == 500_000) begin
            count <= 0;
            CLK_OUT <= ~CLK_OUT;
        end

    end

endmodule
