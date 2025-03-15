`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer:
// 
// Create Date: 
// Design Name: 
// Module Name: decoder
// Project Name: snake
// Target Devices: Artix 7, keyboard
// Tool Versions: 
// Description: keycode decoder for 4 bit direction 
// 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder(
	input [31:0] x,
    output reg [3:0] movement
	 );

//reg [2:0] movement;

always @(*)
	case(x[7:0])
	'h6B : //Left arrow
	begin
	   movement = 4'b0010;
	end
	'h72 : //Down arrow
	begin
	   movement = 4'b0100;
	end
	'h74 : //Right arrow
	begin
	   movement = 4'b1000;
	end
	'h75 : //Up arrow
	begin
	   movement = 4'b0001;
	end
	endcase

endmodule
