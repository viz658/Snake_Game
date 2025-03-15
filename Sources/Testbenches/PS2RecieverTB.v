module PS2RecieverTB();

    reg clk_TB; //master clk 50MHz
    reg kclk_TB; //keyboard clk
    reg kdata_TB; //keyboard data
    wire [31:0] keycodeout_TB;
 


PS2Receiver PS2ReceiverTST(
    .clk(clk_TB), //master clk 50MHz
    .kclk(kclk_TB), //keyboard clk
    .kdata(kdata_TB), //keyboard data
    .keycodeout(keycodeout_TB)
    );
    
    always
    begin
    #5
    clk_TB = ~clk_TB;
    end
    
    always
    begin
    #1
    kclk_TB = ~kclk_TB;
    end

initial
begin
clk_TB = 0;
kclk_TB = 0;
kdata_TB = 0;
#50
kdata_TB = 1;
#2
kdata_TB = 0;
#2
kdata_TB = 0;
#2
kdata_TB = 1;
#2
kdata_TB = 0;
#2
kdata_TB = 1;
#2
kdata_TB = 0;
#2
kdata_TB = 1;
#2

kdata_TB = 0;
#50

kdata_TB = 0;
#2
kdata_TB = 1;
#2
kdata_TB = 0;
#2
kdata_TB = 1;
#2
kdata_TB = 0;
#2
kdata_TB = 0;
#2
kdata_TB = 1;
#2
kdata_TB = 1;
#2

kdata_TB = 0;
#50

kdata_TB = 1;
#2
kdata_TB = 0;
#2
kdata_TB = 0;
#2
kdata_TB = 1;
#2
kdata_TB = 0;
#2
kdata_TB = 1;
#2
kdata_TB = 0;
#2
kdata_TB = 1;
#2

kdata_TB = 0;
end

endmodule
