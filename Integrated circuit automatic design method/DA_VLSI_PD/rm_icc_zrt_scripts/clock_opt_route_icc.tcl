##########################################################################################
# Version: H-2013.03-SP2 (Aug 5, 2013)
# Copyright (C) 2007-2013 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc_setup.tcl 

#############################################
## clock_opt_route_icc: CLock Tree routing ##
#############################################


 
open_mw_lib $MW_DESIGN_LIBRARY
redirect /dev/null "remove_mw_cel -version_kept 0 ${ICC_CLOCK_OPT_ROUTE_CEL}"
copy_mw_cel -from $ICC_CLOCK_OPT_PSYN_CEL -to $ICC_CLOCK_OPT_ROUTE_CEL
open_mw_cel $ICC_CLOCK_OPT_ROUTE_CEL




## Optimization Common Session Options - set in all sessions
source -echo common_optimization_settings_icc.tcl
source -echo common_placement_settings_icc.tcl



## Source CTS Options 
source -echo common_cts_settings_icc.tcl

## Source Post CTS Options
source -echo common_post_cts_timing_settings.tcl

## Source Route Options
source common_route_si_settings_zrt_icc.tcl
## Turning off SI for clock routing
set_si_options -delta_delay false -min_delta_delay false -route_xtalk_prevention false




if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }

if {[file exists [which $CUSTOM_CLOCK_OPT_ROUTE_PRE_SCRIPT]]} {
echo "RM-Info: Sourcing [which $CUSTOM_CLOCK_OPT_ROUTE_PRE_SCRIPT]"
source $CUSTOM_CLOCK_OPT_ROUTE_PRE_SCRIPT
}

##################################
#       CLOCK ROUTING            #
##################################
# set_delay_calculation_options -routed_clock arnoldi
route_zrt_group -all_clock_nets -reuse_existing_global_route true

if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }

## For additional psynopt after clock nets are routed, try the following :
#extract_rc -force
#update_timing
#set_dont_touch_placement [get_cells -of [get_flat_pins [all_fanout -flat -from [get_attribute [get_clocks *] sources]] -filter pin_on_clock_network==true]]
#set psynopt_cmd "psynopt -area_recovery"
#if {$POWER_OPTIMIZATION} {lappend psynopt_cmd -power}
#echo $psynopt_cmd
#eval $psynopt_cmd  

if {[file exists [which $CUSTOM_CLOCK_OPT_ROUTE_PRE_CTO_SCRIPT]]} {
echo "RM-Info: Sourcing [which $CUSTOM_CLOCK_OPT_ROUTE_PRE_CTO_SCRIPT]"
source $CUSTOM_CLOCK_OPT_ROUTE_PRE_CTO_SCRIPT
}

if {$ICC_POST_CLOCK_ROUTE_CTO} {
optimize_clock_tree -routed_clock_stage detail 
}
if {$ICC_CTS_SHIELD_RULE_NAME != ""} {
## Generate clock shielding wires
#  Note: if routing resource is a concern, consider to run these at chip_finish_icc step instead
create_zrt_shield
set_route_zrt_common_options -reshield_modified_nets reshield
set_extraction_options -virtual_shield_extraction false
}
if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }


if {[file exists [which $CUSTOM_CLOCK_OPT_ROUTE_POST_CTO_SCRIPT]]} {
echo "RM-Info: Sourcing [which $CUSTOM_CLOCK_OPT_ROUTE_POST_CTO_SCRIPT]"
source $CUSTOM_CLOCK_OPT_ROUTE_POST_CTO_SCRIPT
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

if {$ICC_REPORTING_EFFORT != "OFF" } {
     redirect -tee -file $REPORTS_DIR_CLOCK_OPT_ROUTE/$ICC_CLOCK_OPT_ROUTE_CEL.clock_tree {report_clock_tree -nosplit -summary}     ;# global skew report
     redirect -file $REPORTS_DIR_CLOCK_OPT_ROUTE/$ICC_CLOCK_OPT_ROUTE_CEL.clock_timing {report_clock_timing -nosplit -type skew} ;# local skew report
}

if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -file $REPORTS_DIR_CLOCK_OPT_ROUTE/$ICC_CLOCK_OPT_ROUTE_CEL.max.tim {report_timing -nosplit -capacitance -transition_time -input_pins -nets -delay max} 
 redirect -file $REPORTS_DIR_CLOCK_OPT_ROUTE/$ICC_CLOCK_OPT_ROUTE_CEL.min.tim {report_timing -nosplit -capacitance -transition_time -input_pins -nets -delay min} 
}

if {$ICC_REPORTING_EFFORT == "MED" } {
 redirect -tee -file $REPORTS_DIR_CLOCK_OPT_ROUTE/$ICC_CLOCK_OPT_ROUTE_CEL.qor {report_qor}
 redirect -tee -file $REPORTS_DIR_CLOCK_OPT_ROUTE/$ICC_CLOCK_OPT_ROUTE_CEL.qor -append {report_qor -summary}
 redirect -file $REPORTS_DIR_CLOCK_OPT_ROUTE/$ICC_CLOCK_OPT_ROUTE_CEL.con {report_constraints}
}

save_mw_cel -as $ICC_CLOCK_OPT_ROUTE_CEL 

if {$ICC_REPORTING_EFFORT != "OFF" } {
 create_qor_snapshot -clock_tree -name $ICC_CLOCK_OPT_ROUTE_CEL
 redirect -file $REPORTS_DIR_CLOCK_OPT_ROUTE/$ICC_CLOCK_OPT_ROUTE_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
}


exit

