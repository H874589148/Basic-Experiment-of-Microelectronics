##########################################################################################
# Version: H-2013.03-SP2 (Aug 5, 2013)
# Copyright (C) 2007-2013 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc_setup.tcl 

###################################################
## chip_finish_icc: Several chipfinishing steps  ##
###################################################




open_mw_lib $MW_DESIGN_LIBRARY
redirect /dev/null "remove_mw_cel -version_kept 0 ${ICC_METAL_FILL_CEL}"
copy_mw_cel -from $ICC_CHIP_FINISH_CEL -to $ICC_METAL_FILL_CEL
open_mw_cel $ICC_METAL_FILL_CEL



source -echo common_optimization_settings_icc.tcl
source -echo common_placement_settings_icc.tcl
source -echo common_post_cts_timing_settings.tcl
source -echo common_route_si_settings_zrt_icc.tcl 


if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }

if {$ADD_METAL_FILL != "NONE" } {
  ########################################
  #     REAL METAL FILL EXTRACTION       #
  ########################################
  ## Can be set to FLOATING|GROUNDED when required - default  = AUTO
  set_extraction_options -real_metalfill_extraction FLOATING

  if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }
}
save_mw_cel -as $ICC_METAL_FILL_CEL

## Note :
#  Use insert_metal_filler for technology nodes 65nm and above.
#  Use signoff_metal_fill for technology nodes 45nm and below.
if {$ADD_METAL_FILL == "ICC"} {
  ########################################
  #       TIMING DRIVEN METAL FILL       # 
  ########################################
  if {$ICC_METAL_FILL_TIMING_DRIVEN} {
    set_extraction_options -real_metalfill_extraction NONE
    insert_metal_filler -routing_space $ICC_METAL_FILL_SPACE -timing_driven
  } else {
    insert_metal_filler -routing_space $ICC_METAL_FILL_SPACE
  }

  set_extraction_options -real_metalfill_extraction FLOATING

  if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }
}
if {$ADD_METAL_FILL == "HERCULES" } {
  ########################################
  #      HERCULES DRIVEN METAL FILL      # 
  ########################################
  if {[file exists [which $SIGNOFF_FILL_RUNSET]] } {
    set_physical_signoff_options -exec_cmd hercules -fill_runset $SIGNOFF_FILL_RUNSET
  }
  if {$SIGNOFF_MAPFILE != ""} {set_physical_signoff_options -mapfile $SIGNOFF_MAPFILE}
  report_physical_signoff_options

  ## WA for STAR 9000440426 - Hercules - Could not open layer mapping file ../layer.map for reading,
  #  which will be fixed in ICC version 2010.12-SP5 and the WA will be removed in next RM release.
  #  WA is to use [which $SIGNOFF_MAPFILE] with -user_defined_option for HERCULES.
  if {$SIGNOFF_MAPFILE != ""} {
    signoff_metal_fill -user_defined_options "-lf [which $SIGNOFF_MAPFILE]"
  } else {
    signoff_metal_fill
  }

  set_extraction_options -real_metalfill_extraction FLOATING

  if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }
}


if {$ADD_METAL_FILL == "ICV" } {
  ########################################
  #         ICV DRIVEN METAL FILL        # 
  ########################################
  if {[file exists [which $SIGNOFF_FILL_RUNSET]] } {
    set_physical_signoff_options -exec_cmd icv -fill_runset $SIGNOFF_FILL_RUNSET
  }
  if {$SIGNOFF_MAPFILE != ""} {set_physical_signoff_options -mapfile $SIGNOFF_MAPFILE}
  report_physical_signoff_options

  if { !$SIGNOFF_METAL_FILL_TIMING_DRIVEN } {
    signoff_metal_fill 
  } else {
    set_extraction_options -real_metalfill_extraction NONE
    signoff_metal_fill -timing_preserve_setup_slack_threshold $TIMING_PRESERVE_SLACK_SETUP
  }

  set_extraction_options -real_metalfill_extraction FLOATING

  if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }
}


if {$ICC_REPORTING_EFFORT == "MED" } {
 redirect -tee -file $REPORTS_DIR_METAL_FILL/$ICC_METAL_FILL_CEL.qor {report_qor}
 redirect -tee -file $REPORTS_DIR_METAL_FILL/$ICC_METAL_FILL_CEL.qor -append {report_qor -summary}
 redirect -file $REPORTS_DIR_METAL_FILL/$ICC_METAL_FILL_CEL.con {report_constraints}
}

if {$ICC_REPORTING_EFFORT != "OFF" } {
     redirect -tee -file $REPORTS_DIR_METAL_FILL/$ICC_METAL_FILL_CEL.clock_tree {report_clock_tree -nosplit -summary}     ;# global skew report
     redirect -file $REPORTS_DIR_METAL_FILL/$ICC_METAL_FILL_CEL.clock_timing {report_clock_timing -nosplit -type skew} ;# local skew report
}
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -file $REPORTS_DIR_METAL_FILL/$ICC_METAL_FILL_CEL.max.tim {report_timing -nosplit -crosstalk_delta -capacitance -transition_time -input_pins -nets -delay max} 
 redirect -file $REPORTS_DIR_METAL_FILL/$ICC_METAL_FILL_CEL.min.tim {report_timing -nosplit -crosstalk_delta -capacitance -transition_time -input_pins -nets -delay min} 
}
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -tee -file $REPORTS_DIR_METAL_FILL/$ICC_METAL_FILL_CEL.sum {report_design_physical -all -verbose}
}


if {$ICC_REPORTING_EFFORT != "OFF" } {
 create_qor_snapshot -clock_tree -name $ICC_METAL_FILL_CEL
 redirect -file $REPORTS_DIR_METAL_FILL/$ICC_METAL_FILL_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
}

exit

