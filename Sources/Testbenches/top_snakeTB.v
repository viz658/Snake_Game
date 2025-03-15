module top_snakeTB();

reg [1:0] top_snake_colors_tb;
reg top_snake_reset_tb;
reg top_snake_master_clk_tb;
reg top_snake_KB_clk_tb;
reg top_snake_data_tb;
wire [3:0] top_snake_VGA_R_tb;
wire [3:0] top_snake_VGA_G_tb;
wire [3:0] top_snake_VGA_B_tb;
wire top_snake_VGA_hSync_tb;
wire top_snake_VGA_vSync_tb;
wire [7:0] top_snake_anode_tb;
wire [6:0] top_snake_cathodes_tb;
wire [1:0] top_snake_color_leds_tb;
wire top_snake_pwm_r_tb;
wire top_snake_pwm_g_tb;



top_snake snakeTST(
.top_snake_colors(top_snake_colors_tb), 
.top_snake_reset(top_snake_reset_tb),
.top_snake_master_clk(top_snake_master_clk_tb), 
.top_snake_KB_clk(top_snake_KB_clk_tb),
.top_snake_data(top_snake_data_tb), 
.top_snake_VGA_R(top_snake_VGA_R_tb), 
.top_snake_VGA_G(top_snake_VGA_G_tb), 
.top_snake_VGA_B(top_snake_VGA_B_tb), 
.top_snake_VGA_hSync(top_snake_VGA_hSync_tb), 
.top_snake_VGA_vSync(top_snake_VGA_vSync_tb), 
.top_snake_anode(top_snake_anode_tb),
.top_snake_cathodes(top_snake_cathodes_tb), 
.top_snake_color_leds(top_snake_color_leds_tb), 
.top_snake_pwm_r(top_snake_pwm_r_tb), 
.top_snake_pwm_g(top_snake_pwm_g_tb) 
);

always
begin
#1
top_snake_master_clk_tb = ~top_snake_master_clk_tb;
end

always
begin
#4
top_snake_KB_clk_tb = ~top_snake_KB_clk_tb;
end

initial
begin
top_snake_reset_tb =0;
top_snake_data_tb =0;
top_snake_colors_tb =0;
top_snake_master_clk_tb =0;
top_snake_KB_clk_tb =0;

#200
top_snake_reset_tb =1;
#10
top_snake_reset_tb =0;
end


endmodule
