`include "behavioural_PIPO1.sv"
`include "behavioural_PIPO2.sv"
`include "behavioural_ADD16.sv"
`include "behavioural_EQZ.sv"
`include "behavioural_CNTR.sv"

module MUL_dataPath( eqz, ldA, ldB, ldP, clrP, decB, data_in, clk);
	input ldA, ldB, ldP, clrP, decB, clk;
	input [15:0] data_in;
	output eqz;
	wire [15:0] x, y, z, bOut, bus;

	//data path instantiation 
	assign bus = data_in;
	
	//instantiations	
	PIPO1 A (x, bus, ldA, clk); //parallel-in parallel-out without clr  
    PIPO2 P (y, z, ldP, clrP, clk); //parallel-in parallel-out with clr 
	CNTR B ( bOut, bus, ldB, decB, clk); //counter
	ADD AD ( z, x, y); //adder
	EQZ COMP ( eqz, bOut); //comparator

endmodule // Code your design here

module controller( ldA, ldB, ldP, clrP, decB, done, clk, eqz, start);
	input clk, eqz, start;
	output reg ldA, ldB, ldP, clrP, decB, done; //controller will be generating these signals. output signals 
	reg [2:0]state; //s0, s1, s2, s3, s4
	parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
	always @( posedge clk)
	begin 
		case (state)
			S0: if(start) state <= S1;
			S1: state <= S2;
			S2: state <= S3;
			S3: #2 if(eqz) state <= S4; //delay for sync
			S4: state <= S4;
			default: state <= S0;
		endcase
	end

	always @ ( state )
	begin
		case(state)
			S0: begin #1 
				ldA = 0; ldB = 0; ldP = 0;
				clrP = 0; decB = 0; 
			    	end
		        S1: begin #1
				ldA = 1;
			    	end
			S2: begin #1
			    ldA = 0; ldB = 1; clrP = 1; 
			 	end
		        S3: begin #1
	    			ldB = 0; ldP =1; clrP = 0;
				decB = 1; //P =  x + z, B = B-1, S3 repeated clock after  clock
				end	
			S4: begin #1
				done = 1; ldB = 0; ldP = 0;
				decB = 0;
				end
			default: begin #1
				ldA = 0; ldB = 0; ldP = 0; clrP = 0;
				decB = 0; 
				end
		endcase
	end
endmodule
