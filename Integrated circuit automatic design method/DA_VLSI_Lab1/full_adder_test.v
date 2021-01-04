`timescale 1ns/100ps

module full_adder_test;

   reg [3:0] A, B;
   wire [3:0] sum;
   wire cout;

  full_adder_4bit full_adder_a(.cout(cout),.A(A),.B(B),.s(sum));


  initial begin

      $vcdpluson(0);

      $monitor("%t A = %h B = %h, c_out=%b, sum = %h", $time, A, B, cout, sum);
      A <= 4'b0000; B <= 4'b0000;
      #10  A <= 4'b1100; B <= 4'b0111; 
      #10  A <= 4'b0000; B <= 4'b0111; 
      #10  A <= 4'b1100; B <= 4'b1011; 
      #10  A <= 4'b0110; B <= 4'b0101; 
      #10  A <= 4'b1110; B <= 4'b0011;
      #10

      $finish;
  end
endmodule
