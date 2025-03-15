`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer:
// 
// Create Date: 
// Design Name: VGa driver
// Module Name: VGA_gen
// Project Name: snake
// Target Devices: Artix 7
// Tool Versions: 
// Description: VGA driver used for snake
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module VGA_gen(VGA_clk, xCount, yCount, displayArea, VGA_hSync, VGA_vSync, blank_n, video_on);

input VGA_clk; //25MHz clk
output reg [9:0]xCount; 
output reg [9:0]yCount; 
output reg displayArea;  
output VGA_hSync, VGA_vSync, blank_n, video_on;
	
localparam HD = 640; //x display area
localparam HF = 48; //x back porch
localparam HB = 16; //x front porch
localparam HR = 96; //x sync pulse

localparam VD = 480; //y display area
localparam VF = 10; //y front porch
localparam VB = 33; //y back porch
localparam VR = 2; //y sync pulse

localparam x_end = HD+HF+HB+HR-1; //end of horizontal counter  799
localparam y_end = VD+VF+VB+VR-1; //end of vertical counter 524

reg hSync_reg, vSync_reg; 

always@(posedge VGA_clk)
begin
    if(xCount == x_end) //HD //x_end
        xCount <= 0;
    else 
        xCount <= xCount + 1;
end

always@(posedge VGA_clk)
begin
    if(xCount == x_end) //HD //x_end
    begin
        if(yCount == y_end) //VD //y_end
            yCount <= 0;
        else
        yCount <= yCount + 1;
    end
end

always@(posedge VGA_clk)
begin
    hSync_reg <= (xCount >= (HD+HB) && xCount <=(HD+HB+HR-1)); //hsync asserted between 656 and 751
    vSync_reg <= (yCount >= (VD+VB) && yCount <=(VD+VB+VR-1)); //vsync asserted between 490 and 491
end

	always@(posedge VGA_clk)
	begin
		displayArea <= ((xCount < HD) && (yCount < VD)); 
	end

assign VGA_vSync = vSync_reg; 
assign VGA_hSync = hSync_reg;	
	assign video_on = (xCount<HD) && (yCount<VD); //video is displayed
assign blank_n = displayArea; //not needed for certain development boards such as Artix-7	

endmodule		
