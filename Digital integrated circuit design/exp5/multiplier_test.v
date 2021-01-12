`timescale 1ns/10ps

module multiplier_test;

reg         clk;
reg         rst;
reg  [31:0] a;
reg  [31:0] b;
wire [63:0] c;


integer i;


multiplier dut (
    .clk    (clk    ),
    .rst    (rst    ),
    .a      (a      ),
    .b      (b      ),
    .c      (c      )
    );

initial begin
    clk = 1'b0;
    rst = 1'b1;

    #12
    rst = 1'b0;

    #12

    @(posedge clk);
    for (i=0; i<100; i=i+1) begin
        a = $random();
        b = $random();
        @(posedge clk);
        @(posedge clk);
        if (c == a*b)
            $display("PASS: a=%4h, b=%4h, c=%8h", a, b, c);
        else
            $display(" \033[4;31;1mFAIL:\033[0m a=%4h, b=%4h, c=%8h", a, b, c);
    end
    $finish;

end

always #5 clk = ~clk;



endmodule
