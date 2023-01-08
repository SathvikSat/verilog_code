module PIPO1( dout, din, ld, clk);
	input ld, clk;
	input [15:0] din; //16-bit data
	output reg [15:0] dout;

	always @( posedge clk)
		if(ld) dout <= din;
endmodule
