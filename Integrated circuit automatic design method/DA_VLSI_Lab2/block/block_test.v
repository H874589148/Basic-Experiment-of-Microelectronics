`timescale 1ns/100ps

module block_test;

   reg [3:0] A;
   wire [3:0] C_b, C_nb, C_b_a;
   reg clk;

   non_block non_block_a(.clk(clk),.A_in(A),.C_out(C_nb));
   block block_a(.clk(clk),.A_in(A),.C_out(C_b));
   block_altered nba(.clk(clk),.A_in(A),.C_out(C_b_a));

  initial begin

      $vcdpluson(0);


      $monitor("%t A = %h , non-block :  C = %h , blocked : C = %h , non-block-altered : C=%h .", $time, A, C_nb, C_b, C_b_a);
      A <= 4'b0000;
      clk <= 1'b0;
      #30  A <= 4'b0000;
      #30  A <= 4'b1100;
      #30  A <= 4'b0000;
      #30  A <= 4'b1100;
      #30  A <= 4'b0110;
      #30  A <= 4'b1110;
      #30

      $finish;
  end
  
  always
	#5 clk = ! clk;
  
endmodule
