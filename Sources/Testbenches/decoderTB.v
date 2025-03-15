module decoderTB();
reg [31:0] x_TB;
wire [3:0] movement_TB;

decoder decoderTST(
	.x(x_TB),
    .movement(movement_TB)
	 );
	 
initial
begin
x_TB = 'h6B;
#20
x_TB = 'h72;
#20
x_TB = 'h74;
#20
x_TB = 'h75;
#20;
end

endmodule
