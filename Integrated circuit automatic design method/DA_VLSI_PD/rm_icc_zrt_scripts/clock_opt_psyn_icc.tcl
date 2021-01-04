##########################################################################################
# Version: H-2013.03-SP2 (Aug 5, 2013)
# Copyright (C) 2007-2013 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc_setup.tcl 
###############################################
## clock_opt_psyn_icc: Post CTS optimization ##
###############################################


 
open_mw_lib $MW_DESIGN_LIBRARY
redirect /dev/null "remove_mw_cel -version_kept 0 ${ICC_CLOCK_OPT_PSYN_CEL}" 
copy_mw_cel -from $ICC_CLOCK_OPT_CTS_CEL -to $ICC_CLOCK_OPT_PSYN_CEL
open_mw_cel $ICC_CLOCK_OPT_PSYN_CEL



## Optimization Common Session Options - set in all sessions
source -echo common_optimization_settings_icc.tcl
source -echo common_placement_settings_icc.tcl



## Source CTS Options 
source -echo common_cts_settings_icc.tcl

## Source Post CTS Options
source -echo common_post_cts_timing_settings.tcl


set_app_var compile_instance_name_prefix icc_clock 

if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }
if {[file exists [which $ICC_IN_AOCV_TABLE_FILE]]} {
  # Enable AOCV analysis
  set_app_var timing_aocvm_enable_analysis true
  
  # Read AOCV tables for design, hierarchical cells or lib cells
  read_aocvm $ICC_IN_AOCV_TABLE_FILE
  
  # Report specified AOCV data and computed derates
  redirect -file $REPORTS_DIR_ROUTE/$ICC_CLOCK_OPT_PSYN_CEL.aocvm.rpt {report_aocvm -nosplit *}
}
extract_rc
if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }

if {$ICC_ENABLE_CHECKPOINT} {
echo "RM-Info : Please ensure there's enough disk space before enabling the set_checkpoint_strategy feature."
set_checkpoint_strategy -enable -overwrite
# The -overwrite option is used by default. Remove it if needed.
}

if {[file exists [which $CUSTOM_CLOCK_OPT_PSYN_PRE_SCRIPT]]} {
echo "RM-Info: Sourcing [which $CUSTOM_CLOCK_OPT_PSYN_PRE_SCRIPT]"
source $CUSTOM_CLOCK_OPT_PSYN_PRE_SCRIPT
}
set clock_opt_psyn_cmd "clock_opt -no_clock_route -only_psyn -area_recovery" 
if {$PLACE_OPT_CONGESTION_DRIVEN} {lappend clock_opt_psyn_cmd -congestion}
if {!$DFT && [get_scan_chain] == 0} {lappend clock_opt_psyn_cmd -continue_on_missing_scandef}
if {$POWER_OPTIMIZATION} {lappend clock_opt_psyn_cmd -power}
echo $clock_opt_psyn_cmd
eval $clock_opt_psyn_cmd
## Use -optimize_dft if you have SCANDEF and there are scan nets with hold violations.
#  Note that scan wirelength can increase and may impact QoR.

if {[file exists [which $CUSTOM_CLOCK_OPT_PSYN_POST_SCRIPT]]} {
echo "RM-Info: Sourcing [which $CUSTOM_CLOCK_OPT_PSYN_POST_SCRIPT]"
source $CUSTOM_CLOCK_OPT_PSYN_POST_SCRIPT
}

if {$ICC_ENABLE_CHECKPOINT} {set_checkpoint_strategy -disable}

route_zrt_group -all_clock_nets -reuse_existing_global_route true -stop_after_global_route true
if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }
############################################################################################################
# ADDITIONAL FEATURES FOR THE POST CTS OPTIMIZATION
############################################################################################################

## When the design has congestion issues post CTS, use :
# refine_placement -congestion_effort medium

## Additional optimization can be done using the psynopt command
# psynopt -effort "medium|high"

