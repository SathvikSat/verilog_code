// Code your testbench here
// or browse Examples
 
module maj3_tb;
  
  //dont take inputs dont produce outputs
//they need design under test 


//DUT - chip, 3 lines in, 1 out
//Test bench - Bread Board

  //3 local(wires of BB/probe) pins and 1 out part of test bench not part of DUT.

//wire local to test bench
  reg a, b, c;
  wire out;
  
  // not function call, instantiation
  maj3 DUT1( out, a, b, c);
  
  //values for a, b c enum
  initial begin 
    for( int i= 0; i<8; i++) begin
      #5 {a,b,c} = i; // each bit of i is assigned to a, b, c i2, i1, i0, 3bits
      //every 5 time units, value changes
    end  
  end
  
  //i-verilog compiler under use.
  
  initial begin
    $monitor(a,b,c, out);
    $dumpfile("dump.vcd");//waveform file value change dump
    $dumpvars; //to dump all vars
	end
endmodule