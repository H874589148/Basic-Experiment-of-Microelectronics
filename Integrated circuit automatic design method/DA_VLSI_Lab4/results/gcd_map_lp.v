/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : L-2016.03-SP5
// Date      : Tue Nov 24 17:02:03 2020
/////////////////////////////////////////////////////////////


module gcd_rtl_top ( operand_A, operand_B, clk, reset, result_taken, 
        input_available, result_data, result_rdy );
  input [15:0] operand_A;
  input [15:0] operand_B;
  output [15:0] result_data;
  input clk, reset, result_taken, input_available;
  output result_rdy;
  wire   gcd_ctrl_state_pf_N3, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n137, n138, n139, n140, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n201, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211,
         n212, n213, n214, n215, n216, n217, n218, n219, n220, n221, n222,
         n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, n233,
         n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268;
  wire   [15:0] gcd_datapath_B;
  wire   [1:0] gcd_ctrl_state;

  DFFSSRX1_RVT gcd_ctrl_state_pf_q_np_reg_1_ ( .D(n268), .SETB(1'b1), .RSTB(
        n138), .CLK(clk), .Q(gcd_ctrl_state[1]), .QN(n249) );
  NAND2X0_RVT U140 ( .A1(gcd_datapath_B[11]), .A2(n259), .Y(n137) );
  AOI222X1_RVT U141 ( .A1(n261), .A2(n249), .A3(n261), .A4(result_taken), .A5(
        n249), .A6(n173), .Y(n138) );
  NAND3X0_RVT U142 ( .A1(n137), .A2(n165), .A3(n139), .Y(n146) );
  NAND2X0_RVT U143 ( .A1(n164), .A2(n144), .Y(n139) );
  NOR4X1_RVT U144 ( .A1(gcd_datapath_B[0]), .A2(gcd_datapath_B[14]), .A3(
        gcd_datapath_B[15]), .A4(gcd_datapath_B[12]), .Y(n143) );
  NOR4X1_RVT U145 ( .A1(gcd_datapath_B[13]), .A2(gcd_datapath_B[9]), .A3(
        gcd_datapath_B[8]), .A4(gcd_datapath_B[7]), .Y(n142) );
  NOR4X1_RVT U146 ( .A1(gcd_datapath_B[6]), .A2(gcd_datapath_B[10]), .A3(
        gcd_datapath_B[11]), .A4(gcd_datapath_B[1]), .Y(n141) );
  NOR4X1_RVT U147 ( .A1(gcd_datapath_B[2]), .A2(gcd_datapath_B[3]), .A3(
        gcd_datapath_B[4]), .A4(gcd_datapath_B[5]), .Y(n140) );
  NAND4X0_RVT U148 ( .A1(n143), .A2(n142), .A3(n141), .A4(n140), .Y(n173) );
  INVX0_RVT U150 ( .A(reset), .Y(n268) );
  NAND3X0_RVT U151 ( .A1(input_available), .A2(n249), .A3(n261), .Y(n175) );
  INVX0_RVT U152 ( .A(n175), .Y(n193) );
  AO22X1_RVT U153 ( .A1(gcd_datapath_B[14]), .A2(n250), .A3(gcd_datapath_B[15]), .A4(n262), .Y(n151) );
  NAND2X0_RVT U154 ( .A1(result_data[12]), .A2(n263), .Y(n176) );
  AO222X1_RVT U155 ( .A1(gcd_datapath_B[13]), .A2(n248), .A3(
        gcd_datapath_B[13]), .A4(n176), .A5(n248), .A6(n176), .Y(n150) );
  NAND2X0_RVT U156 ( .A1(gcd_datapath_B[10]), .A2(n258), .Y(n165) );
  INVX0_RVT U157 ( .A(n165), .Y(n157) );
  OR2X1_RVT U158 ( .A1(n258), .A2(gcd_datapath_B[10]), .Y(n164) );
  AND2X1_RVT U159 ( .A1(gcd_datapath_B[0]), .A2(n253), .Y(n195) );
  AO222X1_RVT U160 ( .A1(gcd_datapath_B[1]), .A2(n195), .A3(gcd_datapath_B[1]), 
        .A4(n252), .A5(n195), .A6(n252), .Y(n199) );
  AO222X1_RVT U161 ( .A1(gcd_datapath_B[4]), .A2(n207), .A3(gcd_datapath_B[4]), 
        .A4(n257), .A5(n207), .A6(n257), .Y(n213) );
  AO222X1_RVT U162 ( .A1(gcd_datapath_B[6]), .A2(n218), .A3(gcd_datapath_B[6]), 
        .A4(n245), .A5(n218), .A6(n245), .Y(n223) );
  AO222X1_RVT U163 ( .A1(gcd_datapath_B[7]), .A2(n223), .A3(gcd_datapath_B[7]), 
        .A4(n246), .A5(n223), .A6(n246), .Y(n228) );
  AO222X1_RVT U164 ( .A1(gcd_datapath_B[8]), .A2(n228), .A3(gcd_datapath_B[8]), 
        .A4(n247), .A5(n228), .A6(n247), .Y(n232) );
  AO222X1_RVT U165 ( .A1(gcd_datapath_B[9]), .A2(n232), .A3(gcd_datapath_B[9]), 
        .A4(n254), .A5(n232), .A6(n254), .Y(n144) );
  AO22X1_RVT U166 ( .A1(gcd_datapath_B[12]), .A2(n264), .A3(gcd_datapath_B[13]), .A4(n248), .Y(n145) );
  AO221X1_RVT U167 ( .A1(n146), .A2(gcd_datapath_B[11]), .A3(n146), .A4(n259), 
        .A5(n145), .Y(n149) );
  NAND2X0_RVT U168 ( .A1(result_data[14]), .A2(n260), .Y(n147) );
  AO222X1_RVT U169 ( .A1(gcd_datapath_B[15]), .A2(n262), .A3(
        gcd_datapath_B[15]), .A4(n147), .A5(n262), .A6(n147), .Y(n148) );
  OA221X1_RVT U170 ( .A1(n151), .A2(n150), .A3(n151), .A4(n149), .A5(n148), 
        .Y(n153) );
  NAND3X0_RVT U171 ( .A1(gcd_ctrl_state[0]), .A2(n173), .A3(n249), .Y(n152) );
  OR2X1_RVT U172 ( .A1(n153), .A2(n152), .Y(n240) );
  INVX0_RVT U173 ( .A(n240), .Y(n209) );
  AOI22X1_RVT U174 ( .A1(n193), .A2(operand_A[0]), .A3(n209), .A4(n195), .Y(
        n156) );
  NAND2X0_RVT U175 ( .A1(n152), .A2(n175), .Y(n239) );
  AO221X1_RVT U176 ( .A1(n239), .A2(n240), .A3(n239), .A4(gcd_datapath_B[0]), 
        .A5(n253), .Y(n155) );
  NAND3X0_RVT U177 ( .A1(gcd_ctrl_state[0]), .A2(n153), .A3(n249), .Y(n185) );
  INVX0_RVT U178 ( .A(n185), .Y(n192) );
  NBUFFX2_RVT U179 ( .A(n192), .Y(n237) );
  NAND2X0_RVT U180 ( .A1(n237), .A2(gcd_datapath_B[0]), .Y(n154) );
  NAND3X0_RVT U181 ( .A1(n156), .A2(n155), .A3(n154), .Y(n104) );
  INVX0_RVT U182 ( .A(n239), .Y(n210) );
  AOI22X1_RVT U183 ( .A1(n193), .A2(operand_A[12]), .A3(n210), .A4(
        result_data[12]), .Y(n163) );
  OA21X1_RVT U184 ( .A1(result_data[12]), .A2(n263), .A3(n176), .Y(n160) );
  OA21X1_RVT U185 ( .A1(n157), .A2(n166), .A3(n164), .Y(n238) );
  INVX0_RVT U186 ( .A(n177), .Y(n159) );
  INVX0_RVT U187 ( .A(n160), .Y(n158) );
  OAI221X1_RVT U188 ( .A1(n160), .A2(n159), .A3(n158), .A4(n177), .A5(n209), 
        .Y(n162) );
  NAND2X0_RVT U189 ( .A1(n237), .A2(gcd_datapath_B[12]), .Y(n161) );
  NAND3X0_RVT U190 ( .A1(n163), .A2(n162), .A3(n161), .Y(n105) );
  AOI22X1_RVT U191 ( .A1(n193), .A2(operand_A[10]), .A3(n210), .A4(
        result_data[10]), .Y(n172) );
  NAND2X0_RVT U192 ( .A1(n165), .A2(n164), .Y(n167) );
  INVX0_RVT U193 ( .A(n167), .Y(n169) );
  INVX0_RVT U194 ( .A(n166), .Y(n168) );
  OAI221X1_RVT U195 ( .A1(n169), .A2(n168), .A3(n167), .A4(n166), .A5(n209), 
        .Y(n171) );
  NAND2X0_RVT U196 ( .A1(n237), .A2(gcd_datapath_B[10]), .Y(n170) );
  NAND3X0_RVT U197 ( .A1(n172), .A2(n171), .A3(n170), .Y(n107) );
  AND2X1_RVT U198 ( .A1(gcd_ctrl_state[1]), .A2(n261), .Y(result_rdy) );
  NBUFFX2_RVT U199 ( .A(n193), .Y(n236) );
  OR2X1_RVT U200 ( .A1(n173), .A2(gcd_ctrl_state[1]), .Y(n174) );
  OA221X1_RVT U201 ( .A1(n193), .A2(gcd_ctrl_state[0]), .A3(n236), .A4(n174), 
        .A5(n268), .Y(gcd_ctrl_state_pf_N3) );
  AND2X1_RVT U202 ( .A1(n175), .A2(n185), .Y(n194) );
  AO222X1_RVT U203 ( .A1(result_data[15]), .A2(n237), .A3(n193), .A4(
        operand_B[15]), .A5(n194), .A6(gcd_datapath_B[15]), .Y(n135) );
  OA221X1_RVT U204 ( .A1(n177), .A2(gcd_datapath_B[12]), .A3(n177), .A4(n264), 
        .A5(n176), .Y(n188) );
  AO222X1_RVT U205 ( .A1(gcd_datapath_B[14]), .A2(n181), .A3(
        gcd_datapath_B[14]), .A4(n250), .A5(n181), .A6(n250), .Y(n178) );
  OR3X1_RVT U206 ( .A1(n178), .A2(gcd_datapath_B[15]), .A3(n240), .Y(n179) );
  NAND2X0_RVT U207 ( .A1(n239), .A2(n179), .Y(n180) );
  AO222X1_RVT U208 ( .A1(n180), .A2(result_data[15]), .A3(n193), .A4(
        operand_A[15]), .A5(gcd_datapath_B[15]), .A6(n192), .Y(n134) );
  AO222X1_RVT U209 ( .A1(gcd_datapath_B[14]), .A2(n194), .A3(result_data[14]), 
        .A4(n192), .A5(n236), .A6(operand_B[14]), .Y(n133) );
  AOI22X1_RVT U210 ( .A1(n193), .A2(operand_A[14]), .A3(n210), .A4(
        result_data[14]), .Y(n187) );
  INVX0_RVT U211 ( .A(n181), .Y(n182) );
  AO22X1_RVT U212 ( .A1(result_data[14]), .A2(n182), .A3(n250), .A4(n181), .Y(
        n183) );
  HADDX1_RVT U213 ( .A0(n260), .B0(n183), .SO(n184) );
  OA22X1_RVT U214 ( .A1(n185), .A2(n260), .A3(n240), .A4(n184), .Y(n186) );
  NAND2X0_RVT U215 ( .A1(n187), .A2(n186), .Y(n132) );
  AOI22X1_RVT U216 ( .A1(gcd_datapath_B[13]), .A2(n237), .A3(n236), .A4(
        operand_A[13]), .Y(n191) );
  FADDX1_RVT U217 ( .A(gcd_datapath_B[13]), .B(n248), .CI(n188), .CO(n181), 
        .S(n189) );
  OA22X1_RVT U218 ( .A1(n189), .A2(n240), .A3(n239), .A4(n248), .Y(n190) );
  NAND2X0_RVT U219 ( .A1(n191), .A2(n190), .Y(n131) );
  AO222X1_RVT U220 ( .A1(gcd_datapath_B[1]), .A2(n194), .A3(n237), .A4(
        result_data[1]), .A5(operand_B[1]), .A6(n236), .Y(n130) );
  AO222X1_RVT U221 ( .A1(gcd_datapath_B[2]), .A2(n194), .A3(n192), .A4(
        result_data[2]), .A5(operand_B[2]), .A6(n193), .Y(n129) );
  AO222X1_RVT U222 ( .A1(gcd_datapath_B[3]), .A2(n194), .A3(n192), .A4(
        result_data[3]), .A5(operand_B[3]), .A6(n193), .Y(n128) );
  AO222X1_RVT U223 ( .A1(gcd_datapath_B[4]), .A2(n194), .A3(n237), .A4(
        result_data[4]), .A5(operand_B[4]), .A6(n236), .Y(n127) );
  AO222X1_RVT U224 ( .A1(gcd_datapath_B[5]), .A2(n194), .A3(n237), .A4(
        result_data[5]), .A5(operand_B[5]), .A6(n193), .Y(n126) );
  AO222X1_RVT U225 ( .A1(gcd_datapath_B[6]), .A2(n194), .A3(result_data[6]), 
        .A4(n192), .A5(n236), .A6(operand_B[6]), .Y(n125) );
  AO222X1_RVT U226 ( .A1(gcd_datapath_B[7]), .A2(n194), .A3(result_data[7]), 
        .A4(n192), .A5(n193), .A6(operand_B[7]), .Y(n124) );
  AO222X1_RVT U227 ( .A1(gcd_datapath_B[8]), .A2(n194), .A3(result_data[8]), 
        .A4(n192), .A5(n236), .A6(operand_B[8]), .Y(n123) );
  AO222X1_RVT U228 ( .A1(gcd_datapath_B[9]), .A2(n194), .A3(result_data[9]), 
        .A4(n192), .A5(n193), .A6(operand_B[9]), .Y(n122) );
  AO222X1_RVT U229 ( .A1(gcd_datapath_B[10]), .A2(n194), .A3(result_data[10]), 
        .A4(n192), .A5(n193), .A6(operand_B[10]), .Y(n121) );
  AO222X1_RVT U230 ( .A1(gcd_datapath_B[11]), .A2(n194), .A3(result_data[11]), 
        .A4(n237), .A5(n193), .A6(operand_B[11]), .Y(n120) );
  AO222X1_RVT U231 ( .A1(gcd_datapath_B[12]), .A2(n194), .A3(result_data[12]), 
        .A4(n192), .A5(n236), .A6(operand_B[12]), .Y(n119) );
  AO222X1_RVT U232 ( .A1(gcd_datapath_B[13]), .A2(n194), .A3(result_data[13]), 
        .A4(n237), .A5(n193), .A6(operand_B[13]), .Y(n118) );
  AO222X1_RVT U233 ( .A1(gcd_datapath_B[0]), .A2(n194), .A3(n237), .A4(
        result_data[0]), .A5(n193), .A6(operand_B[0]), .Y(n117) );
  AO22X1_RVT U234 ( .A1(gcd_datapath_B[1]), .A2(n237), .A3(n236), .A4(
        operand_A[1]), .Y(n198) );
  FADDX1_RVT U235 ( .A(gcd_datapath_B[1]), .B(n195), .CI(result_data[1]), .S(
        n196) );
  AO22X1_RVT U236 ( .A1(n210), .A2(result_data[1]), .A3(n209), .A4(n196), .Y(
        n197) );
  OR2X1_RVT U237 ( .A1(n198), .A2(n197), .Y(n116) );
  AOI22X1_RVT U238 ( .A1(gcd_datapath_B[2]), .A2(n237), .A3(n236), .A4(
        operand_A[2]), .Y(n202) );
  FADDX1_RVT U239 ( .A(gcd_datapath_B[2]), .B(n251), .CI(n199), .CO(n203), .S(
        n200) );
  OA22X1_RVT U240 ( .A1(n200), .A2(n240), .A3(n239), .A4(n251), .Y(n201) );
  NAND2X0_RVT U241 ( .A1(n202), .A2(n201), .Y(n115) );
  AOI22X1_RVT U242 ( .A1(gcd_datapath_B[3]), .A2(n237), .A3(n236), .A4(
        operand_A[3]), .Y(n206) );
  FADDX1_RVT U243 ( .A(gcd_datapath_B[3]), .B(n255), .CI(n203), .CO(n207), .S(
        n204) );
  OA22X1_RVT U244 ( .A1(n204), .A2(n240), .A3(n239), .A4(n255), .Y(n205) );
  NAND2X0_RVT U245 ( .A1(n206), .A2(n205), .Y(n114) );
  AO22X1_RVT U246 ( .A1(gcd_datapath_B[4]), .A2(n237), .A3(n236), .A4(
        operand_A[4]), .Y(n212) );
  FADDX1_RVT U247 ( .A(gcd_datapath_B[4]), .B(result_data[4]), .CI(n207), .S(
        n208) );
  AO22X1_RVT U248 ( .A1(n210), .A2(result_data[4]), .A3(n209), .A4(n208), .Y(
        n211) );
  OR2X1_RVT U249 ( .A1(n212), .A2(n211), .Y(n113) );
  AOI22X1_RVT U250 ( .A1(gcd_datapath_B[5]), .A2(n237), .A3(n236), .A4(
        operand_A[5]), .Y(n216) );
  FADDX1_RVT U251 ( .A(gcd_datapath_B[5]), .B(n256), .CI(n213), .CO(n218), .S(
        n214) );
  OA22X1_RVT U252 ( .A1(n214), .A2(n240), .A3(n239), .A4(n256), .Y(n215) );
  NAND2X0_RVT U253 ( .A1(n216), .A2(n215), .Y(n112) );
  AOI22X1_RVT U254 ( .A1(gcd_datapath_B[6]), .A2(n237), .A3(n236), .A4(
        operand_A[6]), .Y(n221) );
  AO22X1_RVT U255 ( .A1(gcd_datapath_B[6]), .A2(result_data[6]), .A3(n267), 
        .A4(n245), .Y(n217) );
  HADDX1_RVT U256 ( .A0(n218), .B0(n217), .SO(n219) );
  OA22X1_RVT U257 ( .A1(n239), .A2(n245), .A3(n240), .A4(n219), .Y(n220) );
  NAND2X0_RVT U258 ( .A1(n221), .A2(n220), .Y(n111) );
  AOI22X1_RVT U259 ( .A1(gcd_datapath_B[7]), .A2(n237), .A3(n236), .A4(
        operand_A[7]), .Y(n226) );
  AO22X1_RVT U260 ( .A1(gcd_datapath_B[7]), .A2(result_data[7]), .A3(n265), 
        .A4(n246), .Y(n222) );
  HADDX1_RVT U261 ( .A0(n223), .B0(n222), .SO(n224) );
  OA22X1_RVT U262 ( .A1(n239), .A2(n246), .A3(n240), .A4(n224), .Y(n225) );
  NAND2X0_RVT U263 ( .A1(n226), .A2(n225), .Y(n110) );
  AOI22X1_RVT U264 ( .A1(gcd_datapath_B[8]), .A2(n237), .A3(n236), .A4(
        operand_A[8]), .Y(n231) );
  AO22X1_RVT U265 ( .A1(gcd_datapath_B[8]), .A2(result_data[8]), .A3(n266), 
        .A4(n247), .Y(n227) );
  HADDX1_RVT U266 ( .A0(n228), .B0(n227), .SO(n229) );
  OA22X1_RVT U267 ( .A1(n239), .A2(n247), .A3(n240), .A4(n229), .Y(n230) );
  NAND2X0_RVT U268 ( .A1(n231), .A2(n230), .Y(n109) );
  AOI22X1_RVT U269 ( .A1(gcd_datapath_B[9]), .A2(n237), .A3(n236), .A4(
        operand_A[9]), .Y(n235) );
  FADDX1_RVT U270 ( .A(gcd_datapath_B[9]), .B(n254), .CI(n232), .CO(n166), .S(
        n233) );
  OA22X1_RVT U271 ( .A1(n233), .A2(n240), .A3(n239), .A4(n254), .Y(n234) );
  NAND2X0_RVT U272 ( .A1(n235), .A2(n234), .Y(n108) );
  AOI22X1_RVT U273 ( .A1(gcd_datapath_B[11]), .A2(n237), .A3(n236), .A4(
        operand_A[11]), .Y(n243) );
  FADDX1_RVT U274 ( .A(gcd_datapath_B[11]), .B(n259), .CI(n238), .CO(n177), 
        .S(n241) );
  OA22X1_RVT U275 ( .A1(n241), .A2(n240), .A3(n239), .A4(n259), .Y(n242) );
  NAND2X0_RVT U276 ( .A1(n243), .A2(n242), .Y(n106) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_10_ ( .D(n121), .SETB(1'b1), .RSTB(
        1'b1), .CLK(clk), .Q(gcd_datapath_B[10]) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_9_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n122), .CLK(clk), .Q(gcd_datapath_B[9]) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_3_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n128), .CLK(clk), .Q(gcd_datapath_B[3]) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_2_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n129), .CLK(clk), .Q(gcd_datapath_B[2]) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_5_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n126), .CLK(clk), .Q(gcd_datapath_B[5]) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_4_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n127), .CLK(clk), .Q(gcd_datapath_B[4]) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_1_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n130), .CLK(clk), .Q(gcd_datapath_B[1]) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_0_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n117), .CLK(clk), .Q(gcd_datapath_B[0]) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_13_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n118), .CLK(clk), .Q(gcd_datapath_B[13]) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_11_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n120), .CLK(clk), .Q(gcd_datapath_B[11]) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_15_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n135), .CLK(clk), .Q(gcd_datapath_B[15]) );
  DFFSSRX1_RVT gcd_ctrl_state_pf_q_np_reg_0_ ( .D(gcd_ctrl_state_pf_N3), 
        .SETB(1'b1), .RSTB(1'b1), .CLK(clk), .Q(gcd_ctrl_state[0]), .QN(n261)
         );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_14_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n133), .CLK(clk), .Q(gcd_datapath_B[14]), .QN(n260) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_12_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n119), .CLK(clk), .Q(gcd_datapath_B[12]), .QN(n263) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_8_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n123), .CLK(clk), .Q(gcd_datapath_B[8]), .QN(n266) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_6_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n125), .CLK(clk), .Q(gcd_datapath_B[6]), .QN(n267) );
  DFFSSRX1_RVT gcd_datapath_B_pf_q_np_reg_7_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n124), .CLK(clk), .Q(gcd_datapath_B[7]), .QN(n265) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_12_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n105), .CLK(clk), .Q(result_data[12]), .QN(n264) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_10_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n107), .CLK(clk), .Q(result_data[10]), .QN(n258) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_0_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n104), .CLK(clk), .Q(result_data[0]), .QN(n253) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_14_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n132), .CLK(clk), .Q(result_data[14]), .QN(n250) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_13_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n131), .CLK(clk), .Q(result_data[13]), .QN(n248) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_11_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n106), .CLK(clk), .Q(result_data[11]), .QN(n259) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_9_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n108), .CLK(clk), .Q(result_data[9]), .QN(n254) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_5_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n112), .CLK(clk), .Q(result_data[5]), .QN(n256) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_3_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n114), .CLK(clk), .Q(result_data[3]), .QN(n255) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_2_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n115), .CLK(clk), .Q(result_data[2]), .QN(n251) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_4_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n113), .CLK(clk), .Q(result_data[4]), .QN(n257) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_1_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n116), .CLK(clk), .Q(result_data[1]), .QN(n252) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_8_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n109), .CLK(clk), .Q(result_data[8]), .QN(n247) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_7_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n110), .CLK(clk), .Q(result_data[7]), .QN(n246) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_6_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n111), .CLK(clk), .Q(result_data[6]), .QN(n245) );
  DFFSSRX1_RVT gcd_datapath_A_pf_q_np_reg_15_ ( .D(1'b0), .SETB(1'b0), .RSTB(
        n134), .CLK(clk), .Q(result_data[15]), .QN(n262) );
endmodule

