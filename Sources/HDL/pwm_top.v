`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: 
// 
// Create Date: 11/13/2023 07:29:41 PM
// Design Name: pwm_top
// Module Name: top pwm
// Project Name: snake
// Target Devices: Artix 7
// Tool Versions: 
// Description: top of pwm module connected for rgb leds on Artix 7
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm_top#(parameter SIZE=4)(
    input clk,
    input rst,
    input load_r,
    input load_g,
    input load_b,
    output pwm_r,
    output pwm_g,
    output pwm_b
    );
    reg [SIZE-1:0] duty = 1'hf;
    wire clk_slow;
    wire lock;
    wire clk_locked;
//if getting error with PLL- go to PLLE2 tab -> check allow override mode -> change ZHOLD to BUF IN and regenerate
  clk_wiz_0 pwm_clk
   (
    // Clock out ports
       .clk_out1(clk_slow),     // output clk_out1 6.49606MHz
    // Status and control signals
    .reset(rst), // input reset
    .locked(lock),       // output locked
   // Clock in ports
       .clk_in1(clk)      // input clk_in1 
);

 assign clk_locked=clk_slow&lock; 
//pwm for red RGB led
pwmgen#(.R_SIZE(SIZE))PWM_r(
    . clk(clk_locked),
    . rst(rst),
    . load(load_r),
    . duty(duty),
    . pwm(pwm_r)
    );
//pwm for green RGB led
pwmgen#(.R_SIZE(SIZE))PWM_g(
    . clk(clk_locked),
    . rst(rst),
    . load(load_g),
    . duty(duty),
    . pwm(pwm_g)
    );
//pwm for blue RGB led, not used in top module     
pwmgen#(.R_SIZE(SIZE))PWM_b(
    . clk(clk_locked),
    . rst(rst),
    . load(load_b),
    . duty(duty),
    . pwm(pwm_b)
    );
endmodule
