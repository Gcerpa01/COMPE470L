module tb;
  parameter WL = 4;
  reg CLK,ENABLE,UP,CLR,LOAD;
  reg [WL -1 :0] D_IN;
  wire CO;
  wire [WL - 1:0] Q;
  

  
  BCD #(.WL(WL)) DUT (.CLK(CLK),
                 .ENABLE(ENABLE),
                 .UP(UP),
                 .CLR(CLR),
                 .LOAD(LOAD),
                 .D_IN(D_IN),
                 .CO(CO),
                 .Q(Q));
  
  parameter ClkPeriod = 10;
  initial CLK = 0;
  always #(ClkPeriod / 2) CLK = ~CLK;
  
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    
    CLR = 0; LOAD = 0; ENABLE = 0; UP = 0; D_IN = 0;
    
    @(posedge CLK) CLR = 1;
    
    @(posedge CLK) LOAD = 1; ENABLE = 1; UP = 0; D_IN = 9;
    
    @(posedge CLK) LOAD = 0; ENABLE = 1; UP = 1;
    
    repeat(3) @(posedge CLK);
    
    @(posedge CLK) LOAD = 0; ENABLE = 1; UP = 0;
    
    @(posedge CLK) LOAD = 0; ENABLE = 0; UP = 0; CLR = 0;
    
    $finish;
  end
endmodule 