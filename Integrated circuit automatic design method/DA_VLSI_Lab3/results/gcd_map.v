/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : L-2016.03-SP5
// Date      : Thu Nov 12 15:32:15 2020
/////////////////////////////////////////////////////////////


module vcMux3_W16 ( in0, in1, in2, sel, out );
  input [15:0] in0;
  input [15:0] in1;
  input [15:0] in2;
  input [1:0] sel;
  output [15:0] out;
  wire   n3, n4, n5, n1, n2;

  AO222X1_RVT U4 ( .A1(in1[9]), .A2(n3), .A3(in2[9]), .A4(n4), .A5(in0[9]), 
        .A6(n5), .Y(out[9]) );
  AO222X1_RVT U5 ( .A1(in1[8]), .A2(n3), .A3(in2[8]), .A4(n4), .A5(in0[8]), 
        .A6(n5), .Y(out[8]) );
  AO222X1_RVT U6 ( .A1(in1[7]), .A2(n3), .A3(in2[7]), .A4(n4), .A5(in0[7]), 
        .A6(n5), .Y(out[7]) );
  AO222X1_RVT U7 ( .A1(in1[6]), .A2(n3), .A3(in2[6]), .A4(n4), .A5(in0[6]), 
        .A6(n5), .Y(out[6]) );
  AO222X1_RVT U8 ( .A1(in1[5]), .A2(n3), .A3(in2[5]), .A4(n4), .A5(in0[5]), 
        .A6(n5), .Y(out[5]) );
  AO222X1_RVT U9 ( .A1(in1[4]), .A2(n3), .A3(in2[4]), .A4(n4), .A5(in0[4]), 
        .A6(n5), .Y(out[4]) );
  AO222X1_RVT U10 ( .A1(in1[3]), .A2(n3), .A3(in2[3]), .A4(n4), .A5(in0[3]), 
        .A6(n5), .Y(out[3]) );
  AO222X1_RVT U11 ( .A1(in1[2]), .A2(n3), .A3(in2[2]), .A4(n4), .A5(in0[2]), 
        .A6(n5), .Y(out[2]) );
  AO222X1_RVT U12 ( .A1(in1[1]), .A2(n3), .A3(in2[1]), .A4(n4), .A5(in0[1]), 
        .A6(n5), .Y(out[1]) );
  AO222X1_RVT U13 ( .A1(in1[15]), .A2(n3), .A3(in2[15]), .A4(n4), .A5(in0[15]), 
        .A6(n5), .Y(out[15]) );
  AO222X1_RVT U14 ( .A1(in1[14]), .A2(n3), .A3(in2[14]), .A4(n4), .A5(in0[14]), 
        .A6(n5), .Y(out[14]) );
  AO222X1_RVT U15 ( .A1(in1[13]), .A2(n3), .A3(in2[13]), .A4(n4), .A5(in0[13]), 
        .A6(n5), .Y(out[13]) );
  AO222X1_RVT U16 ( .A1(in1[12]), .A2(n3), .A3(in2[12]), .A4(n4), .A5(in0[12]), 
        .A6(n5), .Y(out[12]) );
  AO222X1_RVT U17 ( .A1(in1[11]), .A2(n3), .A3(in2[11]), .A4(n4), .A5(in0[11]), 
        .A6(n5), .Y(out[11]) );
  AO222X1_RVT U18 ( .A1(in1[10]), .A2(n3), .A3(in2[10]), .A4(n4), .A5(in0[10]), 
        .A6(n5), .Y(out[10]) );
  AO222X1_RVT U19 ( .A1(in1[0]), .A2(n3), .A3(in2[0]), .A4(n4), .A5(in0[0]), 
        .A6(n5), .Y(out[0]) );
  AND2X2_RVT U2 ( .A1(n1), .A2(n2), .Y(n5) );
  AND2X2_RVT U3 ( .A1(sel[0]), .A2(n2), .Y(n3) );
  AND2X2_RVT U20 ( .A1(sel[1]), .A2(n1), .Y(n4) );
  INVX1_RVT U21 ( .A(sel[0]), .Y(n1) );
  INVX1_RVT U22 ( .A(sel[1]), .Y(n2) );
endmodule


