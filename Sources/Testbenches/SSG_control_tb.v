`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 11:49:55 PM
// Design Name: 
// Module Name: SSG_control_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SSG_control_tb();
reg [3:0] SSG_control_score0_tb;
wire [7:0] SSG_control_anode_tb;
wire [6:0] SSG_control_cathodes_tb;
 SSG_control uut
    (
     .SSG_control_score0(SSG_control_score0_tb),
     .SSG_control_anode(SSG_control_anode_tb),
     .SSG_control_cathodes(SSG_control_cathodes_tb)
    );
    
   initial begin
   #2 SSG_control_score0_tb = 0;
   #2 SSG_control_score0_tb = 1;
    #2 SSG_control_score0_tb = 2;
    #2 SSG_control_score0_tb = 3;
    #2 SSG_control_score0_tb = 4;
    #2 SSG_control_score0_tb = 5;
    #2 SSG_control_score0_tb = 6;
    #2 SSG_control_score0_tb = 7;
    #2 SSG_control_score0_tb = 8;
    #2 SSG_control_score0_tb = 9;
    #2 SSG_control_score0_tb = 10;
    #2 SSG_control_score0_tb = 11;
    #2 SSG_control_score0_tb = 12;
    #2 SSG_control_score0_tb = 13;
    #2 SSG_control_score0_tb = 14;
    #2 SSG_control_score0_tb = 15;
   $finish; 
   end

endmodule
