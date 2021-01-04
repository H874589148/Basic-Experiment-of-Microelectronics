`define ADD 4'b0010
`define SUB 4'b0110
`define AND 4'b0000
`define OR  4'b0001
`define SLT 4'b0111
`define R_FORMAT 6'b000000
`define LW  6'b100011
`define SW  6'b101011
`define BEG 6'b000100
`timescale 1ns/1ps




///////////////////////////////////////////////ALU
module alu(alu_ctl,op_1,op_2,result,zero_flag);

input [3:0] alu_ctl;
input [31:0] op_1,op_2;
output reg[31:0] result;
output zero_flag;

always @(*)
begin
  casez(alu_ctl)
    `ADD: result = op_1 + op_2;
    `SUB: result = op_1 - op_2;
    `AND: result = op_1 & op_2;
    `OR:  result = op_1 | op_2;
    `SLT: result = op_1 < op_2;
    default: result = 0;
  endcase
end

assign zero_flag = op_1 == op_2;

endmodule
///////////////////////////////////////////////ALU_TEST
/*module alu_test;

reg [3:0] alu_ctl;
reg [31:0] op_1,op_2;
wire [31:0] result;
wire zero_flag;

alu alu_1(.alu_ctl(alu_ctl),.op_1(op_1),.op_2(op_2),.result(result),.zero_flag(zero_flag));

initial begin

  $vcdpluson(0);
  alu_ctl <= 32'h00000000;
  op_1 <= 32'h00000005; op_2 <= 32'h00000003;
  #10 alu_ctl <= `ADD;
  #10 alu_ctl <= `SUB;
  #10 alu_ctl <= `AND;
  #10 alu_ctl <= `OR;
  #10 alu_ctl <= `SLT;
  #10 alu_ctl <=`SUB; op_1 <= 32'h00000003; op_2 <= 32'h00000003;
  #10 
  $finish;
end

endmodule*/





//////////////////////////////////////////////ADDER
module adder(op_1,op_2,result);

input [31:0] op_1,op_2;
output [31:0] result;

assign result = op_1 + op_2;

endmodule
////////////////////////////////////////////////adder_test
/*module adder_test;

reg [31:0] op_1,op_2;
wire [31:0] result;

adder adder_1(.op_1(op_1),.op_2(op_2),.result(result));

initial begin

  $vcdpluson(0);
  op_1 <= 32'h0005; op_2 <= 32'h0003;
  #10 
  $finish;
end

endmodule*/




//////////////////////////////////////////////ALU_CONTROL
module alu_control(alu_op,func_code,alu_ctl);

input [1:0] alu_op;
input [5:0] func_code;
output reg [3:0] alu_ctl;

