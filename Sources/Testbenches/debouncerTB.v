module debouncerTB();
reg clk_TB;
reg I0_TB;
reg I1_TB;
wire O0_TB;
wire O1_TB;



debouncer debouncerTST(
    .clk(clk_TB),
    .I0(I0_TB),
    .I1(I1_TB),
    .O0(O0_TB),
    .O1(O1_TB)
    );
    
always
begin
#5
clk_TB =~clk_TB;
end


initial
begin
clk_TB =0;
I0_TB =0;
I1_TB =0;
#50
I0_TB =1;
#50
I1_TB =1;
#50
I0_TB =0;
#50
I1_TB =0;
#50
I1_TB =1;
#50
I0_TB =1;
#50
I0_TB =0;
#50
I1_TB =0;
end


endmodule
