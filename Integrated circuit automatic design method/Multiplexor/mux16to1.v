`timescale 1ns/100ps
module mux16to1(
	input [3:0] sel,
	input [3:0] a,
	input [3:0] b,
	input [3:0] c,
	input [3:0] d,
	output out
);

wire [3:0] out4;
mux4to1 mux4_1(a[0],a[0],c[0],d[0],sel[1:0],out4[0]);
mux4to1 mux4_2(a[1],b[1],c[1],d[1],sel[1:0],out4[1]);
mux4to1 mux4_3(a[2],b[2],c[2],d[2],sel[1:0],out4[2]);
mux4to1 mux4_4(a[3],b[3],c[3],d[3],sel[1:0],out4[3]);
mux4to1 mux4_5(out4[0],out4[1],out4[2],out4[3],sel[3:2],out);

endmodule

