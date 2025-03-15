`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: 
// 
// Create Date: 11/18/2023 07:56:20 PM
// Design Name: top snake module 
// Module Name: top_snake
// Project Name: snake on Artix-7 FPGA
// Target Devices: Artix-7, vga monitor, ps2 keyboard
// Tool Versions: 
// Description: recreation of snake game using Artix-7 FPGA, vga monitor and ps2 keyboard
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top_snake(
input [1:0] top_snake_colors, //switches for color of snake
input top_snake_reset, //reset game
input top_snake_master_clk, //100MHz
input top_snake_KB_clk, //kb clk
input top_snake_data, //kb data
output reg [3:0] top_snake_VGA_R, //VGA R 
output reg [3:0] top_snake_VGA_G, //VGA G
output reg [3:0] top_snake_VGA_B, //VGA B 
output top_snake_VGA_hSync, //VGA horizontal sync 
output top_snake_VGA_vSync, //VGA vertical sync
output [7:0] top_snake_anode,//used to display score on SSG 
output [6:0] top_snake_cathodes, //used to display score on SSG
output [1:0] top_snake_color_leds, //difficulty leds
output top_snake_pwm_r, //red led
output top_snake_pwm_g //green led
    );
assign top_snake_color_leds = top_snake_colors;   //color switches leds

//pwm for red led and green led
pwm_top#(.SIZE(4)) pwmgen(
    .clk(top_snake_master_clk),
    .rst(top_snake_reset),
    .load_r(game_over),
    .load_g(win),
    .load_b(), //not used 
    .pwm_r(top_snake_pwm_r),
    .pwm_g(top_snake_pwm_g),
    .pwm_b() // not used
    );  
//clk divider for PS2Reciever clk 50MHZ   
reg CLK50MHZ=0;    
always @(posedge(top_snake_master_clk))begin
    CLK50MHZ<=~CLK50MHZ;
end

reg win; //track when player wins the game

wire [9:0] xCount; //x pixel
wire [9:0] yCount; //y pixel
//apple initially at (x,y): (20,20)
reg [9:0] appleX =20; 
reg [8:0] appleY =20;
//randomx and randomy output used for apple logic
wire [9:0]rand_X;
wire [8:0]rand_Y;


wire VGA_clk; //25 MHz VGA driver clk

//RGB outputs
reg [3:0]R; 
reg [3:0]G;
reg [3:0]B;

wire [3:0] direction; //used for direction of snake
reg game_over;//track when game is over
reg apple_inX, apple_inY, apple;//used to draw apple
reg border;//used to draw border of game screen
reg [4:0] appleCount=0; //track count of apples to determine size of snake and winning screen

//used for drawing snake
reg snakeHead;
reg snakeHead1;
reg snakeHead2;
reg snakeHead3;
reg snakeHead4;
reg snakeHead5;
reg snakeHead6;
reg snakeHead7;
reg snakeHead8;
reg snakeHead9;
reg snakeHead10;
reg snakeHead11;
reg snakeHead12;
reg snakeHead13;
reg snakeHead14;
reg snakeHead15;

//for snake body and front of head
reg [9:0] snakeHeadX=160;
reg [8:0] snakeHeadY=160;
reg [9:0] snakeHeadX1=0;
reg [8:0] snakeHeadY1=0;
reg [9:0] snakeHeadX2=0;
reg [8:0] snakeHeadY2=0;
reg [9:0] snakeHeadX3=0;
reg [8:0] snakeHeadY3=0;
reg [9:0] snakeHeadX4=0;
reg [8:0] snakeHeadY4=0;
reg [9:0] snakeHeadX5=0;
reg [8:0] snakeHeadY5=0;
reg [9:0] snakeHeadX6=0;
reg [8:0] snakeHeadY6=0;
reg [9:0] snakeHeadX7=0;
reg [8:0] snakeHeadY7=0;
reg [9:0] snakeHeadX8=0;
reg [8:0] snakeHeadY8=0;
reg [9:0] snakeHeadX9=0;
reg [8:0] snakeHeadY9=0;
reg [9:0] snakeHeadX10=0;
reg [8:0] snakeHeadY10=0;
reg [9:0] snakeHeadX11=0;
reg [8:0] snakeHeadY11=0;
reg [9:0] snakeHeadX12=0;
reg [8:0] snakeHeadY12=0;
reg [9:0] snakeHeadX13=0;
reg [8:0] snakeHeadY13=0;
reg [9:0] snakeHeadX14=0;
reg [8:0] snakeHeadY14=0;
reg [9:0] snakeHeadX15=0;
reg [8:0] snakeHeadY15=0;

wire update; //for update clk
reg collision;//snake eating apple
wire [31:0] keycodeout;//keycode
wire vid_on; //video on
 
//25MHz clk divider for VGA
se_clkdiv #(.div_value(1)) vgaclkdiv (.clk(top_snake_master_clk), .divided_clk(VGA_clk));

VGA_gen gen1(.VGA_clk(VGA_clk), .xCount(xCount), .yCount(yCount), .displayArea(), .VGA_hSync(top_snake_VGA_hSync), .VGA_vSync(top_snake_VGA_vSync), .blank_n(), .video_on(vid_on)); //VGA driver	
randomGrid rand1(.VGA_clk(VGA_clk), .rand_X(rand_X), .rand_Y(rand_Y));//randomizer for apple logic
PS2Receiver keyboard(.clk(CLK50MHZ),.kclk(top_snake_KB_clk),.kdata(top_snake_data),.keycodeout(keycodeout)); //PS2 reciever for keyboard keycodes
decoder keydecode(.x(keycodeout),.movement(direction));//decoder for keycodes to direction
SSG_control ssg(.SSG_control_score0(appleCount),.SSG_control_anode(top_snake_anode),.SSG_control_cathodes(top_snake_cathodes)); //SSG driver for score tracking

//25hz clkdivider for update clk
se_clkdiv #(.div_value(1999999)) UPDATE(.clk(top_snake_master_clk), .divided_clk(update));

//begin drawing snake game 

always @(posedge VGA_clk)//draw border
begin
    border <= ((xCount < 10 || (xCount > 630 && xCount < 640)) ||yCount < 10 || (yCount > 470 && yCount < 480));
end

always@(posedge VGA_clk)
begin
    if(collision) //when front of snake eats apple
        begin
            if((rand_X<10) || (rand_X>630) || (rand_Y<10) || (rand_Y>470)) //if apple randomly generataed in border
            begin
                
                appleX <= 40;
                appleY <= 30;
            end
            else
            begin
                appleX <= rand_X;
                appleY <= rand_Y;
            end
        end
        else if(top_snake_reset) 
        begin
            if((rand_X<10) || (rand_X>630) || (rand_Y<10) || (rand_Y>470)) //if apple randomly generataed in border
            begin
                appleX <=340;
                appleY <=430;
            end
            else
            begin
                appleX <= rand_X; 
                appleY <= rand_Y;
            end
        end
    end
always @(posedge VGA_clk) //draw apple
begin
    apple_inX <= (xCount > appleX && xCount < (appleX + 10));
    apple_inY <= (yCount > appleY && yCount < (appleY + 10));
    apple = apple_inX && apple_inY;
end

always@(posedge update) //update snake
begin
if(top_snake_reset)
begin
    snakeHeadX = 160;
    snakeHeadY = 160;
 end
 else begin
    case(direction)
        4'b0001: begin //up
        snakeHeadY <= snakeHeadY -(4+(appleCount/2));
        end
        4'b0010: begin //left
        snakeHeadX <= snakeHeadX -(4+(appleCount/2));
        end
        4'b0100: begin //down
        snakeHeadY <= snakeHeadY + (4+(appleCount/2));
        end
        4'b1000: begin //right
        snakeHeadX <= snakeHeadX + (4+(appleCount/2));
        end
        endcase	
   end

end

always@(posedge update) //update snakebody
begin
snakeHeadX1 <= snakeHeadX;
snakeHeadY1 <= snakeHeadY;
snakeHeadX2 <= snakeHeadX1;
snakeHeadY2 <= snakeHeadY1;
snakeHeadX3 <= snakeHeadX2;
snakeHeadY3 <= snakeHeadY2;
snakeHeadX4 <= snakeHeadX3;
snakeHeadY4 <= snakeHeadY3;
snakeHeadX5 <= snakeHeadX4;
snakeHeadY5 <= snakeHeadY4;
snakeHeadX6 <= snakeHeadX5;
snakeHeadY6 <= snakeHeadY5;
snakeHeadX7 <= snakeHeadX6;
snakeHeadY7 <= snakeHeadY6;
snakeHeadX8 <= snakeHeadX7;
snakeHeadY8 <= snakeHeadY7;
snakeHeadX9 <= snakeHeadX8;
snakeHeadY9 <= snakeHeadY8;
snakeHeadX10 <= snakeHeadX9;
snakeHeadY10 <= snakeHeadY9;
snakeHeadX11 <= snakeHeadX10;
snakeHeadY11 <= snakeHeadY10;
snakeHeadX12 <= snakeHeadX11;
snakeHeadY12 <= snakeHeadY11;
snakeHeadX13 <= snakeHeadX12;
snakeHeadY13 <= snakeHeadY12;
snakeHeadX14 <= snakeHeadX13;
snakeHeadY14 <= snakeHeadY13;
snakeHeadX15 <= snakeHeadX14;
snakeHeadY15 <= snakeHeadY14;
end

always @(posedge VGA_clk) begin //colors
if((game_over || top_snake_reset)&&~win)
begin
    R=4'b0111;
    B=4'b0000;
    G=4'b0000;
end
else if(win)
begin
R = 4'b0000;
G = 4'b1111;
B = 4'b0000;
end
//else if(!border)
//begin
else if(!border)
begin
R=4'b0000;
B=4'b0000;
G=4'b0000;
if(snakeHead||snakeHead1||snakeHead2||snakeHead3||snakeHead4||snakeHead5||snakeHead6||snakeHead7||snakeHead8||snakeHead9||snakeHead10||snakeHead11||snakeHead12||snakeHead13||snakeHead14||snakeHead15)
    begin
        if(top_snake_colors == 0)
        begin
        R=4'b0000;
        B=4'b0000;
        G=4'b1111; //green snake
        end
        if(top_snake_colors == 1)
        begin
        R=4'b1111; //pink snake
        B=4'b1111;
        G=4'b0000;
        end
        if(top_snake_colors == 2)
        begin
        R=4'b1111; //yellow snake
        B=4'b0000;
        G=4'b1111;
        end
        if(top_snake_colors == 3)
        begin
        R=4'b0000;
        B=4'b1111; //cyan snake
        G=4'b1111;
        end
    end 
    if(apple)
    begin
    R=4'b1111;
    B=4'b0000;
    G=4'b0000;
    end
end
else if(border)
begin
R = 4'b0000;
G = 4'b0000;
B = 4'b1111;
end

end

always@(posedge VGA_clk)
begin	
    //draw snake
    snakeHead = (xCount > snakeHeadX && xCount < (snakeHeadX+10)) && (yCount > snakeHeadY && yCount < (snakeHeadY +10));
    if(appleCount>0)
    snakeHead1 = (xCount > snakeHeadX1 && xCount < (snakeHeadX1+10)) && (yCount > snakeHeadY1 && yCount < (snakeHeadY1 +10));
    if(appleCount>1)
    snakeHead2 = (xCount > snakeHeadX2 && xCount < (snakeHeadX2+10)) && (yCount > snakeHeadY2 && yCount < (snakeHeadY2 +10));
    if(appleCount>2)
    snakeHead3 = (xCount > snakeHeadX3 && xCount < (snakeHeadX3+10)) && (yCount > snakeHeadY3 && yCount < (snakeHeadY3 +10));
    if(appleCount>3)
    snakeHead4 = (xCount > snakeHeadX4 && xCount < (snakeHeadX4+10)) && (yCount > snakeHeadY4 && yCount < (snakeHeadY4 +10));
    if(appleCount>4)
    snakeHead5 = (xCount > snakeHeadX5 && xCount < (snakeHeadX5+10)) && (yCount > snakeHeadY5 && yCount < (snakeHeadY5 +10));
    if(appleCount>5)
    snakeHead6 = (xCount > snakeHeadX6 && xCount < (snakeHeadX6+10)) && (yCount > snakeHeadY6 && yCount < (snakeHeadY6 +10));
    if(appleCount>6)
    snakeHead7 = (xCount > snakeHeadX7 && xCount < (snakeHeadX7+10)) && (yCount > snakeHeadY7 && yCount < (snakeHeadY7 +10));
    if(appleCount>7)
    snakeHead8 = (xCount > snakeHeadX8 && xCount < (snakeHeadX8+10)) && (yCount > snakeHeadY8 && yCount < (snakeHeadY8 +10));
    if(appleCount>8)
    snakeHead9 = (xCount > snakeHeadX9 && xCount < (snakeHeadX9+10)) && (yCount > snakeHeadY9 && yCount < (snakeHeadY9 +10));
    if(appleCount>9)
    snakeHead10 = (xCount > snakeHeadX10 && xCount < (snakeHeadX10+10)) && (yCount > snakeHeadY10 && yCount < (snakeHeadY10 +10));
    if(appleCount>10)
    snakeHead11 = (xCount > snakeHeadX11 && xCount < (snakeHeadX11+10)) && (yCount > snakeHeadY11 && yCount < (snakeHeadY11 +10));
    if(appleCount>11)
    snakeHead12 = (xCount > snakeHeadX12 && xCount < (snakeHeadX12+10)) && (yCount > snakeHeadY12 && yCount < (snakeHeadY12 +10));
    if(appleCount>12)
    snakeHead13 = (xCount > snakeHeadX13 && xCount < (snakeHeadX13+10)) && (yCount > snakeHeadY13 && yCount < (snakeHeadY13 +10));
    if(appleCount>13)
    snakeHead14 = (xCount > snakeHeadX14 && xCount < (snakeHeadX14+10)) && (yCount > snakeHeadY14 && yCount < (snakeHeadY14 +10));
    if(appleCount>14)
    snakeHead15 = (xCount > snakeHeadX15 && xCount < (snakeHeadX15+10)) && (yCount > snakeHeadY15 && yCount < (snakeHeadY15 +10));
    if(appleCount > 15)
    win =1;
    if(top_snake_reset)
    begin
    snakeHead1=0;
    snakeHead2=0;
    snakeHead3=0;
    snakeHead4=0;
    snakeHead5=0;
    snakeHead6=0;
    snakeHead7=0;
    snakeHead8=0;
    snakeHead9=0;
    snakeHead10=0;
    snakeHead11=0;
    snakeHead12=0;
    snakeHead13=0;
    snakeHead14=0;
    snakeHead15=0;
    win =0;
    end
end
//check for collisions
wire slowclk;
se_clkdiv #(.div_value(5)) slowerclk (.clk(top_snake_master_clk), .divided_clk(slowclk)); //around 8-9MHz clk fixes more than single increment with apple collision

always@(posedge slowclk)
begin
if(snakeHead&&(snakeHead3||snakeHead4||snakeHead5||snakeHead6||snakeHead7||snakeHead8||snakeHead9||snakeHead10||snakeHead11||snakeHead12||snakeHead13||snakeHead14||snakeHead15||border))
begin
    game_over=1;
end
if(snakeHead && apple && !collision)
    begin
    appleCount <= appleCount+1;
    collision =1;
    end
    else 
    begin
    collision =0;
    end
if(top_snake_reset)
begin
    game_over =0;
    collision = 0;
    appleCount<=0;
end
end
//vga outputs
always@(*)
begin
    top_snake_VGA_R = (vid_on) ? {4{R}} : 4'b0000;
    top_snake_VGA_G = (vid_on) ? {4{G}} : 4'b0000;
    top_snake_VGA_B = (vid_on) ? {4{B}} : 4'b0000;
end 
endmodule
