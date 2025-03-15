`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// 
// Create Date: 
// Design Name: random grid
// Module Name: random grid
// Project Name: snake
// Target Devices: Artix 7
// Tool Versions: 
// Description: random x and random y generator used for apple logic
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module randomGrid(VGA_clk, rand_X, rand_Y);
	input VGA_clk;
	output reg [9:0]rand_X;
	output reg [8:0]rand_Y;
	reg [5:0]pointX, pointY = 10;

	always @(posedge VGA_clk)
		pointX <= pointX + 3;	
	always @(posedge VGA_clk)
		pointY <= pointY + 1;
	always @(posedge VGA_clk)
	begin	
		if(pointX>62)
			rand_X <= 620;
		else if (pointX<2)
			rand_X <= 20;
		else
			rand_X <= (pointX * 10);
	end
	
	always @(posedge VGA_clk)
	begin	
		if(pointY>46)
			rand_Y <= 460;
		else if (pointY<2)
			rand_Y <= 20;
		else
			rand_Y <= (pointY * 10);
	end
endmodule
