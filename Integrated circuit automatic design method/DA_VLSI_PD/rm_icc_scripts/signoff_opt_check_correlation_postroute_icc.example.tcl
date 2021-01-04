puts "RM-Info: Running script [info script]\n"

# Note:
# The following is a list of variables that will impact signoff correlation with PT and StarRC,
# To ensure the best signoff correlation result, please set them based on the recommendation below;
# otherwise, check_signoff_correlation command will report them as Errors.
# The reason why they are not turned on in ICC RM by default is they are not necessarily to be applied and may depend on specific needs.
# For further information of these variables, please refer to SolvNet #021231 "IC Compiler Correlation Checklist Trilogy"
# Here is the list of variables:
        
# set_clock_latency SDC command should be present.
# set_clock_gating_check SDC command should be enabled and set to all clocks.
# set_operating_condition should be set to on_chip_variation 
# set disable_auto_time_borrow TRUE 
# set ignore_clock_input_delay_for_skew TRUE 
# set high_fanout_net_threshold 0 
# set dont_bind_unused_pins_to_logic_constant TRUE 
# set timing_use_enhanced_capacitance_modeling TRUE 
# set si_use_partial_grounding_for_min_analysis TRUE 
# set timing_use_clock_specific_transition FALSE 
# set rc_driver_model_mode advanced 
# set rc_receiver_model_mode advanced 
# set timing_edge_specific_source_latency TRUE 
# set timing_gclock_source_network_num_master_registers 10000000 
# set timing_input_port_default_clock TRUE 
# set si_analysis_logical_correlation_mode FALSE 
# set timing_clock_gating_propagate_enable TRUE 
# set timing_input_port_clock_shift_one_cycle FALSE
# set timing_enable_non_sequential_checks TRUE

if {$PT_DIR == ""} {
  set PT_DIR [file dirname [sh which pt_shell]]
}
if {$STARRC_DIR == ""} {
  set STARRC_DIR [file dirname [sh which StarXtract]]
}
if {![file exists [which $PT_DIR/pt_shell]] || ![file exists [which $STARRC_DIR/StarXtract]]} {
  echo "RM-Info : $PT_DIR/pt_shell or $STARRC_DIR/StarXtract does not exist. check_signoff_correlation is skipped."

} else {

  if {[file exists [which $PT_SDC_FILE]]} {
    set_primetime_options  -exec_dir $PT_DIR -sdc_file $PT_SDC_FILE
  } else {
    set_primetime_options  -exec_dir $PT_DIR
  }

  if {$STARRC_MIN_NXTGRD == ""} {set STARRC_MIN_NXTGRD $STARRC_MAX_NXTGRD}
  set_starrcxt_options  -exec_dir $STARRC_DIR \
     -max_nxtgrd_file $STARRC_MAX_NXTGRD \
     -min_nxtgrd_file $STARRC_MIN_NXTGRD \
     -map_file        $STARRC_MAP_FILE

check_signoff_correlation
}

puts "RM-Info: Completed script [info script]\n"
