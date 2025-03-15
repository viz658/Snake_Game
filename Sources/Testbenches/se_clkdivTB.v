module se_clkdivTB();
reg clk_TB;
wire divided_clk_TB;

se_clkdiv se_clkdivTST //div = 100Mhz/(2*desired frequency) -1
    (
    .clk(clk_TB),
    .divided_clk(divided_clk_TB)
    );
    
always
begin
#1000
clk_TB = ~clk_TB;
end   

initial
begin
clk_TB =0;
end
    

endmodule