always @(*)
begin
  if(alu_op == 2'b00)
    alu_ctl = 4'b0010;
  else if(alu_op == 2'b01)
    alu_ctl = 4'b0110;
  else
    casez(func_code)
      6'b100000: alu_ctl = 4'b0010;
      6'b100010: alu_ctl = 4'b0110;
      6'b100100: alu_ctl = 4'b0000;
      6'b100101: alu_ctl = 4'b0001;
      6'b101010: alu_ctl = 4'b0111;
      default:   alu_ctl = 0;
    endcase
end

endmodule
///////////////////////////////////////////////ALU_CONTROL_test
/*module alu_control_test;

reg [1:0] alu_op;
reg [5:0] func_code;
wire [3:0] alu_ctl;

alu_control alu_control_1(.alu_op(alu_op),.func_code(func_code),.alu_ctl(alu_ctl));

initial begin

 $vcdpluson(0);
 alu_op <= 2'b00;func_code <= 6'b000000;
 #10 alu_op <= 2'b01; 
 #10 alu_op <= 2'b10;func_code <= 6'b100000;
 #10 func_code <= 6'b100010;
 #10 func_code <= 6'b100100;
 #10 func_code <= 6'b100101;
 #10 func_code <= 6'b101010;
 #10
 $finish;
end

endmodule*/





/////////////////////////////////////////////MUX_2
module mux_2 #(parameter WIDTH = 1)
(input [WIDTH-1:0] in_1,in_2,
 input sel,
 output reg[WIDTH-1:0] out);

always @(*)
begin
  casez(sel)
    1'b0: out = in_1;
    1'b1: out = in_2;
    default: out = 0;
  endcase
end

endmodule
/////////////////////////////////////////////MUX_2_test
/*module mux_2_test;


reg [31:0] in_1,in_2;
reg sel;
wire [31:0] out;

mux_2 mux_2_1(.in_1(in_1),.in_2(in_2),.sel(sel),.out(out));
initial begin

  $vcdpluson(0);
  sel <= 1'b0; in_1 <= 16'h0005; in_2 <= 16'h0003;
  #10 sel <= 1'b1;
  #10
  $finish;
end

endmodule*/





/////////////////////////////////////////////MUX_3
module mux_3#(parameter WIDTH = 1)
(input [WIDTH-1:0] in_1,in_2,in_3,
 input [1:0] sel,
 output reg[WIDTH-1:0] out);


always @(*)
begin
  casez(sel)
    2'b00: out = in_1;
    2'b01: out = in_2;
    2'b10: out = in_3;
    default: out = 0;
  endcase
end

endmodule
/////////////////////////////////////////////MUX_3_test
/*module mux_3_test;


reg [31:0] in_1,in_2,in_3;
reg [1:0] sel;
wire [31:0] out;

mux_3 mux_3_1(.in_1(in_1),.in_2(in_2),.in_3(in_3),.sel(sel),.out(out));
initial begin

  $vcdpluson(0);
  sel <= 2'b00; in_1 <= 32'h00000001; in_2 <= 32'h00000002; in_3 <= 32'h00000003;
  #10 sel <= 2'b01;
  #10 sel <= 2'b10;
  #10
  $finish;
end

endmodule*/




/////////////////////////////////////////////SHIFT_LEFT_2
module shift_left_2(in,out);

input [31:0] in;
output [31:0] out;

assign out = in + in + in + in;

endmodule
//////////////////////////////////////////////////////////////////////////SHIFT_LEFT_2_test
/*module shift_left_2_test;


reg [31:0] in;
wire [31:0] out;
shift_left_2 shift_left_2_1(.in(in),.out(out));
initial begin

  $vcdpluson(0);
  in <= 32'h00000005; 
  #10 
  $finish;
end

endmodule*/





/////////////////////////////////////////////CONTROL
module control(opcode,ctl_signal);

input [5:0] opcode;
output reg [8:0] ctl_signal;

always @(*)
begin
  casez(opcode)
    `R_FORMAT: ctl_signal = 9'b110001100;
    `LW:       ctl_signal = 9'b100100001;
    `SW:       ctl_signal = 9'b000010001;
    `BEG:      ctl_signal = 9'b001000010;
     default:  ctl_signal = 9'b000000000;
  endcase
end
endmodule
////////////////////////////////////////////////////////////////////////////////CONTROL_test
/*module control_test;

reg [5:0] opcode;
wire [8:0] ctl_signal;
control control_1(.opcode(opcode),.ctl_signal(ctl_signal));

initial begin

  $vcdpluson(0);
  #10 opcode <= `R_FORMAT;
  #10 opcode <= `LW;
  #10 opcode <= `SW;
  #10 opcode <= `BEG;
  #10
  $finish;
end

endmodule*/




/////////////////////////////////////////////SIGN-EXTEND
module sign_extend(in,out);

input [15:0] in;
output reg [31:0] out;

always @(*)
begin
  casez(in[15])
    1'b0: out[31:0] = {16'h0000,in[15:0]};
    1'b1: out[31:0] = {16'hffff,in[15:0]};
    default: out[31:0] = 0;
  endcase
end

endmodule
//////////////////////////////////////////////////////////////////////////////SIGN-EXTEND_test
/*module sign_extend_test;

reg [15:0] in;
wire [31:0] out;
sign_extend sign_extend_1(.in(in),.out(out));

initial begin

  $vcdpluson(0);
  in <= 16'h0000;  
  #10 in <= 16'h0001;
  #10 in <= 16'h8001;
  #10
  $finish;
end

endmodule*/




/////////////////////////////////////////////BRANCH
module branch(zero_flag,branch,pcsrc);

input zero_flag,branch;
output pcsrc;

assign pcsrc = zero_flag & branch;

endmodule
/////////////////////////////////////////////////////////////////////////////////BRANCH_test
/*module branch_test;

reg zero_flag,branch;
wire pcsrc;

branch branch_1(.zero_flag(zero_flag),.branch(branch),.pcsrc(pcsrc));
initial begin

  $vcdpluson(0);
  zero_flag <= 1'b0;  branch <= 1'b0; 
  #10 zero_flag <= 1'b0;  branch <= 1'b1;
  #10 zero_flag <= 1'b1;  branch <= 1'b0;
  #10 zero_flag <= 1'b1;  branch <= 1'b1; 
  #10 
  $finish;
end

endmodule*/



/////////////////////////////////////////////REGISTER_FILES
module register_files(clk,reset,raddr_0,raddr_1,regwrite,waddr,wdata,rdata_0,rdata_1,result_addr,result);

input clk,reset,regwrite;
input [4:0] raddr_0,raddr_1,waddr,result_addr;
input [31:0] wdata;
output [31:0] rdata_0,rdata_1;
output [31:0] result;

reg[31:0] registers[31:0];