if {$CLOCK_OPT_PSYN_PREROUTE_FOCALOPT_LAYER_OPTIMIZATION} {
## For advanced technologies, where upper metal layer resistance values are much smaller then lower layer ones,
#  you can perform layer optimization to improve existing buffer trees.
#  Use set_preroute_focal_opt_strategy to customize the settings.
report_preroute_focal_opt_strategy
preroute_focal_opt -layer_optimization
}

########################################
#         ANTENNA PREVENTION           #
########################################


if {$ICC_USE_DIODES && $ICC_PORT_PROTECTION_DIODE != ""} {
 ## Optionally insert a diode before routing to avoid antenna's on the ports of the block
 remove_attribute $ICC_PORT_PROTECTION_DIODE dont_use
 set ports [remove_from_collection [get_ports * -filter "direction==in"] [get_ports $ICC_PORT_PROTECTION_DIODE_EXCLUDE_PORTS]]
 insert_port_protection_diodes -prefix port_protection_diode -diode_cell [get_lib_cells $ICC_PORT_PROTECTION_DIODE] -port $ports -ignore_dont_touch
 legalize_placement
 
}





########################################
#           CONNECT P/G                #
########################################
## Connect Power & Ground for non-MV and MV-mode

 if {[file exists [which $CUSTOM_CONNECT_PG_NETS_SCRIPT]]} {
   echo "RM-Info: Sourcing [which $CUSTOM_CONNECT_PG_NETS_SCRIPT]"
   source -echo $CUSTOM_CONNECT_PG_NETS_SCRIPT
 } else {
    derive_pg_connection -power_net $MW_POWER_NET -power_pin $MW_POWER_PORT -ground_net $MW_GROUND_NET -ground_pin $MW_GROUND_PORT 
    if {!$ICC_TIE_CELL_FLOW} {derive_pg_connection -power_net $MW_POWER_NET -ground_net $MW_GROUND_NET -tie}
   }
if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }





if {$ICC_REPORTING_EFFORT == "MED" } {
 redirect -tee -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.qor {report_qor}
 redirect -tee -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.qor -append {report_qor -summary}
 # redirect -tee -file $REPORTS_DIR_PLACE_OPT/$ICC_CLOCK_OPT_PSYN_CEL.qor -append {report_timing_histogram -range_maximum 0}
 # redirect -tee -file $REPORTS_DIR_PLACE_OPT/$ICC_CLOCK_OPT_PSYN_CEL.qor -append {report_timing_histogram -range_minimum 0}
 redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.con {report_constraints}
}


if {$ICC_REPORTING_EFFORT != "OFF" } {
     redirect -tee -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.clock_tree {report_clock_tree -nosplit -summary}     ;# global skew report
     redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.clock_timing {report_clock_timing -nosplit -type skew} ;# local skew report
}
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.max.tim {report_timing -nosplit -capacitance -transition_time -input_pins -nets -delay max} 
 redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.min.tim {report_timing -nosplit -capacitance -transition_time -input_pins -nets -delay min} 
}
if {$ICC_REPORTING_EFFORT == "MED" && $POWER_OPTIMIZATION } {
 redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.power {report_power -nosplit}
}

save_mw_cel -as $ICC_CLOCK_OPT_PSYN_CEL 

## Create Snapshot and Save
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.placement_utilization.rpt {report_placement_utilization -verbose}
 create_qor_snapshot -clock_tree -name $ICC_CLOCK_OPT_PSYN_CEL
 redirect -file $REPORTS_DIR_CLOCK_OPT_PSYN/$ICC_CLOCK_OPT_PSYN_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
}
## Categorized Timing Report (CTR)
#  Use CTR in the interactive mode to view the results of create_qor_snapshot.
#  Recommended to be used with GUI opened.
#	query_qor_snapshot -display (or GUI: Timing -> Query QoR Snapshot)
#  query_qor_snapshot condenses the timing report into a cross-referencing table for quick analysis. 
#  It can be used to highlight violating paths and metric in the layout window and timing reports. 
#  CTR also provides special options to focus on top-level and hierarchical timing issues. 
#  When dealing with dirty designs, increasing the number violations per path to 20-30 when generating a snapshot can help 
#  find more issues after each run (create_qor_snapshot -max_paths 20). 
exit