module vcEDFF_pf_W16_0 ( clk, en_p, d_p, q_np );
  input [15:0] d_p;
  output [15:0] q_np;
  input clk, en_p;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n1, n18, n19;

  DFFX1_RVT q_np_reg_15_ ( .D(n17), .CLK(clk), .Q(q_np[15]) );
  DFFX1_RVT q_np_reg_14_ ( .D(n16), .CLK(clk), .Q(q_np[14]) );
  DFFX1_RVT q_np_reg_13_ ( .D(n15), .CLK(clk), .Q(q_np[13]) );
  DFFX1_RVT q_np_reg_12_ ( .D(n14), .CLK(clk), .Q(q_np[12]) );
  DFFX1_RVT q_np_reg_11_ ( .D(n13), .CLK(clk), .Q(q_np[11]) );
  DFFX1_RVT q_np_reg_10_ ( .D(n12), .CLK(clk), .Q(q_np[10]) );
  DFFX1_RVT q_np_reg_9_ ( .D(n11), .CLK(clk), .Q(q_np[9]) );
  DFFX1_RVT q_np_reg_8_ ( .D(n10), .CLK(clk), .Q(q_np[8]) );
  DFFX1_RVT q_np_reg_7_ ( .D(n9), .CLK(clk), .Q(q_np[7]) );
  DFFX1_RVT q_np_reg_6_ ( .D(n8), .CLK(clk), .Q(q_np[6]) );
  DFFX1_RVT q_np_reg_5_ ( .D(n7), .CLK(clk), .Q(q_np[5]) );
  DFFX1_RVT q_np_reg_4_ ( .D(n6), .CLK(clk), .Q(q_np[4]) );
  DFFX1_RVT q_np_reg_3_ ( .D(n5), .CLK(clk), .Q(q_np[3]) );
  DFFX1_RVT q_np_reg_2_ ( .D(n4), .CLK(clk), .Q(q_np[2]) );
  DFFX1_RVT q_np_reg_1_ ( .D(n3), .CLK(clk), .Q(q_np[1]) );
  DFFX1_RVT q_np_reg_0_ ( .D(n2), .CLK(clk), .Q(q_np[0]) );
  AO22X1_RVT U2 ( .A1(q_np[0]), .A2(n19), .A3(n18), .A4(d_p[0]), .Y(n2) );
  AO22X1_RVT U3 ( .A1(q_np[1]), .A2(n19), .A3(d_p[1]), .A4(n18), .Y(n3) );
  AO22X1_RVT U4 ( .A1(q_np[2]), .A2(n19), .A3(d_p[2]), .A4(n18), .Y(n4) );
  AO22X1_RVT U5 ( .A1(q_np[3]), .A2(n19), .A3(d_p[3]), .A4(n18), .Y(n5) );
  AO22X1_RVT U6 ( .A1(q_np[4]), .A2(n19), .A3(d_p[4]), .A4(n18), .Y(n6) );
  AO22X1_RVT U7 ( .A1(q_np[5]), .A2(n19), .A3(d_p[5]), .A4(n18), .Y(n7) );
  AO22X1_RVT U8 ( .A1(q_np[6]), .A2(n19), .A3(d_p[6]), .A4(n18), .Y(n8) );
  AO22X1_RVT U9 ( .A1(q_np[7]), .A2(n19), .A3(d_p[7]), .A4(n18), .Y(n9) );
  AO22X1_RVT U10 ( .A1(q_np[8]), .A2(n19), .A3(d_p[8]), .A4(n18), .Y(n10) );
  AO22X1_RVT U11 ( .A1(q_np[9]), .A2(n19), .A3(d_p[9]), .A4(n18), .Y(n11) );
  AO22X1_RVT U12 ( .A1(q_np[10]), .A2(n19), .A3(d_p[10]), .A4(n18), .Y(n12) );
  AO22X1_RVT U13 ( .A1(q_np[11]), .A2(n19), .A3(d_p[11]), .A4(n18), .Y(n13) );
  AO22X1_RVT U14 ( .A1(q_np[12]), .A2(n19), .A3(d_p[12]), .A4(n18), .Y(n14) );
  AO22X1_RVT U15 ( .A1(q_np[13]), .A2(n19), .A3(d_p[13]), .A4(n18), .Y(n15) );
  AO22X1_RVT U16 ( .A1(q_np[14]), .A2(n19), .A3(d_p[14]), .A4(n18), .Y(n16) );
  AO22X1_RVT U17 ( .A1(q_np[15]), .A2(n19), .A3(d_p[15]), .A4(n18), .Y(n17) );
  INVX4_RVT U18 ( .A(n1), .Y(n18) );
  INVX2_RVT U19 ( .A(n18), .Y(n19) );
  INVX1_RVT U20 ( .A(en_p), .Y(n1) );