assign rdata_0 = ( raddr_0 == 0 )? 32'h00000000 : registers[raddr_0];
assign rdata_1 = ( raddr_1 == 0 )? 32'h00000000 : registers[raddr_1];
assign result = (result_addr == 0)? 32'h00000000:registers[result_addr];

always @( posedge clk )
  if(reset)
    begin
      registers[0] <= 5'b00000;
      registers[1] <= 5'b00001;
      registers[2] <= 5'b00010;
      registers[3] <= 5'b00011;
      registers[4] <= 5'b00100;
      registers[5] <= 5'b00101;
      registers[6] <= 5'b00110;
      registers[7] <= 5'b00111;
      registers[8] <= 5'b01000;
      registers[9] <= 5'b01001;
      registers[10] <= 5'b01010;
      registers[11] <= 5'b01011;
      registers[12] <= 5'b01100;
      registers[13] <= 5'b01101;
      registers[14] <= 5'b01110;
      registers[15] <= 5'b01111;
      registers[16] <= 5'b10000;
      registers[17] <= 5'b10001;
      registers[18] <= 5'b10010;
      registers[19] <= 5'b10011;
      registers[20] <= 5'b10100;
      registers[21] <= 5'b10101;
      registers[22] <= 5'b10110;
      registers[23] <= 5'b10111;
      registers[24] <= 5'b11000;
      registers[25] <= 5'b11001;
      registers[26] <= 5'b11010;
      registers[27] <= 5'b11011;
      registers[28] <= 5'b11100;
      registers[29] <= 5'b11101;
      registers[30] <= 5'b11110;
      registers[31] <= 5'b11111;
    end  
  else 
    if( regwrite & (waddr != 5'b0) )
      registers[waddr] <= wdata;
endmodule
///////////////////////////////////////////////////////////////////////////////REGISTER_FILES_test
/*module register_files_test;


reg clk = 1,reset,regwrite;
reg [4:0] raddr_0,raddr_1,waddr,result_addr;
reg [31:0] wdata;
wire [31:0] rdata_0,rdata_1,result;

always #5 clk = ~clk;

register_files register_files_1(.clk(clk),.reset(reset),.raddr_0(raddr_0),.raddr_1(raddr_1),.result_addr(result_addr),.regwrite(regwrite),.waddr(waddr),.wdata(wdata),.rdata_0(rdata_0),.rdata_1(rdata_1),.result(result));

initial begin

  $vcdpluson(0);
  raddr_0 <= 5'b00000;
  raddr_1 <= 5'b00000;
  result_addr <= 5'b00000;
  reset <= 1'b1;
  regwrite <= 1'b1;
  waddr <= 5'b00000;
  wdata <= 32'h00000000;
  #10 reset <= 1'b0;
  #10 waddr <= 5'b00001; wdata <= 32'h00000001;
  #10 waddr <= 5'b00010; wdata <= 32'h00000002;
  #10 waddr <= 5'b00011; wdata <= 32'h00000003;
  #10 waddr <= 5'b00100; wdata <= 32'h00000004;
  #10 waddr <= 5'b00101; wdata <= 32'h00000005;
  #10 waddr <= 5'b00110; wdata <= 32'h00000006;
  #10 waddr <= 5'b00111; wdata <= 32'h00000007;
  #10 waddr <= 5'b01000; wdata <= 32'h00000008;
  #10 waddr <= 5'b01001; wdata <= 32'h00000009;
  #10 waddr <= 5'b01010; wdata <= 32'h0000000a;
  #10 waddr <= 5'b01011; wdata <= 32'h0000000b;
  #10 waddr <= 5'b01100; wdata <= 32'h0000000c;
  #10 waddr <= 5'b01101; wdata <= 32'h0000000d;
  #10 waddr <= 5'b01110; wdata <= 32'h0000000e;
  #10 waddr <= 5'b01111; wdata <= 32'h0000000f;
  #10 waddr <= 5'b10000; wdata <= 32'h00000010;
  #10 waddr <= 5'b10001; wdata <= 32'h00000011;
  #10 waddr <= 5'b10010; wdata <= 32'h00000012;
  #10 waddr <= 5'b10011; wdata <= 32'h00000013;
  #10 waddr <= 5'b10100; wdata <= 32'h00000014;
  #10 waddr <= 5'b10101; wdata <= 32'h00000015;
  #10 waddr <= 5'b10110; wdata <= 32'h00000016;
  #10 waddr <= 5'b10111; wdata <= 32'h00000017;
  #10 waddr <= 5'b11000; wdata <= 32'h00000018;
  #10 waddr <= 5'b11001; wdata <= 32'h00000019;
  #10 waddr <= 5'b11010; wdata <= 32'h0000001a;
  #10 waddr <= 5'b11011; wdata <= 32'h0000001b;
  #10 waddr <= 5'b11100; wdata <= 32'h0000001c;
  #10 waddr <= 5'b11101; wdata <= 32'h0000001d;
  #10 waddr <= 5'b11110; wdata <= 32'h0000001e;
  #10 waddr <= 5'b11111; wdata <= 32'h0000001f;
  #10 raddr_0 <= 5'b00000; raddr_1 <= 5'b00001;
  #10 raddr_0 <= 5'b00010; raddr_1 <= 5'b00011; result_addr <= 5'b00100;
  #20 
  $finish;
end

endmodule*/
 




/////////////////////////////////////////////INSTRUCTION MEMORY
module instruction_mem(clk,raddr,waddr,memwrite,wdata,rdata);

input clk,memwrite;
input [4:0] raddr,waddr;
input [31:0] wdata;
output [31:0] rdata;

reg[7:0] instr_mem[127:0];

assign rdata = {instr_mem[raddr],instr_mem[raddr+1],instr_mem[raddr+2],instr_mem[raddr+3]};

always @( posedge clk )
begin
  if(memwrite)
  begin
    instr_mem[waddr] <= wdata[31:24];
    instr_mem[waddr+1] <= wdata[23:16];
    instr_mem[waddr+2] <= wdata[15:8];
    instr_mem[waddr+3] <= wdata[7:0];
  end
end

endmodule
///////////////////////////////////////INSTRUCTION MEMORY TEST
/*module instruction_mem__test;

reg clk = 1,memwrite = 0;
reg [4:0] raddr, waddr;
reg [31:0] wdata;
wire [31:0] rdata;

always #5 clk = ~clk;

instruction_mem instruction_mem_1(.clk(clk),.raddr(raddr),.memwrite(memwrite),.waddr(waddr),.wdata(wdata),.rdata(rdata));

initial begin

  $vcdpluson(0);
  raddr <= 0; waddr = 0; wdata <= 0;
  #10 memwrite <= 1; wdata <= 32'b100011_00001_00010_00000_00000_010100;
  #20
  $finish;
end  
endmodule*/    






/////////////////////////////////////////////DATA MEMORY
module data_mem(clk,memwrite,memread,addr,wdata,rdata);

input clk,memwrite,memread;
input [4:0] addr;
input [31:0] wdata;
output [31:0] rdata;

reg[31:0] data_mem[31:0];


assign rdata = (memread == 0)?32'bxxxxxxxx:data_mem[addr];
always @( posedge clk)
begin
  if(memwrite)
    data_mem[addr] <= wdata;
end

endmodule
///////////////////////////////////////DATA MEMORY TEST
/*module data_mem__test;

reg clk = 1,memwrite = 0, memread = 0;
reg [4:0] addr;
reg [31:0] wdata;
wire [31:0] rdata;

always #5 clk = ~clk;

instruction_mem instruction_mem_1(.clk(clk),.addr(addr),.memwrite(memwrite),.wdata(wdata),.rdata(rdata));

initial begin

  $vcdpluson(0);
  addr <= 0;wdata <= 0;
  #10 memwrite <= 1; wdata <= 32'h0001;
  #10 memread <= 1;
  #10
  $finish;
end  
endmodule*/





/////////////////////////////////////////////IF/ID REG
module if_id_reg(clk,reset,pc_4,inst,if_id_wenable,if_id_flush,value);

input clk,reset,if_id_wenable,if_id_flush;
input [31:0] pc_4,inst;
output reg [63:0] value;

always @( posedge clk )
  begin
    if(reset)
      value <= 0;
    else if(if_id_flush == 1)
      value <= 0;
    else
      if(if_id_wenable)
        value <= {pc_4,inst};
  end

endmodule
///////////////////////////////////////IF_ID_REG_TEST
/*module if_id_reg__test;

reg clk = 1,reset = 0, if_id_wenable = 0, if_id_flush = 0;
reg [31:0] pc_4, inst;
wire [63:0] value;

always #5 clk = ~clk;

if_id_reg if_id_reg_1(.clk(clk),.reset(reset),.if_id_wenable(if_id_wenable),.if_id_flush(if_id_flush),.pc_4(pc_4),.inst(inst),.value(value));

initial begin

  $vcdpluson(0);
  pc_4 = 0; inst = 0;
  #10 reset <= 1; if_id_wenable <= 1; pc_4 <= 32'h00000004; inst <= 32'b100011_00001_00010_00000_00000_010100;
  #10 reset <= 0; 
  #20 if_id_flush <= 1;
  #20
  $finish;
end  
endmodule*/






/////////////////////////////////////////////ID/EX_REG
module id_ex_reg(clk,reset,id_ex_flush,id_ex_wenable,wb,m,ex,pc_4,rdata_0,rdata_1,inst_15_0_ext,inst_20_16,inst_15_11,inst_25_21,value);

input clk,reset,id_ex_flush,id_ex_wenable;
input [1:0] wb;
input [2:0] m;
input [3:0] ex;
input [31:0] pc_4,rdata_0,rdata_1,inst_15_0_ext;
input [4:0] inst_25_21,inst_20_16,inst_15_11;
output reg[151:0] value;

always @( posedge clk )
  begin
    if(reset)
      value <= 0;
    else if(id_ex_flush)
      value <= 0;
    else
      if(id_ex_wenable)
         value <= {wb,m,ex,pc_4,rdata_0,rdata_1,inst_15_0_ext,inst_25_21,inst_20_16,inst_15_11};
  end
endmodule




/////////////////////////////////////////////EX/MEM REG
module ex_mem_reg(clk,reset,ex_mem_wenable,ex_mem_flush,wb,m,bran_addr,zero_flag,alu_result,rdata_1,reg_dst_addr,value);

input clk,reset,zero_flag,ex_mem_wenable,ex_mem_flush;
input [1:0] wb;
input [2:0] m;
input [31:0] alu_result,rdata_1,bran_addr;
input [4:0] reg_dst_addr;
output reg [106:0] value;

always @( posedge clk )
  begin
    if(reset)
      value <= 0;
    else if(ex_mem_flush)
      value <= 0;
    else
      if(ex_mem_wenable)
        value <= {wb,m,bran_addr,zero_flag,alu_result,rdata_1,reg_dst_addr};
  end

endmodule





/////////////////////////////////////////////MEM/WB REG
module mem_wb_reg(clk,reset,mem_wb_wenable,wb,mrdata,alu_result,reg_dst_addr,value);

input clk,reset,mem_wb_wenable;
input [1:0] wb;
input [31:0] mrdata,alu_result;
input [4:0] reg_dst_addr;
output reg [70:0] value;

always @( posedge clk)
  begin
    if(reset)
      value <= 0;
    else
      if(mem_wb_wenable)
        value <= {wb,mrdata,alu_result,reg_dst_addr};
  end

endmodule





/////////////////////////////////////////////PC
module pc(clk,reset,pc_wenable,d,value);

input clk,reset,pc_wenable;
input [31:0] d;
output reg [31:0] value;

always @( posedge clk )
  begin
    if(reset)
       value <= 0;
    else 
      if(pc_wenable)
        value <= d;
  end

endmodule





////////////////////////////////////////////////FORWARDING UNIT
module forwarding_unit(id_ex_rs,id_ex_rt,ex_mem_rd,mem_wb_rd,ex_mem_regw,mem_wb_regw,forward_a,forward_b);

input [4:0] id_ex_rs,id_ex_rt,ex_mem_rd,mem_wb_rd;
input ex_mem_regw,mem_wb_regw;
output reg [1:0] forward_a,forward_b;

always @(*)
begin
  if(ex_mem_regw && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_rs))
    forward_a = 2'b10;
  else if(mem_wb_regw && (mem_wb_rd != 0) && (mem_wb_rd == id_ex_rs))
    forward_a = 2'b01;
  else
    forward_a = 2'b00;
  
  if(ex_mem_regw && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_rt))
    forward_b = 2'b10;
  else if(mem_wb_regw && (mem_wb_rd != 0) && (mem_wb_rd == id_ex_rt))
    forward_b = 2'b01;
  else
    forward_b = 2'b00;
