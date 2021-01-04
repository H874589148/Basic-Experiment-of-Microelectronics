`timescale 1ns/100ps

module gcd_gate_test;

parameter W = 16;
reg input_available = 0;
reg [W-1:0] A_in;
reg [W-1:0] B_in;
reg result_taken = 0;
reg clk = 0;
reg reset = 1;

wire [W-1:0] result_data;
wire result_rdy;

reg [3:0] done_ct = 4'h7;
reg [3:0] seed = 4'h0;

gcd_rtl_top #(16) gcd_gate(
  .operand_A(A_in),   
  .operand_B(B_in),   
  .clk(clk),
  .reset(reset),
  .result_taken(result_taken),
  // Control signals (dpath->ctrl)
  .input_available(input_available),
  .result_data(result_data),  
  .result_rdy(result_rdy)
);


always #10 clk =~clk;


  initial begin
    $set_gate_level_monitoring("on");
    $set_toggle_region(gcd_gate_test.gcd_gate); 
    $toggle_start();
    $vcdpluson(0);
    $dumpall;
    $dumpfile("gcd.vcd");
    A_in = 27; B_in = 15;   // set defaults
    $value$plusargs("a-in=%d", A_in);
    $value$plusargs("b-in=%d", B_in);

    #5 reset = 1;   
    #5 input_available = 1;
    #20 reset = 0;  // strobe reset signal

  end

  always @ (result_rdy) begin
    if(result_rdy) begin
      $toggle_stop();
      $toggle_report("gcd_gate_top.saif",1.0e-10,"gcd_gate_test.gcd_gate");
      #5;
      $display("a-in    = %d", A_in);
      $display("b-in    = %d", B_in);
      $display("gcd-out = %d", result_data);
      $finish; 
    end
  end

endmodule

