// Code your testbench here
// or browse Examples
module MUL_dataPath_tb; 
	reg [15:0] data_in;
	reg clk, start;
	wire done;

	//DUTs:
	MUL_dataPath DP ( eqz, ldA, ldB, ldP, clrP, decB, data_in, clk );
	controller CON( ldA, ldB, ldP, clrP, decB, done, clk, eqz, start);

	initial 
		begin
			clk  = 1'b0;
			#3 start = 1'b1;
			#500 $finish;
		end
	always #5 clk = ~clk;
	initial
		begin
			#17 data_in = 17; //17  * 5 = 85
			#10 data_in = 5;
		end
	initial
		begin
		  $monitor ($time, " %d, %b", DP.y, done ); //y output of the product, accessing y from DP
          $dumpfile ("mul.vcd"); 
          $dumpvars;
		end
endmodule