`timescale 1ns/100ps

module mux16to1_test;

   reg [3:0] sel;
   reg [3:0] a, b, c, d;
   wire out;

  mux16to1 mux16to1_a(.out(out),.a(a),.b(b),.c(c),.d(d),.sel(sel));


  initial begin

      $vcdpluson(0);

      $monitor("%t a = %b b = %b, c=%b, d=%b, sel=%h, out=%b", $time, a, b, c, d, sel, out);
      a <= 4'b0000; b <= 4'b0001; c <= 4'b0011; d <= 4'b0111; sel <= 4'b0100;
      #10  a <= 4'b0000; b <= 4'b0001; c <= 4'b0011; d <= 4'b0111; sel <= 4'b0101;
      #10  a <= 4'b0010; b <= 4'b1001; c <= 4'b1110; d <= 4'b1111; sel <= 4'b1111;
      #10  a <= 4'b0100; b <= 4'b0101; c <= 4'b1101; d <= 4'b0111; sel <= 4'b1001;
      #10  a <= 4'b1000; b <= 4'b0011; c <= 4'b0111; d <= 4'b1000; sel <= 4'b0110;
      #10  a <= 4'b1111; b <= 4'b0000; c <= 4'b1011; d <= 4'b0001; sel <= 4'b1000;
      #10

      $finish;
  end
endmodule