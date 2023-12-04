module FIFO #(parameter WL = 10, DEPTH = 4)
             (input CLK,RST,wReq,rReq,
             input [WL - 1:0] din,
             output reg [WL - 1:0] dout,
            output reg full,empty,error);

    reg [WL - 1:0] MEM [0:DEPTH - 1]; //Depth x WL 
    reg [WL - 1:0] wPtr,rPtr;
    

    always @(posedge CLK) begin
        if(RST) begin
            full <= 1'b0;
            empty <= 1'b1;
            error <= 1'b0;
            wPtr <= 1'b0;
            rPtr <= 1'b0;
            dout <= 0;
        end
        else begin
            if (rReq && wReq) begin 
                if(empty)begin
                    error <= 1'b1;
                    dout <= 0;
                end
                else begin
                    if(full) begin
                        error <= 1'b0;
                        dout <= MEM[rPtr];
                        MEM[wPtr] <= din;
                    end
                    else begin
                        error <= 1'b0;
                        dout <= MEM[rPtr];
                        MEM[rPtr] <= 0;
                        if(rPtr == DEPTH - 1) rPtr <= 0;
                        else rPtr <= rPtr + 1;
                        MEM[wPtr] <= din;
                        if(wPtr == DEPTH - 1) wPtr <= 0;
                        else wPtr <= wPtr + 1;
                        
                    end
                end
            end
            else begin
            if (rReq) begin
                if(empty) begin
                    error <= 1'b1;
                    dout <= 0;
                end
                else begin
                    error <= 1'b0;
                    dout <= MEM[rPtr];
                    MEM[rPtr] <= 0;
                    if(wPtr == rPtr + 1 && rPtr != DEPTH - 1 || wPtr == 0 && rPtr == DEPTH - 1) empty <= 1'b1;
                    if(rPtr == DEPTH - 1) rPtr <= 0;
                    else rPtr <= rPtr + 1;
                    full <= 1'b0;
                end
            end
            if (wReq) begin
                if(full) error <= 1'b1;
                else begin
                    error <= 1'b0;
                    MEM[wPtr] <= din;
                    if(rPtr == wPtr + 1 && wPtr != DEPTH - 1 || rPtr == 0 && wPtr == DEPTH - 1) full <= 1'b1;
                    if(wPtr == DEPTH - 1) wPtr <= 0;
                    else wPtr <= wPtr + 1;
                    empty <= 1'b0;
                end
            end
        end
        end
    end
endmodule