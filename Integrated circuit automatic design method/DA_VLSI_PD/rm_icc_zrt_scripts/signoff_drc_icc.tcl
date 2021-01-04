##########################################################################################
# Version: H-2013.03-SP2 (Aug 5, 2013)
# Copyright (C) 2007-2013 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc_setup.tcl 

open_mw_cel $ICC_METAL_FILL_CEL -lib $MW_DESIGN_LIBRARY

  ########################
  #     SIGNOFF DRC      #
  ########################

if {[file exists [which $SIGNOFF_DRC_RUNSET]] } {

  if {$SIGNOFF_DRC_ENGINE == "HERCULES"} {
    set_physical_signoff_options -exec_cmd hercules -drc_runset $SIGNOFF_DRC_RUNSET
  } elseif { $SIGNOFF_DRC_ENGINE == "ICV"} {
    set_physical_signoff_options -exec_cmd icv -drc_runset $SIGNOFF_DRC_RUNSET
    }

  ## WA for STAR 9000440426 - Hercules - Could not open layer mapping file ../layer.map for reading,
  #  which will be fixed in ICC version 2010.12-SP5 and the WA will be removed in next RM release.
  #  WA is to use [which $SIGNOFF_MAPFILE] for HERCULES, the "which" ensures full path is used.
  if {$SIGNOFF_MAPFILE != "" && $SIGNOFF_DRC_ENGINE != "HERCULES"} {
    set_physical_signoff_options -mapfile $SIGNOFF_MAPFILE
  }
  if {$SIGNOFF_MAPFILE != "" && $SIGNOFF_DRC_ENGINE == "HERCULES"} {
    set_physical_signoff_options -mapfile [which $SIGNOFF_MAPFILE]
  }

  report_physical_signoff_options
  signoff_drc

}
      ## Auto DRC Repair (ADR)
      #  When routing DRC is within a reasonable range, you can perform ADR to resolve remaining DRC
      #  Please refer to SolvNet #031882 for more information and how to generate config file for signoff_autofix_drc command

      #  signoff_drc -run_dir {./signoff_drc_run} -ignore_child_cell_errors -read_cel_view 
      #  signoff_autofix_drc -incremental_level high -config_file $config_file -init_drc_error_db signoff_drc_run 
      #  save_mw_cel 
      #  signoff_drc -run_dir {./signoff_drc_run_after} -ignore_child_cell_errors -read_cel_view

exit

