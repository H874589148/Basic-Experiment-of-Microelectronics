`timescale 1ns/10ps

module multiplier(clk,rst,a,b,c);
	input clk;
	input rst;
	input [31:0] a;
	input [31:0] b;
	reg  [31:0] a_reg;
	reg  [31:0] b_reg;
	output reg [63:0] c;

always@(posedge clk)
	begin
		if(rst)
			c=0;
		else
		begin
			a_reg<=a;
			b_reg<=b;
			c=a_reg*b_reg;
		end
	end
	
endmodule
