#################################################################################
# MVRC Verification Script for
# Design Compiler Reference Methodology Script for Top-Down Flow
# Script: mvrc.tcl
# Version: H-2013.03 (April 15, 2013)
# Copyright (C) 2011-2013 Synopsys, Inc. All rights reserved.
#################################################################################

####Procedure to search the all the directories in the search_path for a given file name
proc search_searchpath {SEARCH_PATH FILE_NAME} {
  #### Check if we already have an absolute file reference
  if {[string index $FILE_NAME 0]== "/"} {
    return $FILE_NAME
  }
  foreach dir_path $SEARCH_PATH {
   if {![string compare [glob -nocomplain -directory $dir_path $FILE_NAME] ""] == 0} {
     set FILE_PATH [glob -nocomplain -directory $dir_path $FILE_NAME]
     return $FILE_PATH 
     break 
     }
   }
}
####Enable the default behavior of sh_continue_on_error to be same as DC ####
set_app_var sh_continue_on_error true

source -echo -verbose ./rm_setup/dc_setup.tcl

####choose  the stage you want to run MVRC.allowed values are RTL or NETLIST####
 set  MVRC_RUN "NETLIST"
####script to read the RTL design by mvcmp ####
####Sample line in the script for verilog/sverilog:: mvcmp -vlogan <vlogan command line> ####
####Sample line in the script for VHDL:: mvcmp -vhdlan <vhdlan command line> ####

 set  MVRC_RTL_READ_SCRIPT ${DESIGN_NAME}.MVRC.read_design.sh


if {$MVRC_RUN=="RTL"} {
   exec mvcmp -vhdlan ${RTL_SOURCE_FILES} -work work
   read_power_intent -upf  $DCRM_MV_UPF_INPUT_FILE

####Use Netlist as the default mode to run MVRC checks
} else {
   read_verilog -file $DCRM_FINAL_VERILOG_OUTPUT_FILE


   read_power_intent -upf $DCRM_MV_FINAL_UPF_OUTPUT_FILE
}

 create_mv_db -top ${DESIGN_NAME}

if {$MVRC_RUN =="NETLIST"} {
 create_physical_db -top ${DESIGN_NAME}
}

 read_db 

if {$MVRC_RUN =="NETLIST"} {
 read_phydb
}

check_design -[string tolower $MVRC_RUN] -log ${REPORTS_DIR}/${DESIGN_NAME}.mvrc_check_design.${MVRC_RUN}.rpt


puts "RM-Info: End script [info script]\n"
exit
