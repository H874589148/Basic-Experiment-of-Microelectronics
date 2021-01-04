`define TRUE	1'b1
`define FALSE	1'b0


//Delays
`define Y2RDELAY	3	//Yellow to red delay
`define R2GDELAY	2	//Red to Green Delay
`define HW_G2RDELAY	5	//Red to Green Delay
`define CNTRY_G_LAST    10      //Longest time contry road

module sig_control(hwy, cntry, X, clock, clear);

//I/O ports
output [1:0] hwy, cntry; 
			//2 bit output for 3 states of signal
			//GREEN, YELLOW, RED;
reg [1:0] hwy, cntry; 
			//declare output signals are registers

input X; 	
			//if TRUE, indicates that there is car on
		  //the country road, otherwise FALSE 

input clock, clear;

//Status of lights
parameter 	RED    = 2'd0,
	      	YELLOW = 2'd1,
		GREEN  = 2'd2;

//State definition     HWY              CNTRY
parameter S0 = 3'd0,  //GREEN           RED
	  S1 = 3'd1,  //YELLOW          RED
	  S2 = 3'd2,  //RED             RED
	  S3 = 3'd3,  //RED             GREEN
	  S4 = 3'd4;  //RED             YELLOW


//Internal state variables
reg [2:0] state;
reg [2:0] next_state;


//state changes only at positive edge of clock
always @(posedge clock)
if(clear)
	state <= S0;
else
	state <= next_state;

//Compute values of main signal and country signal
always @(state)
begin
        hwy = GREEN; //Default light assignment
        cntry = RED; //Default light assignment

	case(state)
		S0:    ;
		S1: 	hwy = YELLOW;
		S2: 	hwy = RED;
		S3: 	begin
			    hwy = RED;
			    cntry =  GREEN;
			end
		 S4: 	begin
			    hwy =  RED;
			    cntry =  YELLOW;
			end
	endcase
end

  reg en_t = 0;
  wire time_up;
  reg [4:0] delay_time;
					
  posedge_timer timer1( .CLOCK(clock), .CLEAR(clear), .en_t(en_t), .set_num(delay_time), .time_up(time_up) );


//State machine using case statements
  always @( * )
  begin
    case (state)

    S0: 
      if( X ) 
        next_state = S1;
      else
        next_state = S0;  

    S1: 
      if( !time_up ) begin  //delay some positive edges of clock
	delay_time = `Y2RDELAY - 2;
        en_t = 1;
      end
      else if( time_up ) begin
        en_t = 0;
        next_state =  S2; 
      end
      else
        next_state = S1;
					
    S2: 
      if( !time_up ) begin  //delay some positive edges of clock
        delay_time = `R2GDELAY - 2;
        en_t = 1;
      end 
      else if( time_up ) begin
        en_t = 0;
        next_state = S3;
      end
      else 
        next_state = S2;
					
    S3: begin

      if( !en_t ) begin
        en_t = 1;
        delay_time = `CNTRY_G_LAST - 2;
      end
      
      if( time_up | X == 0 ) begin
        next_state = S4;
        en_t = 0;
      end

    end

    S4: 
      if( !time_up ) begin  //delay some positive edges of clock
	delay_time = `Y2RDELAY - 2;
        en_t = 1;
      end
      else if( time_up ) begin
        en_t = 0;
        next_state = S0;
      end
					
    default: 
      next_state =  S0;

    endcase

end

endmodule

	

module posedge_timer (
  input CLOCK,
  input CLEAR,
  input en_t,
  input [4:0] set_num,
  output reg time_up
);

  reg [4:0] num;

  always @( posedge CLOCK ) begin
    if( CLEAR ) begin
      num <= 0; 
      time_up <= 0;
    end
    else begin
      if( en_t ) begin
        if( num == set_num ) begin
          time_up <= 1;
          num <= 0;
        end
        else begin
          num <= num + 1;
          time_up <= 0;
        end
      end
      else begin
        time_up <= 0;
        num <= 0;
      end
    end
  end

endmodule



//Test bench Module
module sig_control_test;

wire [1:0] MAIN_SIG, CNTRY_SIG; 
reg CAR_ON_CNTRY_RD; 	
			//if TRUE, indicates that there is car on
		  //the country road 
reg CLOCK, CLEAR;

//Instantiate signal controller
sig_control SC(MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD, CLOCK, CLEAR);


//Setup monitor
initial
	$monitor($time, " Main Sig = %b Country Sig = %b Car_on_cntry = %b",
											MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD);								
/*
//Setup waves
initial
	$gr_waves(	"CLOCK", CLOCK,
							"CAR", CAR_ON_CNTRY_RD,
							"CLEAR", CLEAR,
							"MAIN", MAIN_SIG,
							"CNTRY", CNTRY_SIG);
*/
//setup clock
initial
begin
		CLOCK = `FALSE;
		forever #5 CLOCK = ~CLOCK;
end

//control clear signal
initial
begin
		CLEAR = `TRUE;
		repeat (5) @(negedge CLOCK);
		CLEAR = `FALSE;
end

//apply stimulus
initial
begin
		CAR_ON_CNTRY_RD = `FALSE;

		repeat (20) @(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
		repeat (10) @(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;

		repeat (20) @(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
		repeat (15) @(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
		
		repeat (20) @(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
		repeat (30) @(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
		
		repeat (10) @(negedge CLOCK); $stop;
end


endmodule
	