end

endmodule





////////////////////////////////////////////////HAZARD DETECTION UNIT
module hazard_detection_unit(if_id_rs,if_id_rt,id_ex_rt,id_ex_memread,pcwrite,if_id_write,set_ctl_zero);

input [4:0] if_id_rs,if_id_rt,id_ex_rt;
input id_ex_memread;
output reg pcwrite,if_id_write,set_ctl_zero;

always @(*)
begin
  if(id_ex_memread && ((id_ex_rt == if_id_rs) || (id_ex_rt == if_id_rt)))
  begin
    pcwrite = 1'b0;
    if_id_write = 1'b0;
    set_ctl_zero = 1'b1;
  end
  else
  begin
    pcwrite = 1'b1;
    if_id_write = 1'b1;
    set_ctl_zero = 1'b0;
  end
end

endmodule




////////////////////////////////////////////////TASK_END_TEST
module task_end_test(last_inst,pc,isend);

input [4:0] last_inst;
input [31:0] pc;
output isend;

assign isend = last_inst == pc[4:0];

endmodule





////////////////////////////////////////////////MIPS_PROCESSOR
module mips_processor(clk,reset,last_inst,start,winst,waddr,memwrite,isend,result_addr,result);

input clk,reset,memwrite,start;
input [4:0] last_inst,waddr;
input [31:0] winst;
input [4:0] result_addr;
output isend;
output [31:0] result;

