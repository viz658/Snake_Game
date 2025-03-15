`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: 
// 
// Create Date: 11/24/2023 01:39:52 PM
// Design Name: 
// Module Name: SSG_control
// Project Name: snake
// Target Devices: Artix 7
// Tool Versions: 
// Description: seven segment display decoder
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SSG_control
    (
     input [3:0] SSG_control_score0,
     output [7:0] SSG_control_anode,
     output [6:0] SSG_control_cathodes
    );

   //SSG_control_anode = 8'b11111110; //ssd 0 is on
reg [7:0] an_tmp=8'b11111110;
reg [6:0] cc_tmp=0;
always @(SSG_control_score0)
 begin
  case(SSG_control_score0) 
     4'h0: cc_tmp = 7'b0000001;
     4'h1: cc_tmp = 7'b1001111; 
     4'h2: cc_tmp = 7'b0010010; 
     4'h3: cc_tmp = 7'b0000110; 
     4'h4: cc_tmp = 7'b1001100; 
     4'h5: cc_tmp = 7'b0100100; 
     4'h6: cc_tmp = 7'b0100000; 
     4'h7: cc_tmp = 7'b0001111; 
     4'h8: cc_tmp = 7'b0000000; 
     4'h9: cc_tmp = 7'b0000100;
     4'hA: cc_tmp = 7'b0001000;
     4'hB: cc_tmp = 7'b1100000;
     4'hC: cc_tmp = 7'b0110001;
     4'hD: cc_tmp = 7'b1000010;
     4'hE: cc_tmp = 7'b0110000;
     4'hF: cc_tmp = 7'b0111000; 
   default : cc_tmp = 7'b1111111; //default 9
  endcase
 end 
 assign SSG_control_anode = an_tmp;
 assign SSG_control_cathodes = cc_tmp;

endmodule
