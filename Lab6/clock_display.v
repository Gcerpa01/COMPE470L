module clock_display(input [3:0] H_1,
            input [3:0] H_0,
            input [3:0] M_1,
            input [3:0] M_0,
            input CLK_IN,
            output reg[6:0] out,
            output [3:0] anode, //common anode
            output dp);

reg [3:0] state, next_state;
assign dp = 1;
assign anode = state;


local param m_0 = 4'b1110; local pram m_1 = 4'b1101;
local param h_0 = 4'b1011; local pram h_1 = 4'b0111;

wire [6:0] m_0_out, m_1_out;
wire [6:0] h_0_out, h_1_out;

//counter for display
always @(posedge CLK_IN) begin
    state <= next_state;
end

//
always @(state) begin
    case(state)
        m_0: next_state = h_1;
        h_1: next_state = h_0;
        h_0: next_state = m_1;
        m_1: next_state = m_0;
        default: next_state = m_0;
    endcase
end

always @(state) begin
    if(state == m_0) out = m_0_out;
    else if(state == m_1) out = m_1_out;
    else if(state == h_0) out = h_0_out;
    else if(state == h_1) out = h_1_out;
end


BCD_7 DUT0(.sw(M_0),.out(m_0_out));
BCD_7 DUT1(.sw(M_1),.out(m_1_out));
BCD_7 DUT2(.sw(H_0),.out(h_0_out));
BCD_7 DUT3(.sw(H_1),.out(h_1_out));

endmodule