endmodule


module vcMux2_W16 ( in0, in1, sel, out );
  input [15:0] in0;
  input [15:0] in1;
  output [15:0] out;
  input sel;
  wire   n1;

  AO22X1_RVT U2 ( .A1(sel), .A2(in1[9]), .A3(in0[9]), .A4(n1), .Y(out[9]) );
  AO22X1_RVT U3 ( .A1(in1[8]), .A2(sel), .A3(in0[8]), .A4(n1), .Y(out[8]) );
  AO22X1_RVT U4 ( .A1(in1[7]), .A2(sel), .A3(in0[7]), .A4(n1), .Y(out[7]) );
  AO22X1_RVT U5 ( .A1(in1[6]), .A2(sel), .A3(in0[6]), .A4(n1), .Y(out[6]) );
  AO22X1_RVT U6 ( .A1(in1[5]), .A2(sel), .A3(in0[5]), .A4(n1), .Y(out[5]) );
  AO22X1_RVT U7 ( .A1(in1[4]), .A2(sel), .A3(in0[4]), .A4(n1), .Y(out[4]) );
  AO22X1_RVT U8 ( .A1(in1[3]), .A2(sel), .A3(in0[3]), .A4(n1), .Y(out[3]) );
  AO22X1_RVT U9 ( .A1(in1[2]), .A2(sel), .A3(in0[2]), .A4(n1), .Y(out[2]) );
  AO22X1_RVT U10 ( .A1(in1[1]), .A2(sel), .A3(in0[1]), .A4(n1), .Y(out[1]) );
  AO22X1_RVT U11 ( .A1(in1[15]), .A2(sel), .A3(in0[15]), .A4(n1), .Y(out[15])
         );
  AO22X1_RVT U12 ( .A1(in1[14]), .A2(sel), .A3(in0[14]), .A4(n1), .Y(out[14])
         );
  AO22X1_RVT U13 ( .A1(in1[13]), .A2(sel), .A3(in0[13]), .A4(n1), .Y(out[13])
         );
  AO22X1_RVT U14 ( .A1(in1[12]), .A2(sel), .A3(in0[12]), .A4(n1), .Y(out[12])
         );
  AO22X1_RVT U15 ( .A1(in1[11]), .A2(sel), .A3(in0[11]), .A4(n1), .Y(out[11])
         );
  AO22X1_RVT U16 ( .A1(in1[10]), .A2(sel), .A3(in0[10]), .A4(n1), .Y(out[10])
         );
  AO22X1_RVT U17 ( .A1(in1[0]), .A2(sel), .A3(in0[0]), .A4(n1), .Y(out[0]) );
  INVX2_RVT U1 ( .A(sel), .Y(n1) );
endmodule


