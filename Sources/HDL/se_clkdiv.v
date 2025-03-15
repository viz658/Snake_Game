`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: 
// 
// Create Date: 11/03/2023 05:02:47 PM
// Design Name: clk divider
// Module Name: se_clkdiv
// Project Name: snake
// Target Devices: 
// Tool Versions: 
// Description: clk divider using parameter
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module se_clkdiv #(parameter div_value = 4999) //div = 100Mhz/(2*desired frequency) -1
    (
    input wire clk,
    output reg divided_clk =0
    );
 
 integer counter_value = 0;
 always@ (posedge clk) 
 begin
    if(counter_value == div_value)
        counter_value <= 0;
    else
        counter_value <= counter_value+1;
 end
 
 always @(posedge clk)
 begin
    if(counter_value == div_value)
        divided_clk <= ~divided_clk;
    else
        divided_clk <= divided_clk;
 end
endmodule
