// Code your design here
// Code your design here


module maj3( OUT, A, B, C);
	
  input A, B, C;
  output OUT;
  wire AB, BC, CA;
  
  
  and( AB, A, B);
  and( BC, B, C); //instantiation of and() gate
  and( CA, C, A);
  // comment
 
  or( OUT, AB, BC, CA); 
endmodule