module vcEDFF_pf_W16_1 ( clk, en_p, d_p, q_np );
  input [15:0] d_p;
  output [15:0] q_np;
  input clk, en_p;
  wire   n1, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34;

  DFFX1_RVT q_np_reg_15_ ( .D(n19), .CLK(clk), .Q(q_np[15]) );
  DFFX1_RVT q_np_reg_14_ ( .D(n20), .CLK(clk), .Q(q_np[14]) );
  DFFX1_RVT q_np_reg_13_ ( .D(n21), .CLK(clk), .Q(q_np[13]) );
  DFFX1_RVT q_np_reg_12_ ( .D(n22), .CLK(clk), .Q(q_np[12]) );
  DFFX1_RVT q_np_reg_11_ ( .D(n23), .CLK(clk), .Q(q_np[11]) );
  DFFX1_RVT q_np_reg_10_ ( .D(n24), .CLK(clk), .Q(q_np[10]) );
  DFFX1_RVT q_np_reg_9_ ( .D(n25), .CLK(clk), .Q(q_np[9]) );
  DFFX1_RVT q_np_reg_8_ ( .D(n26), .CLK(clk), .Q(q_np[8]) );
  DFFX1_RVT q_np_reg_7_ ( .D(n27), .CLK(clk), .Q(q_np[7]) );
  DFFX1_RVT q_np_reg_6_ ( .D(n28), .CLK(clk), .Q(q_np[6]) );
  DFFX1_RVT q_np_reg_5_ ( .D(n29), .CLK(clk), .Q(q_np[5]) );
  DFFX1_RVT q_np_reg_4_ ( .D(n30), .CLK(clk), .Q(q_np[4]) );
  DFFX1_RVT q_np_reg_3_ ( .D(n31), .CLK(clk), .Q(q_np[3]) );
  DFFX1_RVT q_np_reg_2_ ( .D(n32), .CLK(clk), .Q(q_np[2]) );
  DFFX1_RVT q_np_reg_1_ ( .D(n33), .CLK(clk), .Q(q_np[1]) );
  DFFX1_RVT q_np_reg_0_ ( .D(n34), .CLK(clk), .Q(q_np[0]) );
  AO22X1_RVT U2 ( .A1(q_np[0]), .A2(n18), .A3(n1), .A4(d_p[0]), .Y(n34) );
  AO22X1_RVT U3 ( .A1(q_np[1]), .A2(n18), .A3(d_p[1]), .A4(n1), .Y(n33) );
  AO22X1_RVT U4 ( .A1(q_np[2]), .A2(n18), .A3(d_p[2]), .A4(n1), .Y(n32) );
  AO22X1_RVT U5 ( .A1(q_np[3]), .A2(n18), .A3(d_p[3]), .A4(n1), .Y(n31) );
  AO22X1_RVT U6 ( .A1(q_np[4]), .A2(n18), .A3(d_p[4]), .A4(n1), .Y(n30) );
  AO22X1_RVT U7 ( .A1(q_np[5]), .A2(n18), .A3(d_p[5]), .A4(n1), .Y(n29) );
  AO22X1_RVT U8 ( .A1(q_np[6]), .A2(n18), .A3(d_p[6]), .A4(n1), .Y(n28) );
  AO22X1_RVT U9 ( .A1(q_np[7]), .A2(n18), .A3(d_p[7]), .A4(n1), .Y(n27) );
  AO22X1_RVT U10 ( .A1(q_np[8]), .A2(n18), .A3(d_p[8]), .A4(n1), .Y(n26) );
  AO22X1_RVT U11 ( .A1(q_np[9]), .A2(n18), .A3(d_p[9]), .A4(n1), .Y(n25) );
  AO22X1_RVT U12 ( .A1(q_np[10]), .A2(n18), .A3(d_p[10]), .A4(n1), .Y(n24) );
  AO22X1_RVT U13 ( .A1(q_np[11]), .A2(n18), .A3(d_p[11]), .A4(n1), .Y(n23) );
  AO22X1_RVT U14 ( .A1(q_np[12]), .A2(n18), .A3(d_p[12]), .A4(n1), .Y(n22) );
  AO22X1_RVT U15 ( .A1(q_np[13]), .A2(n18), .A3(d_p[13]), .A4(n1), .Y(n21) );
  AO22X1_RVT U16 ( .A1(q_np[14]), .A2(n18), .A3(d_p[14]), .A4(n1), .Y(n20) );
  AO22X1_RVT U17 ( .A1(q_np[15]), .A2(n18), .A3(d_p[15]), .A4(n1), .Y(n19) );
  NBUFFX4_RVT U18 ( .A(en_p), .Y(n1) );
  INVX2_RVT U19 ( .A(n1), .Y(n18) );
endmodule


