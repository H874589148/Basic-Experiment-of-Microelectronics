`timescale 1ns/100ps

module gcd_behavioral #( parameter WIDTH = 16 )
                       ( input  [WIDTH-1:0] A_in, B_in,
                         output [WIDTH-1:0] Y );

  reg [WIDTH-1:0] A, B, Y, swap;
  integer         done;
  
  always @( A_in or B_in )
  begin

    done = 0;
    A = A_in;
    B = B_in;

    while ( !done )
    begin

      if ( A < B )
      begin
        swap = A;
        A = B;
        B = swap;
      end

      else if ( B != 0 )
        A = A - B;

      else
        done = 1;

    end
    
    Y = A;
  end

endmodule

//-------------------------------------------------------------------------
// GCD Test Harness

module gcd_test;
  parameter WIDTH = 16;

  reg  [WIDTH-1:0] A_in, B_in;
  wire [WIDTH-1:0] Y;

  gcd_behavioral #( .WIDTH(WIDTH) ) 
                  gcd_unit( .A_in(A_in), .B_in(B_in), .Y(Y) );

  initial
  begin

    // Default inputs if cmd line args are not provided

    A_in = 49;
    B_in = 35;

    // Read in cmdline args
    
    $value$plusargs("a-in=%d",A_in);
    $value$plusargs("b-in=%d",B_in);

    // Let the simulation run
    
    #10;

    // Output the results
    
    $display(" a-in    = %d", A_in );
    $display(" b-in    = %d", B_in );
    $display(" gcd-out = %d", Y    );	
    $finish;
    
  end    

endmodule
