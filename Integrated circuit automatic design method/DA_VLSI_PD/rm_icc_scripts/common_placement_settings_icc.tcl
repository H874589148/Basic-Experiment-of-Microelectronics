puts "RM-Info: Running script [info script]\n"

##########################################################################################
# Version: H-2013.03-SP2 (Aug 5, 2013)
# Copyright (C) 2007-2013 Synopsys, Inc. All rights reserved.
##########################################################################################
# Placement Common Session Options - set in all sessions


## Set Min/Max Routing Layers
if { $MAX_ROUTING_LAYER != ""} {set_ignored_layers -max_routing_layer $MAX_ROUTING_LAYER}
if { $MIN_ROUTING_LAYER != ""} {set_ignored_layers -min_routing_layer $MIN_ROUTING_LAYER}

## Set PNET Options to control cel placement around P/G straps 
if {$PNET_METAL_LIST != "" || $PNET_METAL_LIST_COMPLETE != "" } {
	remove_pnet_options

	if {$PNET_METAL_LIST_COMPLETE != "" } {
		set_pnet_options -complete $PNET_METAL_LIST_COMPLETE -see_object {all_types}
	}

	if {$PNET_METAL_LIST != "" } {
		set_pnet_options -partial $PNET_METAL_LIST -see_object {all_types} 
	}
	
	report_pnet_options
}
 
## It is recommended to use the tool's default setting;
## in case it needs to be changed ( e.g. for low utlization designs), use the command below :
 # set_congestion_options -max_util 0.85

## set placer_enable_enhanced_soft_blockages true
#  Use this variable to force placement in place_opt, psynopt & refine_placement to leave
#  existing cells on soft blockage.
#  This allows the placer to move cells out of soft blockage to maintain density, 
#  but does not sweep everything out, as is done by default.


## For 20nm and below, to enable Zroute global router for DPT requirement regardless of congestion, 
#  please set the following : 
# 	set_app_var placer_congestion_effort medium             ;#force Zroute GR for congestion if on 
# 	set_app_var placer_show_zroutegr_output true            ;#force Zroute GR info to place_opt log

set_app_var enable_recovery_removal_arcs true

puts "RM-Info: Completed script [info script]\n"