module gcdGCDUnitDpath_W16_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17;
  wire   [15:1] carry;

  FADDX1_RVT U2_15 ( .A(A[15]), .B(n2), .CI(carry[15]), .S(DIFF[15]) );
  FADDX1_RVT U2_14 ( .A(A[14]), .B(n3), .CI(carry[14]), .CO(carry[15]), .S(
        DIFF[14]) );
  FADDX1_RVT U2_13 ( .A(A[13]), .B(n4), .CI(carry[13]), .CO(carry[14]), .S(
        DIFF[13]) );
  FADDX1_RVT U2_12 ( .A(A[12]), .B(n5), .CI(carry[12]), .CO(carry[13]), .S(
        DIFF[12]) );
  FADDX1_RVT U2_11 ( .A(A[11]), .B(n6), .CI(carry[11]), .CO(carry[12]), .S(
        DIFF[11]) );
  FADDX1_RVT U2_10 ( .A(A[10]), .B(n7), .CI(carry[10]), .CO(carry[11]), .S(
        DIFF[10]) );
  FADDX1_RVT U2_9 ( .A(A[9]), .B(n8), .CI(carry[9]), .CO(carry[10]), .S(
        DIFF[9]) );
  FADDX1_RVT U2_8 ( .A(A[8]), .B(n9), .CI(carry[8]), .CO(carry[9]), .S(DIFF[8]) );
  FADDX1_RVT U2_7 ( .A(A[7]), .B(n10), .CI(carry[7]), .CO(carry[8]), .S(
        DIFF[7]) );
  FADDX1_RVT U2_6 ( .A(A[6]), .B(n11), .CI(carry[6]), .CO(carry[7]), .S(
        DIFF[6]) );
  FADDX1_RVT U2_5 ( .A(A[5]), .B(n12), .CI(carry[5]), .CO(carry[6]), .S(
        DIFF[5]) );
  FADDX1_RVT U2_4 ( .A(A[4]), .B(n13), .CI(carry[4]), .CO(carry[5]), .S(
        DIFF[4]) );
  FADDX1_RVT U2_3 ( .A(A[3]), .B(n14), .CI(carry[3]), .CO(carry[4]), .S(
        DIFF[3]) );
  FADDX1_RVT U2_2 ( .A(A[2]), .B(n15), .CI(carry[2]), .CO(carry[3]), .S(
        DIFF[2]) );
  FADDX1_RVT U2_1 ( .A(A[1]), .B(n16), .CI(carry[1]), .CO(carry[2]), .S(
        DIFF[1]) );
  INVX1_RVT U1 ( .A(B[1]), .Y(n16) );
  INVX1_RVT U2 ( .A(A[0]), .Y(n1) );
  INVX1_RVT U3 ( .A(B[2]), .Y(n15) );
  INVX1_RVT U4 ( .A(B[3]), .Y(n14) );
  INVX1_RVT U5 ( .A(B[4]), .Y(n13) );
  INVX1_RVT U6 ( .A(B[5]), .Y(n12) );
  INVX1_RVT U7 ( .A(B[6]), .Y(n11) );
  INVX1_RVT U8 ( .A(B[7]), .Y(n10) );
  INVX1_RVT U9 ( .A(B[8]), .Y(n9) );
  INVX1_RVT U10 ( .A(B[9]), .Y(n8) );
  INVX1_RVT U11 ( .A(B[10]), .Y(n7) );
  INVX1_RVT U12 ( .A(B[11]), .Y(n6) );
  INVX1_RVT U13 ( .A(B[12]), .Y(n5) );
  INVX1_RVT U14 ( .A(B[13]), .Y(n4) );
  INVX1_RVT U15 ( .A(B[14]), .Y(n3) );
  INVX1_RVT U16 ( .A(B[0]), .Y(n17) );
  INVX1_RVT U17 ( .A(B[15]), .Y(n2) );
  XNOR2X1_RVT U18 ( .A1(A[0]), .A2(n17), .Y(DIFF[0]) );
  NAND2X0_RVT U19 ( .A1(n1), .A2(B[0]), .Y(carry[1]) );
endmodule


