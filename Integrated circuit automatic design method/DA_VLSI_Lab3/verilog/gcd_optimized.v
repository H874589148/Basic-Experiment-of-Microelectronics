`timescale 1ns/100ps

`define A_SEL_X   2'bxx
`define A_SEL_IN  2'b00
`define A_SEL_B   2'b01
`define A_SEL_SUB 2'b10

`define B_SEL_X   1'bx
`define B_SEL_IN  1'b0
`define B_SEL_A   1'b1


// a register with enable signal
module vcEDFF_pf #(parameter W = 16) 
	( input clk,
	  input en_p,
	  input  [W-1:0] d_p,
	  output reg [W-1:0] q_np );
	always @(posedge clk)
	begin
		if(en_p)
			q_np <= d_p;
	end
endmodule


// a register with reset signal
module 	vcRDFF_pf #(parameter W = 2, 
                             RS = 2'b00) 
	( input clk,
	  input reset_p,
	  input [W-1:0] d_p,
	  output reg [W-1:0] q_np);
    always @(posedge clk)
	begin
		if(reset_p==1)
			q_np <= {W{1'b0}};
		else
			q_np <= d_p;
	end   
endmodule



// a 3-to-1 multiplexer (selection signal = A_SEL_)
module vcMux3 #(parameter W = 16) 
	( input [W-1:0] in0,
	  input [W-1:0] in1,
	  input [W-1:0] in2,
	  input [1:0] sel,
	  output reg [W-1:0] out);
    always @(*)
	begin
		case(sel)
			`A_SEL_IN: out=in0;
			`A_SEL_B: out=in1;
			`A_SEL_SUB: out=in2;
			default: out={W{1'b0}};
		endcase
	end
endmodule

// a 2-to-1 multiplexer (selection signal = B_SEL_)
module vcMux2 #(parameter W=16) 
	( input [W-1:0] in0,
	  input [W-1:0] in1,
	  input sel,
	  output reg [W-1:0] out);
	always @(*)
	begin
		case(sel)
			`B_SEL_IN: out=in0;
			`B_SEL_A: out=in1;
			default: out={W{1'b0}};
		endcase
	end
endmodule


module gcdGCDUnitDpath #(parameter W = 16)
( input      clk,

  // Data signals
  input  [W-1:0] operand_A,   
  input  [W-1:0] operand_B,   
  output [W-1:0] result_data,  

  // Control signals (ctrl->dpath)
  input          A_en,              
  input          B_en,             
  input    [1:0] A_sel,         
  input          B_sel,         

  // Control signals (dpath->ctrl)
  output         B_zero,            
  output         A_lt_B             
);


	wire [W-1:0] B;
	wire [W-1:0] sub_out;
	wire [W-1:0] A_out;

	vcMux3#(W) A_mux
	( .in0 (operand_A),
	  .in1 (B),
	  .in2 (sub_out),
	  .sel (A_sel),
	  .out (A_out)   );

	wire [W-1:0] A;

	vcEDFF_pf#(W) A_pf
	( .clk  (clk),
	  .en_p (A_en),
	  .d_p  (A_out),
	  .q_np (A)      );


	wire [W-1:0] B_out;

	vcMux2#(W) B_mux
	( .in0 (operand_B),
	  .in1 (A),
	  .sel (B_sel),
	  .out (B_out)    );

	vcEDFF_pf#(W) B_pf
	( .clk  (clk),
	  .en_p (B_en),
	  .d_p  (B_out),
	  .q_np (B)      );
	
	assign B_zero  = (B==0);
	assign A_lt_B  = (A < B);
	assign sub_out = A - B;
	assign result_data = A;

endmodule

module gcdGCDUnitCtrl #(parameter W = 16)
  (
  input		clk,
  input		reset,
  input		result_taken,
  // Control signals (dpath->ctrl)
  input		input_available,
  input		B_zero,            
  input		A_lt_B,             

  // Control signals (ctrl->dpath)
  output reg	A_en,             
  output reg	B_en,             
  output reg [1:0]	A_sel,         
  output reg	B_sel,         
  output reg	result_rdy
);


	localparam LOAD = 2'd0;
	localparam SWAP = 2'd1;
	localparam SUBT = 2'd2;
    localparam DONE = 2'd3;


	reg  [1:0] state_next;
	wire [1:0] state;
	reg  load_counter;
	vcRDFF_pf#(2,LOAD) state_pf
	( .clk     (clk),
	  .reset_p (reset),
	  .d_p     (state_next),
	  .q_np    (state)  );

	always @(posedge reset or posedge clk) begin
		if(reset)
			load_counter <= 0;
		else if(input_available & state==LOAD & !load_counter)
			load_counter <= load_counter + 1;
	end
    
	always @(*)
	begin 
	  //Default control signals                                                                          
	  A_sel    = `A_SEL_X;
	  A_en     = 1'b0;
	  B_sel    = `B_SEL_X;
	  B_en     = 1'b0;
	  //input_available = 1'b0;
	  result_rdy   = 1'b0;
	  case ( state )
		LOAD: begin
			  if(input_available& !load_counter) begin
				A_sel    = `A_SEL_IN;
				A_en     = 1'b1;
				B_sel    = `B_SEL_IN;
				B_en     = 1'b1;
				//input_available = 1'b1;
			  end
		    end
		SWAP: begin
				A_sel = `A_SEL_B;
				A_en     = 1'b1;
				B_sel = `B_SEL_A;
				B_en      = 1'b1;
			end
        SUBT: begin
            if(!B_zero& !A_lt_B) begin
                A_sel = `A_SEL_SUB;
                A_en = 1'b1;
            end 
        end
		DONE: result_rdy = 1'b1;
	  endcase
	end

	always @(*)
	begin
	  // Default is to stay in the same state
	  state_next = state;

	  case ( state )
	    LOAD :begin
			if(!load_counter&input_available) begin
				state_next = LOAD;
			end
				
            else if ( load_counter & A_lt_B )
		        state_next = SWAP;   
            else if( load_counter & (!A_lt_B))
                state_next = SUBT;
        end 
	    SWAP :
		    state_next = SUBT;
        SUBT:begin
            if(A_lt_B)
                state_next = SWAP;
            else if(B_zero)
                state_next = DONE;
            else if(!A_lt_B)
                state_next = SUBT;
        end   
	    DONE :
	      if ( result_taken ) begin
			state_next = LOAD; 
		//	load_counter = 0;   
		  end
		       
	  endcase    
	end
endmodule


module gcd_rtl_top #(parameter W=16)(
  input  [W-1:0] operand_A,   
  input  [W-1:0] operand_B,   
  input		clk,
  input		reset,
  input		result_taken,
  // Control signals (dpath->ctrl)
  input		input_available,
  output [W-1:0] result_data,  
  output        result_rdy
);

  wire A_en, B_en, B_sel, B_zero, A_lt_B;
  wire [1:0] A_sel;
initial begin
		$monitor("time : %t   clock : %b A: %d   B: %d   state: %b   state_next: %b  load_counter: %b  A_lt_B: %b",$time,clk,gcd_datapath.A,
		gcd_datapath.B,gcd_ctrl.state,gcd_ctrl.state_next,gcd_ctrl.load_counter,gcd_ctrl.A_lt_B);
		
		#10000 $finish;
end
 gcdGCDUnitDpath #(16) gcd_datapath( .clk(clk), 
  // Data signals
  .operand_A(operand_A),   
  .operand_B(operand_B),   
  .result_data(result_data),  

  // Control signals (ctrl->dpath)
  .A_en(A_en),              
  .B_en(B_en),             
  .A_sel(A_sel),         
  .B_sel(B_sel),         

  // Control signals (dpath->ctrl)
  .B_zero(B_zero),            
  .A_lt_B(A_lt_B)             
);

gcdGCDUnitCtrl #(16) gcd_ctrl(
  .clk(clk),
  .reset(reset),
  .result_taken(result_taken),
  // Control signals (dpath->ctrl)
  .input_available(input_available),
  .B_zero(B_zero),            
  .A_lt_B(A_lt_B),             

  // Control signals (ctrl->dpath)
  .A_en(A_en),             
  .B_en(B_en),             
  .A_sel(A_sel),         
  .B_sel(B_sel),         
  .result_rdy(result_rdy)
);



          
endmodule




module gcd_rtl_2009_test;

parameter W = 16;
reg input_available = 0;
reg [W-1:0] A_in;
reg [W-1:0] B_in;
reg result_taken = 0;
reg clk = 0;
reg reset = 1;

wire [W-1:0] result_data;
wire result_rdy;

gcd_rtl_top #(16) gcd_rtl(
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
      #5;
      $display("a-in    = %d", A_in);
      $display("b-in    = %d", B_in);
      $display("gcd-out = %d", result_data);
      $finish; 
    end
  end

endmodule