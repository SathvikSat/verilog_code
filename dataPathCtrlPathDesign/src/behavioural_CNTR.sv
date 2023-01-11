module CNTR( dout, din, ld, dec, clk);
	input [15:0] din;
	input ld, dec, clk;
	output reg [15:0] dout;

	always @ ( posedge clk)
	if(ld )	dout <= din;
	else if(dec) dout <= dout -1;
endmodule