module gcdGCDUnitDpath_W16 ( clk, operand_A, operand_B, result_data, A_en, 
        B_en, A_sel, B_sel, B_zero, A_lt_B );
  input [15:0] operand_A;
  input [15:0] operand_B;
  output [15:0] result_data;
  input [1:0] A_sel;
  input clk, A_en, B_en, B_sel;
  output B_zero, A_lt_B;
  wire   n4, n5, n6, n7, n1, n2, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66;
  wire   [15:0] B;
  wire   [15:0] sub_out;
  wire   [15:0] A_out;
  wire   [15:0] B_out;

  NOR4X1_RVT U4 ( .A1(B[9]), .A2(B[8]), .A3(B[7]), .A4(B[6]), .Y(n7) );
  NOR4X1_RVT U5 ( .A1(B[5]), .A2(B[4]), .A3(B[3]), .A4(B[2]), .Y(n6) );
  NOR4X1_RVT U6 ( .A1(B[1]), .A2(B[15]), .A3(B[14]), .A4(B[13]), .Y(n5) );
  NOR4X1_RVT U7 ( .A1(B[12]), .A2(B[11]), .A3(B[10]), .A4(B[0]), .Y(n4) );
  AND4X1_RVT U8 ( .A1(n4), .A2(n5), .A3(n6), .A4(n7), .Y(B_zero) );
  vcMux3_W16 A_mux ( .in0(operand_A), .in1(B), .in2(sub_out), .sel(A_sel), 
        .out(A_out) );
  vcEDFF_pf_W16_0 A_pf ( .clk(clk), .en_p(A_en), .d_p(A_out), .q_np(
        result_data) );
  vcMux2_W16 B_mux ( .in0(operand_B), .in1(result_data), .sel(B_sel), .out(
        B_out) );
  vcEDFF_pf_W16_1 B_pf ( .clk(clk), .en_p(B_en), .d_p(B_out), .q_np(B) );
  gcdGCDUnitDpath_W16_DW01_sub_0 sub_136 ( .A(result_data), .B(B), .CI(1'b0), 
        .DIFF(sub_out) );
  INVX1_RVT U1 ( .A(n38), .Y(n66) );
  INVX1_RVT U2 ( .A(n14), .Y(n55) );
  INVX1_RVT U9 ( .A(B[3]), .Y(n54) );
  INVX1_RVT U10 ( .A(B[8]), .Y(n59) );
  INVX1_RVT U11 ( .A(B[12]), .Y(n63) );
  INVX1_RVT U12 ( .A(n41), .Y(n62) );
  OAI22X1_RVT U13 ( .A1(n1), .A2(n2), .A3(n2), .A4(n31), .Y(n37) );
  OAI22X1_RVT U14 ( .A1(B[13]), .A2(n50), .A3(n49), .A4(n25), .Y(n1) );
  AO22X1_RVT U15 ( .A1(result_data[15]), .A2(n65), .A3(n26), .A4(
        result_data[14]), .Y(n2) );
  OAI22X1_RVT U16 ( .A1(n8), .A2(n9), .A3(n9), .A4(n22), .Y(n23) );
  OAI22X1_RVT U17 ( .A1(B[5]), .A2(n46), .A3(n45), .A4(n19), .Y(n8) );
  AO22X1_RVT U18 ( .A1(result_data[7]), .A2(n58), .A3(n21), .A4(result_data[6]), .Y(n9) );
  INVX1_RVT U19 ( .A(B[2]), .Y(n53) );
  INVX1_RVT U20 ( .A(B[7]), .Y(n58) );
  INVX1_RVT U21 ( .A(B[6]), .Y(n57) );
  INVX1_RVT U22 ( .A(B[11]), .Y(n61) );
  INVX1_RVT U23 ( .A(B[15]), .Y(n65) );
  INVX1_RVT U24 ( .A(B[10]), .Y(n60) );
  INVX1_RVT U25 ( .A(B[14]), .Y(n64) );
  INVX1_RVT U26 ( .A(B[1]), .Y(n52) );
  INVX1_RVT U27 ( .A(B[4]), .Y(n56) );
  INVX1_RVT U28 ( .A(result_data[8]), .Y(n47) );
  INVX1_RVT U29 ( .A(result_data[12]), .Y(n49) );
  INVX1_RVT U30 ( .A(result_data[4]), .Y(n45) );
  INVX1_RVT U31 ( .A(result_data[5]), .Y(n46) );
  INVX1_RVT U32 ( .A(result_data[13]), .Y(n50) );
  INVX1_RVT U33 ( .A(result_data[9]), .Y(n48) );
  INVX1_RVT U34 ( .A(B[0]), .Y(n51) );
  OR2X1_RVT U35 ( .A1(n58), .A2(result_data[7]), .Y(n20) );
  OA21X1_RVT U36 ( .A1(n57), .A2(result_data[6]), .A3(n20), .Y(n22) );
  OAI22X1_RVT U37 ( .A1(n51), .A2(result_data[0]), .A3(n52), .A4(
        result_data[1]), .Y(n12) );
  NAND2X0_RVT U38 ( .A1(result_data[1]), .A2(n52), .Y(n11) );
  OR2X1_RVT U39 ( .A1(n54), .A2(result_data[3]), .Y(n13) );
  AND2X1_RVT U40 ( .A1(n13), .A2(n53), .Y(n10) );
  AO22X1_RVT U41 ( .A1(result_data[3]), .A2(n54), .A3(n10), .A4(result_data[2]), .Y(n14) );
  NAND3X0_RVT U42 ( .A1(n12), .A2(n11), .A3(n55), .Y(n17) );
  OA21X1_RVT U43 ( .A1(result_data[2]), .A2(n53), .A3(n13), .Y(n15) );
  NAND2X0_RVT U44 ( .A1(B[5]), .A2(n46), .Y(n18) );
  OA221X1_RVT U45 ( .A1(n15), .A2(n14), .A3(result_data[4]), .A4(n56), .A5(n18), .Y(n16) );
  NAND3X0_RVT U46 ( .A1(n22), .A2(n17), .A3(n16), .Y(n24) );
  NAND2X0_RVT U47 ( .A1(n18), .A2(n56), .Y(n19) );
  AND2X1_RVT U48 ( .A1(n20), .A2(n57), .Y(n21) );
  AND2X1_RVT U49 ( .A1(n24), .A2(n23), .Y(n44) );
  NAND2X0_RVT U50 ( .A1(B[13]), .A2(n50), .Y(n32) );
  NAND2X0_RVT U51 ( .A1(n32), .A2(n63), .Y(n25) );
  OR2X1_RVT U52 ( .A1(n65), .A2(result_data[15]), .Y(n27) );
  AND2X1_RVT U53 ( .A1(n27), .A2(n64), .Y(n26) );
  OA21X1_RVT U54 ( .A1(n64), .A2(result_data[14]), .A3(n27), .Y(n31) );
  OR2X1_RVT U55 ( .A1(n61), .A2(result_data[11]), .Y(n29) );
  AND2X1_RVT U56 ( .A1(n29), .A2(n60), .Y(n28) );
  AOI22X1_RVT U57 ( .A1(result_data[11]), .A2(n61), .A3(n28), .A4(
        result_data[10]), .Y(n35) );
  OA21X1_RVT U58 ( .A1(n60), .A2(result_data[10]), .A3(n29), .Y(n41) );
  NAND2X0_RVT U59 ( .A1(B[9]), .A2(n48), .Y(n39) );
  NAND2X0_RVT U60 ( .A1(n39), .A2(n59), .Y(n30) );
  OA22X1_RVT U61 ( .A1(B[9]), .A2(n48), .A3(n47), .A4(n30), .Y(n34) );
  NAND2X0_RVT U62 ( .A1(B[12]), .A2(n49), .Y(n33) );
  NAND3X0_RVT U63 ( .A1(n33), .A2(n32), .A3(n31), .Y(n38) );
  AO221X1_RVT U64 ( .A1(n35), .A2(n62), .A3(n34), .A4(n35), .A5(n38), .Y(n36)
         );
  AND2X1_RVT U65 ( .A1(n37), .A2(n36), .Y(n43) );
  NAND2X0_RVT U66 ( .A1(B[8]), .A2(n47), .Y(n40) );
  NAND4X0_RVT U67 ( .A1(n41), .A2(n66), .A3(n40), .A4(n39), .Y(n42) );
  AO22X1_RVT U68 ( .A1(n44), .A2(n43), .A3(n43), .A4(n42), .Y(A_lt_B) );
endmodule


module vcRDFF_pf_2_0 ( clk, reset_p, d_p, q_np );
  input [1:0] d_p;
  output [1:0] q_np;
  input clk, reset_p;
  wire   N4, n2;

  DFFX1_RVT q_np_reg_1_ ( .D(N4), .CLK(clk), .Q(q_np[1]) );
  AND2X1_RVT U4 ( .A1(d_p[1]), .A2(n2), .Y(N4) );
  DFFSSRX1_RVT q_np_reg_0_ ( .D(d_p[0]), .SETB(1'b1), .RSTB(n2), .CLK(clk), 
        .Q(q_np[0]) );
  INVX1_RVT U5 ( .A(reset_p), .Y(n2) );
endmodule


module gcdGCDUnitCtrl_W16 ( clk, reset, result_taken, input_available, B_zero, 
        A_lt_B, A_en, B_en, A_sel, B_sel, result_rdy );
  output [1:0] A_sel;
  input clk, reset, result_taken, input_available, B_zero, A_lt_B;
  output A_en, B_en, B_sel, result_rdy;
  wire   load_counter, n7, n10, n11, n12, n13, n14, n15, n16, n17, n18, n1, n3,
         n4, n6, n8, n9;
  wire   [1:0] state_next;
  wire   [1:0] state;
  assign B_sel = A_sel[0];

  DFFARX1_RVT load_counter_reg ( .D(n18), .CLK(clk), .RSTB(n8), .Q(
        load_counter), .QN(n7) );
  AO221X1_RVT U11 ( .A1(n10), .A2(n1), .A3(state[0]), .A4(n9), .A5(A_sel[0]), 
        .Y(state_next[1]) );
  AO221X1_RVT U12 ( .A1(A_lt_B), .A2(n10), .A3(B_zero), .A4(A_sel[1]), .A5(n11), .Y(state_next[0]) );
  AND3X1_RVT U13 ( .A1(state[0]), .A2(n9), .A3(state[1]), .Y(n11) );
  AO21X1_RVT U14 ( .A1(load_counter), .A2(n6), .A3(A_sel[1]), .Y(n10) );
  AND2X1_RVT U15 ( .A1(n12), .A2(state[0]), .Y(result_rdy) );
  NAND2X0_RVT U16 ( .A1(n13), .A2(n7), .Y(n18) );
  NAND3X0_RVT U17 ( .A1(n12), .A2(n6), .A3(input_available), .Y(n13) );
  AND2X1_RVT U18 ( .A1(n14), .A2(n15), .Y(n12) );
  NAND2X0_RVT U19 ( .A1(n16), .A2(n3), .Y(A_en) );
  NAND2X0_RVT U20 ( .A1(n14), .A2(n17), .Y(B_en) );
  NAND3X0_RVT U21 ( .A1(n7), .A2(n4), .A3(input_available), .Y(n17) );
  NAND2X0_RVT U22 ( .A1(state[0]), .A2(n4), .Y(n14) );
  OR3X1_RVT U23 ( .A1(A_lt_B), .A2(B_zero), .A3(n15), .Y(n16) );
  NAND2X0_RVT U24 ( .A1(state[1]), .A2(n6), .Y(n15) );
  vcRDFF_pf_2_0 state_pf ( .clk(clk), .reset_p(reset), .d_p(state_next), 
        .q_np(state) );
  INVX1_RVT U3 ( .A(B_en), .Y(n3) );
  INVX1_RVT U4 ( .A(n15), .Y(A_sel[1]) );
  INVX1_RVT U5 ( .A(state[0]), .Y(n6) );
  INVX1_RVT U6 ( .A(state[1]), .Y(n4) );
  INVX1_RVT U7 ( .A(A_lt_B), .Y(n1) );
  INVX1_RVT U8 ( .A(result_taken), .Y(n9) );
  INVX1_RVT U9 ( .A(reset), .Y(n8) );
  INVX2_RVT U10 ( .A(n14), .Y(A_sel[0]) );
endmodule


module gcd_rtl_top ( operand_A, operand_B, clk, reset, result_taken, 
        input_available, result_data, result_rdy );
  input [15:0] operand_A;
  input [15:0] operand_B;
  output [15:0] result_data;
  input clk, reset, result_taken, input_available;
  output result_rdy;
  wire   A_en, B_en, B_sel, B_zero, A_lt_B;
  wire   [1:0] A_sel;

  gcdGCDUnitDpath_W16 gcd_datapath ( .clk(clk), .operand_A(operand_A), 
        .operand_B(operand_B), .result_data(result_data), .A_en(A_en), .B_en(
        B_en), .A_sel(A_sel), .B_sel(B_sel), .B_zero(B_zero), .A_lt_B(A_lt_B)
         );
  gcdGCDUnitCtrl_W16 gcd_ctrl ( .clk(clk), .reset(reset), .result_taken(
        result_taken), .input_available(input_available), .B_zero(B_zero), 
        .A_lt_B(A_lt_B), .A_en(A_en), .B_en(B_en), .A_sel(A_sel), .B_sel(B_sel), .result_rdy(result_rdy) );
endmodule

