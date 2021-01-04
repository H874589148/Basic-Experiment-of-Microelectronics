##########################################################################################
# Version: H-2013.03-SP2 (Aug 5, 2013)
# Copyright (C) 2007-2013 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc_setup.tcl 

#######################################
#            ECO Script
#######################################
##Open Design
open_mw_lib $MW_DESIGN_LIBRARY

redirect /dev/null "remove_mw_cel -version_kept 0 $ICC_ECO_CEL"
copy_mw_cel -from $ICC_ECO_STARTING_CEL -to $ICC_ECO_CEL
open_mw_cel $ICC_ECO_CEL

source -echo common_optimization_settings_icc.tcl
source -echo common_placement_settings_icc.tcl
source -echo common_post_cts_timing_settings.tcl
source -echo common_route_si_settings_zrt_icc.tcl

#######################################
# Unconstrained ECO Flow
#######################################
if {$ICC_ECO_FLOW == "UNCONSTRAINED"} {

  echo "RM-Info: starting the UNCONSTRAINED ECO flow, executing the ECO steps"
  
  if {[file exists [which $ICC_ECO_FILE]]} {

    ## Read ECO file
    if {$ICC_ECO_FLOW_TYPE == "verilog"} {
      ## For functional ECO :
      eco_netlist -compare_pg -by_verilog_file $ICC_ECO_FILE
    }

    if {$ICC_ECO_FLOW_TYPE == "pt_drc_setup_fixing_tcl"} {
      ## For DRC/Setup fixing ECO :
      #  ECO file is typically from PT generated change file by fix_eco_drc OR fix_eco_timing -setup commands
      eco_netlist -by_tcl_file $ICC_ECO_FILE
    }

    if {$ICC_ECO_FLOW_TYPE == "pt_hold_fixing_tcl"} {
      ## For Hold fixing ECO :
      #  ECO file is typically from PT generated change file by fix_eco_timing -hold command
      eco_netlist -by_tcl_file $ICC_ECO_FILE
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


    ## Place ECO cells
    if {$ICC_ECO_FLOW_TYPE == "verilog"} {
      ## For functional ECO :
      if {$ADD_FILLER_CELL} {
        place_eco_cells -eco_changed_cells -remove_filler_references "$FILLER_CELL_METAL $FILLER_CELL"
      } else {
        place_eco_cells -eco_changed_cells
      }
    }

    if {$ICC_ECO_FLOW_TYPE == "pt_drc_setup_fixing_tcl"} {
      ## For DRC/Setup fixing ECO :
      #  ECO file is typically from PT generated change file by fix_eco_drc OR fix_eco_timing -setup commands
      set drcbuffer [get_cells -hier -filter "eco_change_status==insert_buffer"]
      place_eco_cells -cells $drcbuffer -no_legalize
      if {$ADD_FILLER_CELL} {
        place_eco_cells -eco_changed_cells -legalize_only -remove_filler_references "$FILLER_CELL_METAL $FILLER_CELL"
      } else {
        place_eco_cells -eco_changed_cells -legalize_only
      }
    }

    if {$ICC_ECO_FLOW_TYPE == "pt_hold_fixing_tcl"} {
      ## For Hold fixing ECO :
      #  ECO file is typically from PT generated change file by fix_eco_timing -hold command
      if {$ADD_FILLER_CELL} {
        place_eco_cells -eco_changed_cells -legalize_only -remove_filler_references "$FILLER_CELL_METAL $FILLER_CELL"
      } else {
        place_eco_cells -eco_changed_cells -legalize_only
      }
    }


  ## Insert fillers
    if {$FILLER_CELL_METAL != ""} {insert_stdcell_filler -cell_with_metal $FILLER_CELL_METAL -connect_to_power $MW_POWER_NET -connect_to_ground $MW_GROUND_NET}
    if {$FILLER_CELL != ""} {insert_stdcell_filler -cell_without_metal $FILLER_CELL -connect_to_power $MW_POWER_NET -connect_to_ground $MW_GROUND_NET}


    ## ECO route    
    #  Pease refer to SolvNet #029833 for more information
    set_route_zrt_global_options -timing_driven false -crosstalk_driven false
    set_route_zrt_track_options -timing_driven false -crosstalk_driven false
    set_route_zrt_detail_options -timing_driven false
    # set_route_zrt_common_options -reshield_modified_nets reshield
    route_zrt_eco -reroute modified_nets_first_then_others

    if {$ICC_ECO_METAL_FILL_MODE == "early_stage"} {

      ## DRC based metal fill removal
      if {$ADD_METAL_FILL == "ICV" } {
        set_extraction_options -real_metalfill_extraction FLOATING
      
        if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }
        save_mw_cel -as ${ICC_ECO_CEL}_metal_fill

        if {[file exists [which $SIGNOFF_FILL_RUNSET]] } {
          set_physical_signoff_options -exec_cmd icv -fill_runset $SIGNOFF_FILL_RUNSET
        }
      
        if {$SIGNOFF_MAPFILE != ""} {set_physical_signoff_options -mapfile $SIGNOFF_MAPFILE}

        report_physical_signoff_options  

        signoff_metal_fill -remove_overlap_by_rules min_spacing
      }

    } else {

      ## Purge metal fill
      if {$ADD_METAL_FILL == "ICV" } {
        set_extraction_options -real_metalfill_extraction FLOATING
      
        if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }
        save_mw_cel -as ${ICC_ECO_CEL}_metal_fill

        if {[file exists [which $SIGNOFF_FILL_RUNSET]] } {
          set_physical_signoff_options -exec_cmd icv -fill_runset $SIGNOFF_FILL_RUNSET
        }
      
        if {$SIGNOFF_MAPFILE != ""} {set_physical_signoff_options -mapfile $SIGNOFF_MAPFILE}

        report_physical_signoff_options  

        signoff_metal_fill -purge
      }

      ## Auto DRC Repair (ADR)
      #  When routing DRC is within a reasonable range, you can perform ADR to resolve remaining DRC
      #  Please refer to SolvNet #031882 for more information and how to generate config file for signoff_autofix_drc command

      #  signoff_drc -user_defined_options {-holding_cell} -run_dir {./signoff_drc_run} -ignore_child_cell_errors -read_cel_view 
      #  signoff_autofix_drc -incremental_level high -config_file $config_file -init_drc_error_db signoff_drc_run 
      #  save_mw_cel 
      #  signoff_drc -user_defined_options {-holding_cell} -run_dir {./signoff_drc_run_after} -ignore_child_cell_errors -read_cel_view

      ## Insert metal fill
      if {$ADD_METAL_FILL == "ICV" } {
        signoff_metal_fill 
      
        set_extraction_options -real_metalfill_extraction FLOATING
      
        if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }
      }

    }

  } else {
    echo "RM-Error : ECO can't be performed as $ICC_ECO_FILE is not found ..."
  }
}