wire [31:0] result_temp;

assign result = result_temp;

wire flush;

wire [63:0] if_id_out;
wire [151:0] id_ex_out;
wire [31:0] sign_extend_out;
wire [106:0] ex_mem_out;
wire [70:0] mem_wb_out;

//*******************************************************************
//module mux_2(in_1,in_2,sel,out);
wire [31:0] pc_4,pc_next;
mux_2#(32) mux_2_1(.in_1(pc_4),.in_2(ex_mem_out[101:70]),.sel(flush),.out(pc_next));


//*******************************************************************
//module task_end_test(last_inst,pc,isend);
//module pc(clk,reset,pc_wenable,d,value);
//wire isend;
wire pc_wenable;
wire pcwrite;
wire [31:0] pc;

task_end_test task_end_test_1(.last_inst(last_inst),.pc(pc),.isend(isend));

assign pc_wenable = pcwrite && (!isend) && start;

pc pc_1(.clk(clk),.reset(reset),.pc_wenable(pc_wenable),.d(pc_next),.value(pc));


//******************************************************************************
//module instruction_mem(clk,raddr,waddr,memwrite,wdata,rdata);
wire [31:0] inst;
instruction_mem instruction_mem_1(.clk(clk),.raddr(pc[4:0]),.waddr(waddr),.memwrite(memwrite),.wdata(winst),.rdata(inst));




