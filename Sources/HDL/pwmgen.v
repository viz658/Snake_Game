`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: 
// 
// Create Date: 11/13/2023 07:19:35 PM
// Design Name: pwm generator
// Module Name: pwm
// Project Name: snake
// Target Devices: Artix 7
// Tool Versions: 
// Description: pwm generator 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwmgen #(parameter R_SIZE=8)(
    input clk,
    input rst,
    input load,
    input [R_SIZE:0] duty,
    output reg pwm=0
    );
    reg [R_SIZE-1:0]r_count=0;
    reg [R_SIZE-1:0]duty_load=0;
    
    
    
    always@(posedge clk or posedge rst) //counter
    begin
        if(rst)
            r_count<=0;     
        else
            r_count<=r_count+1;             
    end
    always@(posedge clk or posedge rst)
    begin
        if(rst)
            pwm<=1'b0;
        else
            if(r_count<duty_load)                //comparator
                pwm<=1'b1;
            else
                pwm<=1'b0;
    end
    
    always@(posedge clk or posedge rst)
    begin
        if(rst)
            duty_load<=0;
        else
            begin
                if(load)
                    duty_load<=duty;       //pwm out
                else
                    duty_load<=duty_load+1;
            end
    end
endmodule
