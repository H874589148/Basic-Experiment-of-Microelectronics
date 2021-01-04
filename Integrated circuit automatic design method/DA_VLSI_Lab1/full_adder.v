`timescale 1ns/100ps
module full_adder_4bit(A, B, cout, s);
  input [3:0] A;
  input [3:0] B;
  output     cout;
  output [3:0] s;

  wire c0, c1, c2; 

  FA fa0(A[0],B[0],1'b0, c0, s[0]);
  FA fa1(A[1],B[1],c0, c1, s[1]);
  FA fa2(A[2],B[2],c1, c2, s[2]);
  FA fa3(A[3],B[3],c2, cout, s[3]);
 
endmodule

module FA(A, B, cin, cout, sum);
  input A;
  input B;
  input cin;
  output cout;
  output sum;

  assign sum = A ^ B ^ cin;
  assign cout = (A & B)|(A&cin)|(B&cin);

endmodule
