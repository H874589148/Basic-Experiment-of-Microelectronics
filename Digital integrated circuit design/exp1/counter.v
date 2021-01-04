module counter #(parameter integer WIDTH=5)(

	input wire clk,
	input wire rst,
	input wire load,
	input wire enab,
	input wire [WIDTH-1:0] cnt_in,
	output reg [WIDTH-1:0] cnt_out
);

always@(posedge clk)
begin
	if(rst)
		cnt_out <= 'b0;
	else if(load)
		cnt_out <= cnt_in;
	else if(enab)
		cnt_out <= cnt_out+1;
	
end


endmodule
