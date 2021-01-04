#################################################################################
# MVRC Verification Script for
# IC Compiler Reference Methodology 
# Script: mvrc.tcl
# Version: H-2013.03-SP2 (Aug 5, 2013)
# Copyright (C) 2011 Synopsys, Inc. All rights reserved.
#################################################################################

####Enable the default behavior of sh_continue_on_error to be same as DC ####
set_app_var sh_continue_on_error true



source -echo -verbose ./rm_setup/icc_setup.tcl

   read_verilog -file $SOURCE_DIR/$DESIGN_NAME.output.pg.dc.v 

  read_power_intent -upf  $SOURCE_DIR/$DESIGN_NAME.output.upf

 create_mv_db -top ${DESIGN_NAME}

create_physical_db -top ${DESIGN_NAME}

 read_db 

 read_phydb

check_design -pgnetlist -log ${REPORTS_DIR}/${DESIGN_NAME}.mvrc_check_design.PGNETLIST.rpt


puts "RM-Info: End script [info script]\n"
exit