#######################################
# Freeze Silicon ECO Flow
#######################################
if {$ICC_ECO_FLOW == "FREEZE_SILICON"} {
  
  echo "RM-Info: starting the Freeze Silicon ECO flow, executing the ECO steps"
  
  if {[file exists [which $ICC_ECO_FILE]]} {

    eco_netlist -compare_pg -freeze_silicon -by_verilog_file $ICC_ECO_FILE

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

    place_freeze_silicon

    set_route_zrt_global_options -timing_driven false -crosstalk_driven false
    set_route_zrt_track_options -timing_driven false -crosstalk_driven false
    set_route_zrt_detail_options -timing_driven false
    route_zrt_eco

  } else {
    echo "RM-Error : ECO can't be performed as $ICC_ECO_FILE is not found ..."
  }
}



if {$ICC_REPORTING_EFFORT != "OFF" } {
    redirect -tee -file $REPORTS_DIR_ECO/$ICC_ECO_CEL.clock_tree {report_clock_tree -nosplit -summary}     ;# global skew report
    redirect -file $REPORTS_DIR_ECO/$ICC_ECO_CEL.clock_timing {report_clock_timing -nosplit -type skew} ;# local skew report
}
if {$ICC_REPORTING_EFFORT == "MED" } {
 redirect -tee -file $REPORTS_DIR_ECO/$ICC_ECO_CEL.qor {report_qor}
 redirect -tee -file $REPORTS_DIR_ECO/$ICC_ECO_CEL.qor -append {report_qor -summary}
 redirect -file $REPORTS_DIR_ECO/$ICC_ECO_CEL.con {report_constraints}
}
if {$ICC_REPORTING_EFFORT != "OFF" } {
 redirect -file $REPORTS_DIR_ECO/$ICC_ECO_CEL.max.tim {report_timing -nosplit -capacitance -transition_time -input_pins -nets -delay max} 
 redirect -file $REPORTS_DIR_ECO/$ICC_ECO_CEL.min.tim {report_timing -nosplit -capacitance -transition_time -input_pins -nets -delay min} 
}

save_mw_cel -as $ICC_ECO_CEL

if {$ICC_REPORTING_EFFORT != "OFF" } {
  create_qor_snapshot -clock_tree -name $ICC_ECO_CEL
  redirect -file $REPORTS_DIR_ECO/$ICC_ECO_CEL.qor_snapshot.rpt {report_qor_snapshot -no_display}
}



exit

