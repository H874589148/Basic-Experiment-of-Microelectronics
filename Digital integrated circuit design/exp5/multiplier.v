module counter(clk,rst,count);

input clk,rst;
output reg [7:0] count;

always@(posedge clk or negedge rst)
	begin
		if(!rst)
			count=0;
		else
			count=count+1;
	end
endmodule

