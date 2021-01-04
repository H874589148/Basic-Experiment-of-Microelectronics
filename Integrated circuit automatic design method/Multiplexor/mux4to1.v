`timescale 1ns/100ps

module mux4to1( input  a, b, c, d,
                input [1:0] sel,
                output out );

  wire out, t0, t1;
  assign out = ~( (t0 | sel[0]) & (t1 | ~sel[0]) );
  assign t1  = ~( (sel[1] & d) | (~sel[1] & b) );
  assign t0  = ~( (sel[1] & c) | (~sel[1] & a) );

endmodule 
