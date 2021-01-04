##########################################################################################
# Version: H-2013.03-SP2 (Aug 5, 2013)
# Copyright (C) 2007-2013 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc_setup.tcl 

########################
## route_icc: Routing ##
########################




open_mw_lib $MW_DESIGN_LIBRARY
redirect /dev/null "remove_mw_cel -version_kept 0 ${ICC_ROUTE_CEL}"
copy_mw_cel -from $ICC_CLOCK_OPT_ROUTE_CEL -to $ICC_ROUTE_CEL
open_mw_cel $ICC_ROUTE_CEL


source -echo common_optimization_settings_icc.tcl
source -echo common_placement_settings_icc.tcl
source -echo common_post_cts_timing_settings.tcl



########################################
#    LOAD THE ROUTE AND SI SETTINGS    #
########################################

source -echo common_route_si_settings_zrt_icc.tcl


####Pre route_opt checks
##Check for Ideal Nets
set num_ideal [sizeof_collection [all_ideal_nets]]
if {$num_ideal >= 1} {echo "RM-Error: $num_ideal Nets are ideal prior to route_opt. Please investigate it."}

##Check for HFNs
set hfn_thres "41 101 501"
foreach thres $hfn_thres {
  set num_hfn [sizeof_collection [all_high_fanout -nets -threshold $thres]]
  echo "RM-Info: Number of nets with fanout > $thres = $num_hfn"
  if {$thres == 501 && $num_hfn >=1} {
    echo "RM-Error: $num_hfn Nets with fanout > 500 exist prior to route_opt - Please check if marked ideal - possibly add buffer tree"
  }
}


if {$ICC_DBL_VIA } {
  ########################################
  #        Rundant via insertion         #
  ########################################

  ## Redundant via definitions should be specified in common_route_si_settings_zrt_icc.tcl or by using the ICC_CUSTOM_DBL_VIA_DEFINE_SCRIPT variable 

  ## When running redundant via insertion in MCMM mode, be aware that it works only for the current_scenario - 
  #  You can use [get_dominant scenarios] command to get critical scenarios loaded :
  #  set_active_scenarios [get_dominant_scenarios]
  
  ## To enable automatic redundant via insertion after each detail route change without the need of the standalone 
  #  insert_zrt_redundant_vias command, set the following option, otherwise, run the standalone insert_zrt_redundant_via command after routing.
  #  For 20nm consideration, if routing DRC becomes higher priority than redundant via conversion rate, set ICC_DBL_VIA_DURING_INITIAL_ROUTING to FALSE.
  #  The standalone insert_zrt_redundant_via command will be enabled after routing.
  if {$ICC_DBL_VIA_DURING_INITIAL_ROUTING} {
  	set_route_zrt_common_options -post_detail_route_redundant_via_insertion medium
  }

  ## The following are additional features if ICC_DBL_VIA_FLOW_EFFORT is set to a value other than low (default is low) :
  #  To Optimize wire length and via counts : 
  if {$ICC_DBL_VIA_FLOW_EFFORT != "LOW"} {
    	set_route_zrt_detail_options -optimize_wire_via_effort_level high ;# default is low
  }
  #  To enable concurrent redundant via insertion :
  if {$ICC_DBL_VIA_FLOW_EFFORT == "HIGH"} {
    set_route_zrt_common_options -concurrent_redundant_via_mode reserve_space ;# default is off
    set_route_zrt_common_options -concurrent_redundant_via_effort_level medium  ;# default is low; only works if the above is not off
  }

}

if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }

if {[file exists [which $CUSTOM_ROUTE_PRE_SCRIPT]]} {
echo "RM-Info: Sourcing [which $CUSTOM_ROUTE_PRE_SCRIPT]"
source $CUSTOM_ROUTE_PRE_SCRIPT
}

########################################
#       ROUTE_OPT CORE COMMAND         #
########################################

## some checks upfront 
#check_zrt_routability
report_preferred_routing_direction

## Route first the design 
  report_tlu_plus_files

  route_opt -initial_route_only 
if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }

if {$ICC_DBL_VIA && !$ICC_DBL_VIA_DURING_INITIAL_ROUTING} {
  	save_mw_cel -as route_opt_icc_pre_rv_insertion 
  	insert_zrt_redundant_vias 
  	set_route_zrt_common_options -post_detail_route_redundant_via_insertion medium
}

## For high effort ICC_DBL_VIA_FLOW_EFFORT, concurrent_redundant_via_mode is on before "route_opt -initial_route_only" and then turned off after routing
if {$ICC_DBL_VIA && $ICC_DBL_VIA_FLOW_EFFORT == "HIGH"} {
  set_route_zrt_common_options -concurrent_redundant_via_mode off
}

if {[file exists [which $CUSTOM_ROUTE_POST_SCRIPT]]} {
echo "RM-Info: Sourcing [which $CUSTOM_ROUTE_POST_SCRIPT]"
source $CUSTOM_ROUTE_POST_SCRIPT
}

if {$ICC_CTS_UPDATE_LATENCY} {
   update_clock_latency
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
    redirect -tee -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.clock_tree {report_clock_tree -nosplit -summary}     ;# global skew report
    redirect -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.clock_timing {report_clock_timing -nosplit -type skew} ;# local skew report
}
if {$ICC_REPORTING_EFFORT == "MED" } {
 redirect -tee -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.qor {report_qor}
 redirect -tee -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.qor -append {report_qor -summary}
 redirect -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.con {report_constraints}
}
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.max.tim {report_timing -nosplit -capacitance -transition_time -input_pins -nets -delay max} 
 redirect -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.min.tim {report_timing -nosplit -capacitance -transition_time -input_pins -nets -delay min} 
}

## Uncomment if you want detailed routing violation report with or without antenna info
# if {$ICC_FIX_ANTENNA} {
#    verify_zrt_route -antenna true ;
# } else {
#    verify_zrt_route -antenna false ;
#   }


save_mw_cel -as $ICC_ROUTE_CEL

if {$ICC_REPORTING_EFFORT != "OFF" } {
 create_qor_snapshot -clock_tree -name $ICC_ROUTE_CEL
 redirect -file $REPORTS_DIR_ROUTE/$ICC_ROUTE_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
}




if {$ICC_CREATE_GR_PNG} {
  if !{[info exists env(DISPLAY)]} {
  	echo "RM-Info: DISPLAY is not set. GUI snapshot will be skipped."
  } else {
  # start GUI
  gui_start
  
  # turn off DR
  gui_set_setting -window [gui_get_current_window -types Layout -mru] -setting showRoute -value false
  gui_execute_events

  # show congestion overlay
  gui_set_setting -window [gui_get_current_window -types Layout -mru] -setting mmName -value AREAPARTITION 
  gui_zoom -window [gui_get_current_window -view] -full
  gui_execute_events
  
  # save snapshots
  gui_write_window_image -window [gui_get_current_window -view -mru] -file ${REPORTS_DIR_ROUTE}/${ICC_ROUTE_CEL}.GR.png
  
  # stop GUI
  gui_stop
  }
}
exit

