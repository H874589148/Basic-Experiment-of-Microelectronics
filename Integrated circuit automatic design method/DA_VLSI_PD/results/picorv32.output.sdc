###################################################################

# Created by write_sdc on Sun Dec 13 20:46:43 2020

###################################################################
set sdc_version 2.0

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
set_propagated_clock [get_ports clk]
create_clock [get_ports clk]  -period 2  -waveform {0 1}
group_path -name FEEDTHROUGH  -from [list [get_ports resetn] [get_ports mem_ready] [get_ports               \
{mem_rdata[31]}] [get_ports {mem_rdata[30]}] [get_ports {mem_rdata[29]}]       \
[get_ports {mem_rdata[28]}] [get_ports {mem_rdata[27]}] [get_ports             \
{mem_rdata[26]}] [get_ports {mem_rdata[25]}] [get_ports {mem_rdata[24]}]       \
[get_ports {mem_rdata[23]}] [get_ports {mem_rdata[22]}] [get_ports             \
{mem_rdata[21]}] [get_ports {mem_rdata[20]}] [get_ports {mem_rdata[19]}]       \
[get_ports {mem_rdata[18]}] [get_ports {mem_rdata[17]}] [get_ports             \
{mem_rdata[16]}] [get_ports {mem_rdata[15]}] [get_ports {mem_rdata[14]}]       \
[get_ports {mem_rdata[13]}] [get_ports {mem_rdata[12]}] [get_ports             \
{mem_rdata[11]}] [get_ports {mem_rdata[10]}] [get_ports {mem_rdata[9]}]        \
[get_ports {mem_rdata[8]}] [get_ports {mem_rdata[7]}] [get_ports               \
{mem_rdata[6]}] [get_ports {mem_rdata[5]}] [get_ports {mem_rdata[4]}]          \
[get_ports {mem_rdata[3]}] [get_ports {mem_rdata[2]}] [get_ports               \
{mem_rdata[1]}] [get_ports {mem_rdata[0]}] [get_ports pcpi_wr] [get_ports      \
{pcpi_rd[31]}] [get_ports {pcpi_rd[30]}] [get_ports {pcpi_rd[29]}] [get_ports  \
{pcpi_rd[28]}] [get_ports {pcpi_rd[27]}] [get_ports {pcpi_rd[26]}] [get_ports  \
{pcpi_rd[25]}] [get_ports {pcpi_rd[24]}] [get_ports {pcpi_rd[23]}] [get_ports  \
{pcpi_rd[22]}] [get_ports {pcpi_rd[21]}] [get_ports {pcpi_rd[20]}] [get_ports  \
{pcpi_rd[19]}] [get_ports {pcpi_rd[18]}] [get_ports {pcpi_rd[17]}] [get_ports  \
{pcpi_rd[16]}] [get_ports {pcpi_rd[15]}] [get_ports {pcpi_rd[14]}] [get_ports  \
{pcpi_rd[13]}] [get_ports {pcpi_rd[12]}] [get_ports {pcpi_rd[11]}] [get_ports  \
{pcpi_rd[10]}] [get_ports {pcpi_rd[9]}] [get_ports {pcpi_rd[8]}] [get_ports    \
{pcpi_rd[7]}] [get_ports {pcpi_rd[6]}] [get_ports {pcpi_rd[5]}] [get_ports     \
{pcpi_rd[4]}] [get_ports {pcpi_rd[3]}] [get_ports {pcpi_rd[2]}] [get_ports     \
{pcpi_rd[1]}] [get_ports {pcpi_rd[0]}] [get_ports pcpi_wait] [get_ports        \
pcpi_ready] [get_ports {irq[31]}] [get_ports {irq[30]}] [get_ports {irq[29]}]  \
[get_ports {irq[28]}] [get_ports {irq[27]}] [get_ports {irq[26]}] [get_ports   \
{irq[25]}] [get_ports {irq[24]}] [get_ports {irq[23]}] [get_ports {irq[22]}]   \
[get_ports {irq[21]}] [get_ports {irq[20]}] [get_ports {irq[19]}] [get_ports   \
{irq[18]}] [get_ports {irq[17]}] [get_ports {irq[16]}] [get_ports {irq[15]}]   \
[get_ports {irq[14]}] [get_ports {irq[13]}] [get_ports {irq[12]}] [get_ports   \
{irq[11]}] [get_ports {irq[10]}] [get_ports {irq[9]}] [get_ports {irq[8]}]     \
[get_ports {irq[7]}] [get_ports {irq[6]}] [get_ports {irq[5]}] [get_ports      \
{irq[4]}] [get_ports {irq[3]}] [get_ports {irq[2]}] [get_ports {irq[1]}]       \
[get_ports {irq[0]}]]  -to [list [get_ports trap] [get_ports mem_valid] [get_ports mem_instr]        \
[get_ports {mem_addr[31]}] [get_ports {mem_addr[30]}] [get_ports               \
{mem_addr[29]}] [get_ports {mem_addr[28]}] [get_ports {mem_addr[27]}]          \
[get_ports {mem_addr[26]}] [get_ports {mem_addr[25]}] [get_ports               \
{mem_addr[24]}] [get_ports {mem_addr[23]}] [get_ports {mem_addr[22]}]          \
[get_ports {mem_addr[21]}] [get_ports {mem_addr[20]}] [get_ports               \
{mem_addr[19]}] [get_ports {mem_addr[18]}] [get_ports {mem_addr[17]}]          \
[get_ports {mem_addr[16]}] [get_ports {mem_addr[15]}] [get_ports               \
{mem_addr[14]}] [get_ports {mem_addr[13]}] [get_ports {mem_addr[12]}]          \
[get_ports {mem_addr[11]}] [get_ports {mem_addr[10]}] [get_ports               \
{mem_addr[9]}] [get_ports {mem_addr[8]}] [get_ports {mem_addr[7]}] [get_ports  \
{mem_addr[6]}] [get_ports {mem_addr[5]}] [get_ports {mem_addr[4]}] [get_ports  \
{mem_addr[3]}] [get_ports {mem_addr[2]}] [get_ports {mem_addr[1]}] [get_ports  \
{mem_addr[0]}] [get_ports {mem_wdata[31]}] [get_ports {mem_wdata[30]}]         \
[get_ports {mem_wdata[29]}] [get_ports {mem_wdata[28]}] [get_ports             \
{mem_wdata[27]}] [get_ports {mem_wdata[26]}] [get_ports {mem_wdata[25]}]       \
[get_ports {mem_wdata[24]}] [get_ports {mem_wdata[23]}] [get_ports             \
{mem_wdata[22]}] [get_ports {mem_wdata[21]}] [get_ports {mem_wdata[20]}]       \
[get_ports {mem_wdata[19]}] [get_ports {mem_wdata[18]}] [get_ports             \
{mem_wdata[17]}] [get_ports {mem_wdata[16]}] [get_ports {mem_wdata[15]}]       \
[get_ports {mem_wdata[14]}] [get_ports {mem_wdata[13]}] [get_ports             \
{mem_wdata[12]}] [get_ports {mem_wdata[11]}] [get_ports {mem_wdata[10]}]       \
[get_ports {mem_wdata[9]}] [get_ports {mem_wdata[8]}] [get_ports               \
{mem_wdata[7]}] [get_ports {mem_wdata[6]}] [get_ports {mem_wdata[5]}]          \
[get_ports {mem_wdata[4]}] [get_ports {mem_wdata[3]}] [get_ports               \
{mem_wdata[2]}] [get_ports {mem_wdata[1]}] [get_ports {mem_wdata[0]}]          \
[get_ports {mem_wstrb[3]}] [get_ports {mem_wstrb[2]}] [get_ports               \
{mem_wstrb[1]}] [get_ports {mem_wstrb[0]}] [get_ports mem_la_read] [get_ports  \
mem_la_write] [get_ports {mem_la_addr[31]}] [get_ports {mem_la_addr[30]}]      \
[get_ports {mem_la_addr[29]}] [get_ports {mem_la_addr[28]}] [get_ports         \
{mem_la_addr[27]}] [get_ports {mem_la_addr[26]}] [get_ports {mem_la_addr[25]}] \
[get_ports {mem_la_addr[24]}] [get_ports {mem_la_addr[23]}] [get_ports         \
{mem_la_addr[22]}] [get_ports {mem_la_addr[21]}] [get_ports {mem_la_addr[20]}] \
[get_ports {mem_la_addr[19]}] [get_ports {mem_la_addr[18]}] [get_ports         \
{mem_la_addr[17]}] [get_ports {mem_la_addr[16]}] [get_ports {mem_la_addr[15]}] \
[get_ports {mem_la_addr[14]}] [get_ports {mem_la_addr[13]}] [get_ports         \
{mem_la_addr[12]}] [get_ports {mem_la_addr[11]}] [get_ports {mem_la_addr[10]}] \
[get_ports {mem_la_addr[9]}] [get_ports {mem_la_addr[8]}] [get_ports           \
{mem_la_addr[7]}] [get_ports {mem_la_addr[6]}] [get_ports {mem_la_addr[5]}]    \
[get_ports {mem_la_addr[4]}] [get_ports {mem_la_addr[3]}] [get_ports           \
{mem_la_addr[2]}] [get_ports {mem_la_addr[1]}] [get_ports {mem_la_addr[0]}]    \
[get_ports {mem_la_wdata[31]}] [get_ports {mem_la_wdata[30]}] [get_ports       \
{mem_la_wdata[29]}] [get_ports {mem_la_wdata[28]}] [get_ports                  \
{mem_la_wdata[27]}] [get_ports {mem_la_wdata[26]}] [get_ports                  \
{mem_la_wdata[25]}] [get_ports {mem_la_wdata[24]}] [get_ports                  \
{mem_la_wdata[23]}] [get_ports {mem_la_wdata[22]}] [get_ports                  \
{mem_la_wdata[21]}] [get_ports {mem_la_wdata[20]}] [get_ports                  \
{mem_la_wdata[19]}] [get_ports {mem_la_wdata[18]}] [get_ports                  \
{mem_la_wdata[17]}] [get_ports {mem_la_wdata[16]}] [get_ports                  \
{mem_la_wdata[15]}] [get_ports {mem_la_wdata[14]}] [get_ports                  \
{mem_la_wdata[13]}] [get_ports {mem_la_wdata[12]}] [get_ports                  \
{mem_la_wdata[11]}] [get_ports {mem_la_wdata[10]}] [get_ports                  \
{mem_la_wdata[9]}] [get_ports {mem_la_wdata[8]}] [get_ports {mem_la_wdata[7]}] \
[get_ports {mem_la_wdata[6]}] [get_ports {mem_la_wdata[5]}] [get_ports         \
{mem_la_wdata[4]}] [get_ports {mem_la_wdata[3]}] [get_ports {mem_la_wdata[2]}] \
[get_ports {mem_la_wdata[1]}] [get_ports {mem_la_wdata[0]}] [get_ports         \
{mem_la_wstrb[3]}] [get_ports {mem_la_wstrb[2]}] [get_ports {mem_la_wstrb[1]}] \
[get_ports {mem_la_wstrb[0]}] [get_ports pcpi_valid] [get_ports                \
{pcpi_insn[31]}] [get_ports {pcpi_insn[30]}] [get_ports {pcpi_insn[29]}]       \
[get_ports {pcpi_insn[28]}] [get_ports {pcpi_insn[27]}] [get_ports             \
{pcpi_insn[26]}] [get_ports {pcpi_insn[25]}] [get_ports {pcpi_insn[24]}]       \
[get_ports {pcpi_insn[23]}] [get_ports {pcpi_insn[22]}] [get_ports             \
{pcpi_insn[21]}] [get_ports {pcpi_insn[20]}] [get_ports {pcpi_insn[19]}]       \
[get_ports {pcpi_insn[18]}] [get_ports {pcpi_insn[17]}] [get_ports             \
{pcpi_insn[16]}] [get_ports {pcpi_insn[15]}] [get_ports {pcpi_insn[14]}]       \
[get_ports {pcpi_insn[13]}] [get_ports {pcpi_insn[12]}] [get_ports             \
{pcpi_insn[11]}] [get_ports {pcpi_insn[10]}] [get_ports {pcpi_insn[9]}]        \
[get_ports {pcpi_insn[8]}] [get_ports {pcpi_insn[7]}] [get_ports               \
{pcpi_insn[6]}] [get_ports {pcpi_insn[5]}] [get_ports {pcpi_insn[4]}]          \
[get_ports {pcpi_insn[3]}] [get_ports {pcpi_insn[2]}] [get_ports               \
{pcpi_insn[1]}] [get_ports {pcpi_insn[0]}] [get_ports {pcpi_rs1[31]}]          \
[get_ports {pcpi_rs1[30]}] [get_ports {pcpi_rs1[29]}] [get_ports               \
{pcpi_rs1[28]}] [get_ports {pcpi_rs1[27]}] [get_ports {pcpi_rs1[26]}]          \
[get_ports {pcpi_rs1[25]}] [get_ports {pcpi_rs1[24]}] [get_ports               \
{pcpi_rs1[23]}] [get_ports {pcpi_rs1[22]}] [get_ports {pcpi_rs1[21]}]          \
[get_ports {pcpi_rs1[20]}] [get_ports {pcpi_rs1[19]}] [get_ports               \
{pcpi_rs1[18]}] [get_ports {pcpi_rs1[17]}] [get_ports {pcpi_rs1[16]}]          \
[get_ports {pcpi_rs1[15]}] [get_ports {pcpi_rs1[14]}] [get_ports               \
{pcpi_rs1[13]}] [get_ports {pcpi_rs1[12]}] [get_ports {pcpi_rs1[11]}]          \
[get_ports {pcpi_rs1[10]}] [get_ports {pcpi_rs1[9]}] [get_ports {pcpi_rs1[8]}] \
[get_ports {pcpi_rs1[7]}] [get_ports {pcpi_rs1[6]}] [get_ports {pcpi_rs1[5]}]  \
[get_ports {pcpi_rs1[4]}] [get_ports {pcpi_rs1[3]}] [get_ports {pcpi_rs1[2]}]  \
[get_ports {pcpi_rs1[1]}] [get_ports {pcpi_rs1[0]}] [get_ports {pcpi_rs2[31]}] \
[get_ports {pcpi_rs2[30]}] [get_ports {pcpi_rs2[29]}] [get_ports               \
{pcpi_rs2[28]}] [get_ports {pcpi_rs2[27]}] [get_ports {pcpi_rs2[26]}]          \
[get_ports {pcpi_rs2[25]}] [get_ports {pcpi_rs2[24]}] [get_ports               \
{pcpi_rs2[23]}] [get_ports {pcpi_rs2[22]}] [get_ports {pcpi_rs2[21]}]          \
[get_ports {pcpi_rs2[20]}] [get_ports {pcpi_rs2[19]}] [get_ports               \
{pcpi_rs2[18]}] [get_ports {pcpi_rs2[17]}] [get_ports {pcpi_rs2[16]}]          \
[get_ports {pcpi_rs2[15]}] [get_ports {pcpi_rs2[14]}] [get_ports               \
{pcpi_rs2[13]}] [get_ports {pcpi_rs2[12]}] [get_ports {pcpi_rs2[11]}]          \
[get_ports {pcpi_rs2[10]}] [get_ports {pcpi_rs2[9]}] [get_ports {pcpi_rs2[8]}] \
[get_ports {pcpi_rs2[7]}] [get_ports {pcpi_rs2[6]}] [get_ports {pcpi_rs2[5]}]  \
[get_ports {pcpi_rs2[4]}] [get_ports {pcpi_rs2[3]}] [get_ports {pcpi_rs2[2]}]  \
[get_ports {pcpi_rs2[1]}] [get_ports {pcpi_rs2[0]}] [get_ports {eoi[31]}]      \
[get_ports {eoi[30]}] [get_ports {eoi[29]}] [get_ports {eoi[28]}] [get_ports   \
{eoi[27]}] [get_ports {eoi[26]}] [get_ports {eoi[25]}] [get_ports {eoi[24]}]   \
[get_ports {eoi[23]}] [get_ports {eoi[22]}] [get_ports {eoi[21]}] [get_ports   \
{eoi[20]}] [get_ports {eoi[19]}] [get_ports {eoi[18]}] [get_ports {eoi[17]}]   \
[get_ports {eoi[16]}] [get_ports {eoi[15]}] [get_ports {eoi[14]}] [get_ports   \
{eoi[13]}] [get_ports {eoi[12]}] [get_ports {eoi[11]}] [get_ports {eoi[10]}]   \
[get_ports {eoi[9]}] [get_ports {eoi[8]}] [get_ports {eoi[7]}] [get_ports      \
{eoi[6]}] [get_ports {eoi[5]}] [get_ports {eoi[4]}] [get_ports {eoi[3]}]       \
[get_ports {eoi[2]}] [get_ports {eoi[1]}] [get_ports {eoi[0]}] [get_ports      \
trace_valid] [get_ports {trace_data[35]}] [get_ports {trace_data[34]}]         \
[get_ports {trace_data[33]}] [get_ports {trace_data[32]}] [get_ports           \
{trace_data[31]}] [get_ports {trace_data[30]}] [get_ports {trace_data[29]}]    \
[get_ports {trace_data[28]}] [get_ports {trace_data[27]}] [get_ports           \
{trace_data[26]}] [get_ports {trace_data[25]}] [get_ports {trace_data[24]}]    \
[get_ports {trace_data[23]}] [get_ports {trace_data[22]}] [get_ports           \
{trace_data[21]}] [get_ports {trace_data[20]}] [get_ports {trace_data[19]}]    \
[get_ports {trace_data[18]}] [get_ports {trace_data[17]}] [get_ports           \
{trace_data[16]}] [get_ports {trace_data[15]}] [get_ports {trace_data[14]}]    \
[get_ports {trace_data[13]}] [get_ports {trace_data[12]}] [get_ports           \
{trace_data[11]}] [get_ports {trace_data[10]}] [get_ports {trace_data[9]}]     \
[get_ports {trace_data[8]}] [get_ports {trace_data[7]}] [get_ports             \
{trace_data[6]}] [get_ports {trace_data[5]}] [get_ports {trace_data[4]}]       \
[get_ports {trace_data[3]}] [get_ports {trace_data[2]}] [get_ports             \
{trace_data[1]}] [get_ports {trace_data[0]}]]
group_path -name REGIN  -from [list [get_ports resetn] [get_ports mem_ready] [get_ports               \
{mem_rdata[31]}] [get_ports {mem_rdata[30]}] [get_ports {mem_rdata[29]}]       \
[get_ports {mem_rdata[28]}] [get_ports {mem_rdata[27]}] [get_ports             \
{mem_rdata[26]}] [get_ports {mem_rdata[25]}] [get_ports {mem_rdata[24]}]       \
[get_ports {mem_rdata[23]}] [get_ports {mem_rdata[22]}] [get_ports             \
{mem_rdata[21]}] [get_ports {mem_rdata[20]}] [get_ports {mem_rdata[19]}]       \
[get_ports {mem_rdata[18]}] [get_ports {mem_rdata[17]}] [get_ports             \
{mem_rdata[16]}] [get_ports {mem_rdata[15]}] [get_ports {mem_rdata[14]}]       \
[get_ports {mem_rdata[13]}] [get_ports {mem_rdata[12]}] [get_ports             \
{mem_rdata[11]}] [get_ports {mem_rdata[10]}] [get_ports {mem_rdata[9]}]        \
[get_ports {mem_rdata[8]}] [get_ports {mem_rdata[7]}] [get_ports               \
{mem_rdata[6]}] [get_ports {mem_rdata[5]}] [get_ports {mem_rdata[4]}]          \
[get_ports {mem_rdata[3]}] [get_ports {mem_rdata[2]}] [get_ports               \
{mem_rdata[1]}] [get_ports {mem_rdata[0]}] [get_ports pcpi_wr] [get_ports      \
{pcpi_rd[31]}] [get_ports {pcpi_rd[30]}] [get_ports {pcpi_rd[29]}] [get_ports  \
{pcpi_rd[28]}] [get_ports {pcpi_rd[27]}] [get_ports {pcpi_rd[26]}] [get_ports  \
{pcpi_rd[25]}] [get_ports {pcpi_rd[24]}] [get_ports {pcpi_rd[23]}] [get_ports  \
{pcpi_rd[22]}] [get_ports {pcpi_rd[21]}] [get_ports {pcpi_rd[20]}] [get_ports  \
{pcpi_rd[19]}] [get_ports {pcpi_rd[18]}] [get_ports {pcpi_rd[17]}] [get_ports  \
{pcpi_rd[16]}] [get_ports {pcpi_rd[15]}] [get_ports {pcpi_rd[14]}] [get_ports  \
{pcpi_rd[13]}] [get_ports {pcpi_rd[12]}] [get_ports {pcpi_rd[11]}] [get_ports  \
{pcpi_rd[10]}] [get_ports {pcpi_rd[9]}] [get_ports {pcpi_rd[8]}] [get_ports    \
{pcpi_rd[7]}] [get_ports {pcpi_rd[6]}] [get_ports {pcpi_rd[5]}] [get_ports     \
{pcpi_rd[4]}] [get_ports {pcpi_rd[3]}] [get_ports {pcpi_rd[2]}] [get_ports     \
{pcpi_rd[1]}] [get_ports {pcpi_rd[0]}] [get_ports pcpi_wait] [get_ports        \
pcpi_ready] [get_ports {irq[31]}] [get_ports {irq[30]}] [get_ports {irq[29]}]  \
[get_ports {irq[28]}] [get_ports {irq[27]}] [get_ports {irq[26]}] [get_ports   \
{irq[25]}] [get_ports {irq[24]}] [get_ports {irq[23]}] [get_ports {irq[22]}]   \
[get_ports {irq[21]}] [get_ports {irq[20]}] [get_ports {irq[19]}] [get_ports   \
{irq[18]}] [get_ports {irq[17]}] [get_ports {irq[16]}] [get_ports {irq[15]}]   \
[get_ports {irq[14]}] [get_ports {irq[13]}] [get_ports {irq[12]}] [get_ports   \
{irq[11]}] [get_ports {irq[10]}] [get_ports {irq[9]}] [get_ports {irq[8]}]     \
[get_ports {irq[7]}] [get_ports {irq[6]}] [get_ports {irq[5]}] [get_ports      \
{irq[4]}] [get_ports {irq[3]}] [get_ports {irq[2]}] [get_ports {irq[1]}]       \
[get_ports {irq[0]}]]
group_path -name REGOUT  -to [list [get_ports trap] [get_ports mem_valid] [get_ports mem_instr]        \
[get_ports {mem_addr[31]}] [get_ports {mem_addr[30]}] [get_ports               \
{mem_addr[29]}] [get_ports {mem_addr[28]}] [get_ports {mem_addr[27]}]          \
[get_ports {mem_addr[26]}] [get_ports {mem_addr[25]}] [get_ports               \
{mem_addr[24]}] [get_ports {mem_addr[23]}] [get_ports {mem_addr[22]}]          \
[get_ports {mem_addr[21]}] [get_ports {mem_addr[20]}] [get_ports               \
{mem_addr[19]}] [get_ports {mem_addr[18]}] [get_ports {mem_addr[17]}]          \
[get_ports {mem_addr[16]}] [get_ports {mem_addr[15]}] [get_ports               \
{mem_addr[14]}] [get_ports {mem_addr[13]}] [get_ports {mem_addr[12]}]          \
[get_ports {mem_addr[11]}] [get_ports {mem_addr[10]}] [get_ports               \
{mem_addr[9]}] [get_ports {mem_addr[8]}] [get_ports {mem_addr[7]}] [get_ports  \
{mem_addr[6]}] [get_ports {mem_addr[5]}] [get_ports {mem_addr[4]}] [get_ports  \
{mem_addr[3]}] [get_ports {mem_addr[2]}] [get_ports {mem_addr[1]}] [get_ports  \
{mem_addr[0]}] [get_ports {mem_wdata[31]}] [get_ports {mem_wdata[30]}]         \
[get_ports {mem_wdata[29]}] [get_ports {mem_wdata[28]}] [get_ports             \
{mem_wdata[27]}] [get_ports {mem_wdata[26]}] [get_ports {mem_wdata[25]}]       \
[get_ports {mem_wdata[24]}] [get_ports {mem_wdata[23]}] [get_ports             \
{mem_wdata[22]}] [get_ports {mem_wdata[21]}] [get_ports {mem_wdata[20]}]       \
[get_ports {mem_wdata[19]}] [get_ports {mem_wdata[18]}] [get_ports             \
{mem_wdata[17]}] [get_ports {mem_wdata[16]}] [get_ports {mem_wdata[15]}]       \
[get_ports {mem_wdata[14]}] [get_ports {mem_wdata[13]}] [get_ports             \
{mem_wdata[12]}] [get_ports {mem_wdata[11]}] [get_ports {mem_wdata[10]}]       \
[get_ports {mem_wdata[9]}] [get_ports {mem_wdata[8]}] [get_ports               \
{mem_wdata[7]}] [get_ports {mem_wdata[6]}] [get_ports {mem_wdata[5]}]          \
[get_ports {mem_wdata[4]}] [get_ports {mem_wdata[3]}] [get_ports               \
{mem_wdata[2]}] [get_ports {mem_wdata[1]}] [get_ports {mem_wdata[0]}]          \
[get_ports {mem_wstrb[3]}] [get_ports {mem_wstrb[2]}] [get_ports               \
{mem_wstrb[1]}] [get_ports {mem_wstrb[0]}] [get_ports mem_la_read] [get_ports  \
mem_la_write] [get_ports {mem_la_addr[31]}] [get_ports {mem_la_addr[30]}]      \
[get_ports {mem_la_addr[29]}] [get_ports {mem_la_addr[28]}] [get_ports         \
{mem_la_addr[27]}] [get_ports {mem_la_addr[26]}] [get_ports {mem_la_addr[25]}] \
[get_ports {mem_la_addr[24]}] [get_ports {mem_la_addr[23]}] [get_ports         \
{mem_la_addr[22]}] [get_ports {mem_la_addr[21]}] [get_ports {mem_la_addr[20]}] \
[get_ports {mem_la_addr[19]}] [get_ports {mem_la_addr[18]}] [get_ports         \
{mem_la_addr[17]}] [get_ports {mem_la_addr[16]}] [get_ports {mem_la_addr[15]}] \
[get_ports {mem_la_addr[14]}] [get_ports {mem_la_addr[13]}] [get_ports         \
{mem_la_addr[12]}] [get_ports {mem_la_addr[11]}] [get_ports {mem_la_addr[10]}] \
[get_ports {mem_la_addr[9]}] [get_ports {mem_la_addr[8]}] [get_ports           \
{mem_la_addr[7]}] [get_ports {mem_la_addr[6]}] [get_ports {mem_la_addr[5]}]    \
[get_ports {mem_la_addr[4]}] [get_ports {mem_la_addr[3]}] [get_ports           \
{mem_la_addr[2]}] [get_ports {mem_la_addr[1]}] [get_ports {mem_la_addr[0]}]    \
[get_ports {mem_la_wdata[31]}] [get_ports {mem_la_wdata[30]}] [get_ports       \
{mem_la_wdata[29]}] [get_ports {mem_la_wdata[28]}] [get_ports                  \
{mem_la_wdata[27]}] [get_ports {mem_la_wdata[26]}] [get_ports                  \
{mem_la_wdata[25]}] [get_ports {mem_la_wdata[24]}] [get_ports                  \
{mem_la_wdata[23]}] [get_ports {mem_la_wdata[22]}] [get_ports                  \
{mem_la_wdata[21]}] [get_ports {mem_la_wdata[20]}] [get_ports                  \
{mem_la_wdata[19]}] [get_ports {mem_la_wdata[18]}] [get_ports                  \
{mem_la_wdata[17]}] [get_ports {mem_la_wdata[16]}] [get_ports                  \
{mem_la_wdata[15]}] [get_ports {mem_la_wdata[14]}] [get_ports                  \
{mem_la_wdata[13]}] [get_ports {mem_la_wdata[12]}] [get_ports                  \
{mem_la_wdata[11]}] [get_ports {mem_la_wdata[10]}] [get_ports                  \
{mem_la_wdata[9]}] [get_ports {mem_la_wdata[8]}] [get_ports {mem_la_wdata[7]}] \
[get_ports {mem_la_wdata[6]}] [get_ports {mem_la_wdata[5]}] [get_ports         \
{mem_la_wdata[4]}] [get_ports {mem_la_wdata[3]}] [get_ports {mem_la_wdata[2]}] \
[get_ports {mem_la_wdata[1]}] [get_ports {mem_la_wdata[0]}] [get_ports         \
{mem_la_wstrb[3]}] [get_ports {mem_la_wstrb[2]}] [get_ports {mem_la_wstrb[1]}] \
[get_ports {mem_la_wstrb[0]}] [get_ports pcpi_valid] [get_ports                \
{pcpi_insn[31]}] [get_ports {pcpi_insn[30]}] [get_ports {pcpi_insn[29]}]       \
[get_ports {pcpi_insn[28]}] [get_ports {pcpi_insn[27]}] [get_ports             \
{pcpi_insn[26]}] [get_ports {pcpi_insn[25]}] [get_ports {pcpi_insn[24]}]       \
[get_ports {pcpi_insn[23]}] [get_ports {pcpi_insn[22]}] [get_ports             \
{pcpi_insn[21]}] [get_ports {pcpi_insn[20]}] [get_ports {pcpi_insn[19]}]       \
[get_ports {pcpi_insn[18]}] [get_ports {pcpi_insn[17]}] [get_ports             \
{pcpi_insn[16]}] [get_ports {pcpi_insn[15]}] [get_ports {pcpi_insn[14]}]       \
[get_ports {pcpi_insn[13]}] [get_ports {pcpi_insn[12]}] [get_ports             \
{pcpi_insn[11]}] [get_ports {pcpi_insn[10]}] [get_ports {pcpi_insn[9]}]        \
[get_ports {pcpi_insn[8]}] [get_ports {pcpi_insn[7]}] [get_ports               \
{pcpi_insn[6]}] [get_ports {pcpi_insn[5]}] [get_ports {pcpi_insn[4]}]          \
[get_ports {pcpi_insn[3]}] [get_ports {pcpi_insn[2]}] [get_ports               \
{pcpi_insn[1]}] [get_ports {pcpi_insn[0]}] [get_ports {pcpi_rs1[31]}]          \
[get_ports {pcpi_rs1[30]}] [get_ports {pcpi_rs1[29]}] [get_ports               \
{pcpi_rs1[28]}] [get_ports {pcpi_rs1[27]}] [get_ports {pcpi_rs1[26]}]          \
[get_ports {pcpi_rs1[25]}] [get_ports {pcpi_rs1[24]}] [get_ports               \
{pcpi_rs1[23]}] [get_ports {pcpi_rs1[22]}] [get_ports {pcpi_rs1[21]}]          \
[get_ports {pcpi_rs1[20]}] [get_ports {pcpi_rs1[19]}] [get_ports               \
{pcpi_rs1[18]}] [get_ports {pcpi_rs1[17]}] [get_ports {pcpi_rs1[16]}]          \
[get_ports {pcpi_rs1[15]}] [get_ports {pcpi_rs1[14]}] [get_ports               \
{pcpi_rs1[13]}] [get_ports {pcpi_rs1[12]}] [get_ports {pcpi_rs1[11]}]          \
[get_ports {pcpi_rs1[10]}] [get_ports {pcpi_rs1[9]}] [get_ports {pcpi_rs1[8]}] \
[get_ports {pcpi_rs1[7]}] [get_ports {pcpi_rs1[6]}] [get_ports {pcpi_rs1[5]}]  \
[get_ports {pcpi_rs1[4]}] [get_ports {pcpi_rs1[3]}] [get_ports {pcpi_rs1[2]}]  \
[get_ports {pcpi_rs1[1]}] [get_ports {pcpi_rs1[0]}] [get_ports {pcpi_rs2[31]}] \
[get_ports {pcpi_rs2[30]}] [get_ports {pcpi_rs2[29]}] [get_ports               \
{pcpi_rs2[28]}] [get_ports {pcpi_rs2[27]}] [get_ports {pcpi_rs2[26]}]          \
[get_ports {pcpi_rs2[25]}] [get_ports {pcpi_rs2[24]}] [get_ports               \
{pcpi_rs2[23]}] [get_ports {pcpi_rs2[22]}] [get_ports {pcpi_rs2[21]}]          \
[get_ports {pcpi_rs2[20]}] [get_ports {pcpi_rs2[19]}] [get_ports               \
{pcpi_rs2[18]}] [get_ports {pcpi_rs2[17]}] [get_ports {pcpi_rs2[16]}]          \
[get_ports {pcpi_rs2[15]}] [get_ports {pcpi_rs2[14]}] [get_ports               \
{pcpi_rs2[13]}] [get_ports {pcpi_rs2[12]}] [get_ports {pcpi_rs2[11]}]          \
[get_ports {pcpi_rs2[10]}] [get_ports {pcpi_rs2[9]}] [get_ports {pcpi_rs2[8]}] \
[get_ports {pcpi_rs2[7]}] [get_ports {pcpi_rs2[6]}] [get_ports {pcpi_rs2[5]}]  \
[get_ports {pcpi_rs2[4]}] [get_ports {pcpi_rs2[3]}] [get_ports {pcpi_rs2[2]}]  \
[get_ports {pcpi_rs2[1]}] [get_ports {pcpi_rs2[0]}] [get_ports {eoi[31]}]      \
[get_ports {eoi[30]}] [get_ports {eoi[29]}] [get_ports {eoi[28]}] [get_ports   \
{eoi[27]}] [get_ports {eoi[26]}] [get_ports {eoi[25]}] [get_ports {eoi[24]}]   \
[get_ports {eoi[23]}] [get_ports {eoi[22]}] [get_ports {eoi[21]}] [get_ports   \
{eoi[20]}] [get_ports {eoi[19]}] [get_ports {eoi[18]}] [get_ports {eoi[17]}]   \
[get_ports {eoi[16]}] [get_ports {eoi[15]}] [get_ports {eoi[14]}] [get_ports   \
{eoi[13]}] [get_ports {eoi[12]}] [get_ports {eoi[11]}] [get_ports {eoi[10]}]   \
[get_ports {eoi[9]}] [get_ports {eoi[8]}] [get_ports {eoi[7]}] [get_ports      \
{eoi[6]}] [get_ports {eoi[5]}] [get_ports {eoi[4]}] [get_ports {eoi[3]}]       \
[get_ports {eoi[2]}] [get_ports {eoi[1]}] [get_ports {eoi[0]}] [get_ports      \
trace_valid] [get_ports {trace_data[35]}] [get_ports {trace_data[34]}]         \
[get_ports {trace_data[33]}] [get_ports {trace_data[32]}] [get_ports           \
{trace_data[31]}] [get_ports {trace_data[30]}] [get_ports {trace_data[29]}]    \
[get_ports {trace_data[28]}] [get_ports {trace_data[27]}] [get_ports           \
{trace_data[26]}] [get_ports {trace_data[25]}] [get_ports {trace_data[24]}]    \
[get_ports {trace_data[23]}] [get_ports {trace_data[22]}] [get_ports           \
{trace_data[21]}] [get_ports {trace_data[20]}] [get_ports {trace_data[19]}]    \
[get_ports {trace_data[18]}] [get_ports {trace_data[17]}] [get_ports           \
{trace_data[16]}] [get_ports {trace_data[15]}] [get_ports {trace_data[14]}]    \
[get_ports {trace_data[13]}] [get_ports {trace_data[12]}] [get_ports           \
{trace_data[11]}] [get_ports {trace_data[10]}] [get_ports {trace_data[9]}]     \
[get_ports {trace_data[8]}] [get_ports {trace_data[7]}] [get_ports             \
{trace_data[6]}] [get_ports {trace_data[5]}] [get_ports {trace_data[4]}]       \
[get_ports {trace_data[3]}] [get_ports {trace_data[2]}] [get_ports             \
{trace_data[1]}] [get_ports {trace_data[0]}]]