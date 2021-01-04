`timescale 1ns/100ps

module mux4to1_test;

   reg [1:0] sel;
   reg a, b, c, d;
   wire out;

  mux4to1 mux4to1_a(.out(out),.a(a),.b(b),.c(c),.d(d),.sel(sel));


  initial begin

      $vcdpluson(0);

      $monitor("%t a = %b b = %b, c=%b, d=%b, sel=%h, out=%b", $time, a, b, c, d, sel, out);
      a <= 1'b0; b <= 1'b1; c <= 1'b0; d <= 1'b1; sel <= 2'b00;
      #10  a <= 1'b1; b <= 1'b0; c <= 1'b1; d <= 1'b0; sel <= 2'b11;
      #10  a <= 1'b1; b <= 1'b1; c <= 1'b0; d <= 1'b0; sel <= 2'b10;
      #10  a <= 1'b0; b <= 1'b0; c <= 1'b1; d <= 1'b1; sel <= 2'b10; 
      #10  a <= 1'b1; b <= 1'b1; c <= 1'b0; d <= 1'b1; sel <= 2'b01;
      #10  a <= 1'b0; b <= 1'b0; c <= 1'b1; d <= 1'b0; sel <= 2'b00;
      #10

      $finish;
  end
endmodule