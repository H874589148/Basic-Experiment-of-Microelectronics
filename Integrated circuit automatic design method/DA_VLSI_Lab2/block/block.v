`timescale 1ns/100ps

module block #(parameter WIDTH = 4)(input clk, input [WIDTH-1:0] A_in, output reg [WIDTH-1:0] C_out = 0);reg  [WIDTH-1:0] A_out, B_out;always @( posedge clk )begin  A_out = A_in;  B_out = A_out + 1;  C_out = B_out + 1;endendmodule