//******************************************************************************************************************
//module adder(op_1,op_2,result);
adder adder_1(.op_1(pc),.op_2(32'h00000004),.result(pc_4));



//******************************************************************
///module mux_2(in_1,in_2,sel,out);
wire [31:0] final_pc_4;
mux_2#(32) mux_2_pc(.in_1(pc_4),.in_2(0),.sel(isend),.out(final_pc_4));




//******************************************************************
///module mux_2(in_1,in_2,sel,out);
wire [31:0] final_inst;
mux_2#(32) mux_2_inst(.in_1(inst),.in_2(0),.sel(isend),.out(final_inst));




//*********************************************************
//module if_id_reg(clk,reset,pc_4,inst,if_id_wenable,if_id_flush,value);
wire if_id_write;
wire if_id_wenable;
if_id_reg if_id_reg_1(.clk(clk),.reset(reset),.pc_4(final_pc_4),.inst(final_inst),.if_id_wenable(if_id_wenable),.if_id_flush(flush),.value(if_id_out));

assign if_id_wenable = if_id_write && start;





//******************************************************************************************************************************************
//module register_files(clk,reset,raddr_0,raddr_1,regwrite,waddr,wdata,rdata_0,rdata_1,result_addr,result);
wire [31:0] rdata_0,rdata_1;
wire [31:0] reg_wdata;
register_files register_files_1(.clk(clk),.reset(reset),.raddr_0(if_id_out[25:21]),.raddr_1(if_id_out[20:16]),.regwrite(mem_wb_out[70]),.waddr(mem_wb_out[4:0]),.wdata(reg_wdata),.rdata_0(rdata_0),.rdata_1(rdata_1),.result_addr(result_addr),.result(result_temp));



//*********************************************************************************************************************************************
//module sign_extend(in,out);

sign_extend sign_extend_1(.in(if_id_out[15:0]),.out(sign_extend_out));


//********************************************************************
//module control(opcode,ctl_signal);
wire [8:0] ctl_signal;
control control_1(.opcode(if_id_out[31:26]),.ctl_signal(ctl_signal));



//********************************************************************
//module mux_2(in_1,in_2,sel,out);
wire stall;
wire [8:0] final_ctl_signal;
mux_2#(9) mux_2_ctl(.in_1(ctl_signal),.in_2(9'b000000000),.sel(stall),.out(final_ctl_signal));




//********************************************************************
//module id_ex_reg(clk,reset,id_ex_flush,id_ex_wenable,wb,m,ex,pc_4,rdata_0,rdata_1,inst_15_0_ext,inst_20_16,inst_15_11,inst_25_21,value);
id_ex_reg id_ex_reg_1(.clk(clk),.reset(reset),.id_ex_flush(flush),.id_ex_wenable(start),.wb(final_ctl_signal[8:7]),.m(final_ctl_signal[6:4]),.ex(final_ctl_signal[3:0]),.pc_4(if_id_out[63:32]),.rdata_0(rdata_0),.rdata_1(rdata_1),.inst_15_0_ext(sign_extend_out),.inst_20_16(if_id_out[20:16]),.inst_15_11(if_id_out[15:11]),.inst_25_21(if_id_out[25:21]),.value(id_ex_out));


//*********************************************************************
//module shift_left_2(in,out);
wire [31:0] shifted;
shift_left_2 shift_left_2_1(.in(id_ex_out[46:15]),.out(shifted));



//*********************************************************************
//module adder(op_1,op_2,result);
wire [31:0] pre_bran_addr;
adder adder_2(.op_1(id_ex_out[142:111]),.op_2(shifted),.result(pre_bran_addr));




//**********************************************************************************
//module mux_3(in_1,in_2,in_3,sel,out);

wire [31:0] alu_op_1;
wire [1:0] alu_op1_sel;
mux_3#(32) mux_3_1(.in_1(id_ex_out[110:79]),.in_2(reg_wdata),.in_3(ex_mem_out[68:37]),.sel(alu_op1_sel),.out(alu_op_1));



//**************************************************************************************
//module mux_3(in_1,in_2,in_3,sel,out);
wire [31:0] alu_op_2;
wire [1:0] alu_op2_sel;
mux_3#(32) mux_3_2(.in_1(id_ex_out[78:47]),.in_2(reg_wdata),.in_3(ex_mem_out[68:37]),.sel(alu_op2_sel),.out(alu_op_2));


//**************************************************************************************
wire [31:0] final_alu_op_2;
mux_2#(32) mux_2_alu_op_2(.in_1(alu_op_2),.in_2(id_ex_out[46:15]),.sel(id_ex_out[143]),.out(final_alu_op_2));



//**************************************************************************************
//module alu(alu_ctl,op_1,op_2,result,zero_flag);
wire [3:0] alu_ctl;
wire [31:0] alu_result;
wire zero_flag;

alu alu_1(.alu_ctl(alu_ctl),.op_1(alu_op_1),.op_2(final_alu_op_2),.result(alu_result),.zero_flag(zero_flag));




//**************************************************************************************************************
//module alu_control(alu_op,func_code,alu_ctl);
alu_control alu_control_1(.alu_op(id_ex_out[145:144]),.func_code(id_ex_out[20:15]),.alu_ctl(alu_ctl));




//****************************************************************************************************
//module mux_2(in_1,in_2,sel,out);
wire [4:0] rd;
mux_2#(5) mux_2_rd(.in_1(id_ex_out[9:5]),.in_2(id_ex_out[4:0]),.sel(id_ex_out[146]),.out(rd));




//***************************************************************************************
//module ex_mem_reg(clk,reset,ex_mem_wenable,ex_mem_flush,wb,m,bran_addr,zero_flag,alu_result,rdata_1,reg_dst_addr,value);

ex_mem_reg ex_mem_reg_1(.clk(clk),.reset(reset),.ex_mem_wenable(start),.ex_mem_flush(flush),.wb(id_ex_out[151:150]),.m(id_ex_out[149:147]),.bran_addr(pre_bran_addr),.zero_flag(zero_flag),.alu_result(alu_result),.rdata_1(alu_op_2),.reg_dst_addr(rd),.value(ex_mem_out));




//*********************************************************************************************
//module branch(zero_flag,branch,pcsrc);
branch branch_1(.zero_flag(ex_mem_out[69]),.branch(ex_mem_out[104]),.pcsrc(flush));




//********************************************************************************
//module data_mem(clk,memwrite,memread,addr,wdata,rdata);
wire [31:0] mrdata;
data_mem data_mem_1(.clk(clk),.memwrite(ex_mem_out[102]),.memread(ex_mem_out[103]),.addr(ex_mem_out[41:37]),.wdata(ex_mem_out[36:5]),.rdata(mrdata));



//*********************************************************
//module mem_wb_reg(clk,reset,mem_wb_wenable,wb,mrdata,alu_result,reg_dst_addr,value);

mem_wb_reg mem_wb_reg_1(.clk(clk),.reset(reset),.mem_wb_wenable(start),.wb(ex_mem_out[106:105]),.mrdata(mrdata),.alu_result(ex_mem_out[68:37]),.reg_dst_addr(ex_mem_out[4:0]),.value(mem_wb_out));




//********************************************************
//module mux_2(in_1,in_2,sel,out);
mux_2#(32) mux_2_3(.in_1(mem_wb_out[68:37]),.in_2(mem_wb_out[36:5]),.sel(mem_wb_out[69]),.out(reg_wdata));





//*********************************************************
//module hazard_detection_unit(if_id_rs,if_id_rt,id_ex_rt,id_ex_memread,pcwrite,if_id_write,set_ctl_zero);
hazard_detection_unit hazard_detection_unit_1(.if_id_rs(if_id_out[25:21]),.if_id_rt(if_id_out[20:16]),.id_ex_rt(id_ex_out[9:5]),.id_ex_memread(id_ex_out[148]),.pcwrite(pcwrite),.if_id_write(if_id_write),.set_ctl_zero(stall));




//********************************************************************
//module forwarding_unit(id_ex_rs,id_ex_rt,ex_mem_rd,mem_wb_rd,ex_mem_regw,mem_wb_regw,forward_a,forward_b);
forwarding_unit forwarding_unit_1(.id_ex_rs(id_ex_out[14:10]),.id_ex_rt(id_ex_out[9:5]),.ex_mem_rd(ex_mem_out[4:0]),.mem_wb_rd(mem_wb_out[4:0]),.ex_mem_regw(ex_mem_out[106]),.mem_wb_regw(mem_wb_out[70]),.forward_a(alu_op1_sel),.forward_b(alu_op2_sel));




endmodule





/////////////////////////////////////////////////////////////////////////MIPS_PROCESSOR TEST
module mips_processor_test;


reg clk = 1, reset = 0, memwrite = 0, start = 0;
reg [4:0] last_inst, waddr;
reg [4:0] result_addr = 0;
reg [31:0] winst;

wire isend;
wire [31:0] result;

always #5 clk = ~clk;

mips_processor mips_processor_1(.clk(clk),.reset(reset),.last_inst(last_inst),.start(start),.winst(winst),.waddr(waddr),.memwrite(memwrite),.isend(isend),.result_addr(result_addr),.result(result));

initial begin

  $set_gate_level_monitoring("rtl_on");
  $set_toggle_region(mips_processor_test.mips_processor_1);
  $toggle_start();

$vcdpluson(0);

#10 reset <= 1;
#10 reset <= 0;
#10 memwrite <= 1; 

//*************************************************************************NO HAZARD
/*#10 waddr <= 8'h00; winst <= 32'b000000_00100_00010_01001_00000_100000;
#10 waddr <= 8'h04; winst <= 32'b000000_00010_00101_00100_00000_100100;
#10 waddr <= 8'h08; winst <= 32'b000000_00010_00110_01000_00000_100101;
#10 waddr <= 8'h0c; winst <= 32'b000000_00110_00111_00001_00000_101010;
#20 memwrite <= 0; start <= 1; last_inst <= 8'h10;
#110 result_addr <= 5'b00001;
#20*/

//*************************************************************************DATA HAZARD
#10 waddr <= 8'h00; winst <= 32'b101011_00001_01111_00000_00000_010100;
#10 waddr <= 8'h04; winst <= 32'b100011_00001_00010_00000_00000_010100;
#10 waddr <= 8'h08; winst <= 32'b000000_00010_00101_00100_00000_100100;
#10 waddr <= 8'h0c; winst <= 32'b000000_00100_00110_01000_00000_100101;
#10 waddr <= 8'h10; winst <= 32'b000000_00100_00110_01001_00000_100000;
#20 memwrite <= 0; start <= 1; last_inst <= 8'h14;
#110 result_addr <= 5'b01000;
#50
$display("result_addr: %h   results: %d",result_addr,result);
//*************************************************************************DATA HAZARD
/*#10 waddr <= 8'h00; winst <= 32'b101011_00001_01111_00000_00000_010100;
#10 waddr <= 8'h04; winst <= 32'b100011_00001_00010_00000_00000_010100;
#10 waddr <= 8'h08; winst <= 32'b000000_00010_00101_00100_00000_100100;
#10 waddr <= 8'h0c; winst <= 32'b000000_00100_00110_01000_00000_100101;
#10 waddr <= 8'h10; winst <= 32'b000000_00100_00110_01001_00000_100000;
#20 memwrite <= 0; start <= 1; last_inst <= 8'h14;
#110 result_addr <= 5'b01001;
#50*/


//*************************************************************************CONTROL HAZARD--BRANCH CONDITION MEET
/*#10 waddr <= 8'h00; winst <= 32'b000100_00001_00001_00000_00000_000010;
#10 waddr <= 8'h04; winst <= 32'b000000_00010_00101_01100_00000_100100;
#10 waddr <= 8'h08; winst <= 32'b000000_00110_00010_01101_00000_100101;
#10 waddr <= 8'h0c; winst <= 32'b000000_00010_00010_01110_00000_100000;
#20 memwrite <= 0; start <= 1; last_inst <= 8'h10;
#110 result_addr <= 5'b01110;
#50*/

//*************************************************************************CONTROL HAZARD--BRANCH CONDITION NOT MEET
/*#10 waddr <= 8'h00; winst <= 32'b000100_00001_00011_00000_00000_000010;
#10 waddr <= 8'h04; winst <= 32'b000000_00010_00101_01100_00000_100100;
#10 waddr <= 8'h08; winst <= 32'b000000_00110_00010_01101_00000_100101;
#10 waddr <= 8'h0c; winst <= 32'b000000_00010_00010_01110_00000_100000;
#20 memwrite <= 0; start <= 1; last_inst <= 8'h10;
#110 result_addr <= 5'b01101;
#50*/

$toggle_stop();
$toggle_report("mips_processor.saif",1.0e-10,"mips_processor_test.mips_processor_1");
$finish;

end

endmodule
