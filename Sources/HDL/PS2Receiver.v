`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Thomas Kappenman
// 
// Create Date: 03/03/2015 09:33:36 PM
// Design Name: 
// Module Name: PS2Receiver
// Project Name: Nexys4DDR Keyboard Demo
// Target Devices: Nexys4DDR
// Tool Versions: 
// Description: PS2 Receiver module used to output keycodes using PS2 protocol from a keyboard plugged into the USB port on Artix 7
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PS2Receiver(
    input clk, //master clk 50MHz
    input kclk, //keyboard clk
    input kdata, //keyboard data
    output [31:0] keycodeout
    );
    
    
    wire kclkf, kdataf; //keyboard clk and data
    reg [7:0]datacur; //data
    reg [7:0]dataprev; //data
    reg [3:0]cnt; //cnt used for implementing ps2 protocol
    reg [31:0]keycode; //output keycode from keyboard protocol
    reg flag;
    
    initial begin
        keycode[31:0]<=0'h00000000;
        cnt<=4'b0000;
        flag<=1'b0;
    end
    
debouncer debounce(
    .clk(clk),
    .I0(kclk),
    .I1(kdata),
    .O0(kclkf),
    .O1(kdataf)
);
    
    always@(negedge(kclkf))begin //data is valid and retrieved at negative edge of keyboard clk
    case(cnt)
    0:;//Start bit 
    1:datacur[0]<=kdataf; //databit 1
    2:datacur[1]<=kdataf; //databit 2
    3:datacur[2]<=kdataf; //databit 3
    4:datacur[3]<=kdataf; //databit 4
    5:datacur[4]<=kdataf; //databit 5
    6:datacur[5]<=kdataf; //databit 6
    7:datacur[6]<=kdataf; //databit 7
    8:datacur[7]<=kdataf; //databit 8
    9:flag<=1'b1; //parity bit
    10:flag<=1'b0; //stop bit
    
    endcase
    if(cnt<=9) cnt<=cnt+1; //inc cnt
    else if(cnt==10) cnt<=0; //reset cnt
        
end

    always @(posedge flag)begin //decipher keycode after parity bit is high
    if (dataprev!=datacur)begin
        keycode[31:24]<=keycode[23:16]; 
        keycode[23:16]<=keycode[15:8];
        keycode[15:8]<=dataprev;
        keycode[7:0]<=datacur;
        dataprev<=datacur;
    end
end
    
assign keycodeout=keycode; //output keycode
    
endmodule
