##########################################################################################
# Version: H-2013.03-SP2 (Aug 5, 2013)
# Copyright (C) 2007-2013 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc_setup.tcl 

#######################################
####Outputs Script
#######################################

##Open Design
open_mw_cel $ICC_METAL_FILL_CEL -lib $MW_DESIGN_LIBRARY


##Change Names
change_names -rules verilog -hierarchy
save_mw_cel -as change_names_icc
close_mw_cel
open_mw_cel change_names_icc

##Verilog
if {$ICC_WRITE_FULL_CHIP_VERILOG} {
write_verilog -diode_ports -no_physical_only_cells $RESULTS_DIR/$DESIGN_NAME.output.v -macro_definition

## For comparison with a Design Compiler netlist,the option -diode_ports is removed
write_verilog -no_physical_only_cells $RESULTS_DIR/$DESIGN_NAME.output.dc.v -macro_definition

## For LVS use,the option -no_physical_only_cells is removed
write_verilog -diode_ports -pg $RESULTS_DIR/$DESIGN_NAME.output.pg.lvs.v -macro_definition

} else {
write_verilog -diode_ports -no_physical_only_cells $RESULTS_DIR/$DESIGN_NAME.output.v

## For comparison with a Design Compiler netlist,the option -diode_ports is removed
write_verilog -no_physical_only_cells $RESULTS_DIR/$DESIGN_NAME.output.dc.v
}

## For LVS use,the option -no_physical_only_cells is removed
write_verilog -diode_ports -pg $RESULTS_DIR/$DESIGN_NAME.output.pg.lvs.v
## Add -output_net_name_for_tie option to write_verilog command
#  if the verilog file is to be used by "eco_netlist -by_verilog_file" command in eco_icc task

## For Prime Time use,to include DCAP cells for leakage power analysis, add the option -force_output_references
#  if {$ICC_WRITE_FULL_CHIP_VERILOG} {
#  write_verilog -diode_ports -no_physical_only_cells -force_output_references [list of your DCAP cells] $RESULTS_DIR/$DESIGN_NAME.output.pt.v -macro_definition
#  } else {
#  write_verilog -diode_ports -no_physical_only_cells -force_output_references [list of your DCAP cells] $RESULTS_DIR/$DESIGN_NAME.output.pt.v
#  }

##SDC
set_app_var write_sdc_output_lumped_net_capacitance false
set_app_var write_sdc_output_net_resistance false

  write_sdc $RESULTS_DIR/$DESIGN_NAME.output.sdc

extract_rc -coupling_cap
#write_parasitics  -format SPEF -output $RESULTS_DIR/$DESIGN_NAME.output.spef
write_parasitics  -format SBPF -output $RESULTS_DIR/$DESIGN_NAME.output.sbpf

##DEF
write_def -output  $RESULTS_DIR/$DESIGN_NAME.output.def


###GDSII
##Set options - usually also include a mapping file (-map_layer)
##  set_write_stream_options \
#	-child_depth 99 \
#       -output_filling fill \
#       -output_outdated_fill \
#       -output_pin geometry \
#       -keep_data_type
#   write_stream -lib_name $MW_DESIGN_LIBRARY -format gds $RESULTS_DIR/$DESIGN_NAME.gds

if {$ICC_CREATE_MODEL } {
  save_mw_cel -as $DESIGN_NAME
  close_mw_cel
  open_mw_cel $DESIGN_NAME

  source -echo common_optimization_settings_icc.tcl
  source -echo common_placement_settings_icc.tcl
  source -echo common_post_cts_timing_settings.tcl
  source -echo common_route_si_settings_zrt_icc.tcl

  create_macro_fram
  if {$ICC_FIX_ANTENNA} {
  ##create Antenna Info
    extract_zrt_hier_antenna_property -cell_name $DESIGN_NAME
  }

  if {$ICC_CREATE_BLOCK_ABSTRACTION} {
    create_block_abstraction
    save_mw_cel
  } else {
    create_ilm -include_xtalk
  }

  ## Validating ILM using write_interface_timing and compare_interface_timing:
  #  	write_interface_timing cel.rpt
  #  	close_mw_cel
  #  	open_mw_cel $DESIGN_NAME.ILM
  #  	write_interface_timing ilm.rpt
  #  	compare_interface_timing -nosplit cel.rpt ilm.rpt -output compare_interface_timing.rpt
  #  	close_mw_cel
  #  	open_mw_cel $DESIGN_NAME

  close_mw_cel 
}
exit

