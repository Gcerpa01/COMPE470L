module clock_top( 
            input CLK_IN,
            input btn1,
            input btn2,
            // input [3:0] sw,
            output [5:0] sec_led,
            output [6:0] BCD_out,
            output [3:0] anode,
            output dp);


wire [26:0] counter;
wire [3:0] H_1;
wire [3:0] H_0;
wire [3:0] M_1;
wire [3:0] M_0;
wire newCLK;

clock_counter CC(.CLK(CLK_IN),
            .btn1(btn1),
            .btn2(btn2),
            .sec_led(sec_led),
            .counter(counter),
            .H_1(H_1),
            .H_0(H_0),
            .M_1(M_1),
            .M_0(M_0));

clock_gen CG(.CLK_IN(.CLK_IN),.CLK_OUT(newCLK));

clock_display CD(.CLK_IN(newCLK),
            .H_1(H_1),
            .H_0(H_0),
            .M_1(M_1),
            .M_0(M_0),
            .out(BCD_out),
            .anode(anode),
            .dp(dp));

// clock_alarm CA(.sw(sw),
//             .H_1(H_1);
//             .H_0(H_0);
//             .M_1(M_1);
//             .M_0(M_0);
//             .sec_led(sec_led),
//             .alarm_led(alarm_led));

endmodule
