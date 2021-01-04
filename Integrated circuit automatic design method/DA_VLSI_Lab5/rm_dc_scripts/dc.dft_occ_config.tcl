puts "RM-Info: Running script [info script]\n"

#################################################################################
# Design Compiler DFT On-Chip Clocking Configuration File Reference
# Script: dc.dft_occ_config.tcl
# Version: H-2013.03 (April 15, 2013)
# Copyright (C) 2009-2013 Synopsys, Inc. All rights reserved.
#################################################################################

#################################################################################
# This file shows an example of what would be included in the occ_config.tcl file
# for a single clock controller and clock chain as Synopsys clock controller IP.
#
# Please note that this is needs to be re-written for your specific design.
#
# Please refer to the DFT Compiler Scan User Guide, Chapter 9,
# "On-Chip Clocking Support" for more information.
#################################################################################

    #############################################################################
    # On-Chip Clocking (OCC) Configuration
    #############################################################################


    # Enable the use of On-Chip Clock Controller insertion/integration capability.
    
    set_dft_configuration -clock_controller enable
    
    # Clocks
    #
    # There are three types of clocks that you need to define:
    # - Reference clock
    # - ATE clock
    # - PLL-Generated clocks

    # A Reference clock is the frequency reference to the PLL.
    #
    # To define a reference clock by using a period other than the test_default_period,
    # do not define any other signal types.

    set_dft_signal -view existing_dft -type refclock -port <my_ref_clock> -period 10 -timing {3 8}

    # If the reference clock uses the default period (100 or otherwise specified),
    # it must also be defined as MasterClock, like this:

    set_dft_signal -view existing_dft -type MasterClock -port <my_ref_clock> -timing {45 55}

    # An ATE Clock is a clock that shifts the scan chain and is used as the clock in OCC bypass mode.
    # It needs to be declared as both ScanClock and Oscillator signal types.

    set_dft_signal -view existing_dft -type ScanClock -port <my_ate_clock> -timing { 45 55 }
    set_dft_signal -view existing_dft -type Oscillator -port <my_ate_clock>

    # If you want to identify a precise hookup pin where the ATE clock signal should
    # be connected, use "set_dft_signal -view spec" with "-hookup_pin" to define the 
    # connection point.

    set_dft_signal -view spec -type ScanClock -port <my_ate_clock> -hookup_pin <U_ATE_CLOCK_PAD/Z>


    # PLL-Generated clocks are clocks that come out of the PLL.
    # There can be more than one clock.

    set_dft_signal -view existing -type Oscillator -hookup_pin <u_pll/clkgenx2>
    set_dft_signal -view existing -type Oscillator -hookup_pin <u_pll/clkgenx3>


    # Global clock controller signals
    # These signals include:
    # - OCC bypass (pll_bypass signal type)
    # - OCC Reset  (pll_reset signal type)
    # - Scan Enable signal (reused from previously defined Scan Enable)
    #

    set_dft_signal -view spec -type pll_bypass -port <my_pll_bypass>

    # Note: If asynchronous reset ports already exist in the design, they may also 
    #  perform the pll_reset function.
    # For example, if this definition has already been made in dc.tcl
    #  "set_dft_signal -view existing_dft -type Reset -port <RESET> -active 0"
    # Then add this definition (see SolvNet article 030159.html):
    #  "set_dft_signal -spec -type pll_reset -port <RESET> -active 0"
    
    # If you have followed the example above, then comment out the following:
    set_dft_signal -view spec -type pll_reset -port <my_pll_reset>

    # Test mode signal
    # This command specifies the top level TestMode signal that is
    # connected to the clock controller logic:

    set_dft_signal -view spec -type TestMode -port <my_test_mode_for_occ>

    # Configuring the OCC controller
    #
    # Options:
    #  -cell_name: The instance name of the OCC controller inserted by insert_dft.
    #
    #  -design: You must specify "snps_clk_mux" for this flow.
    #
    #  -pllclocks: Specify the name(s) of the PLL-generated clocks.
    #
    #  -ateclocks: Specify the name of the ATE Clock.
    #               NOTE: There can only be one -ateclocks argument!
    #
    #  -cycles_per_clock: Maximum number of capture cycles. The tool default is 2 and minimum should be 2.
    #
    #  -test_mode_port: The port of type TestMode used to drive the test mode pin of the clock controller logic.
    #
    #  -chain_count: Number of clock chains. The tool default is 1.
    # 
    # 

    set_dft_clock_controller \
     -cell_name pll_controller_0 \
     -design snps_clk_mux \
     -pllclocks [list  <u_pll/clkgenx2> <u_pll/clkgenx3> ] \
     -ateclocks {<my_ate_clock>} \
     -test_mode_port {<my_test_mode_for_occ>} \
     -cycles_per_clock 2 \
     -chain_count 1

    # Enable  the  use  of integrated clock-gating (ICG) cells in the
    # implementation of the on-chip clocking (OCC) controller.

    # set_app_var test_occ_insert_clock_gating_cells true

    # Specify an integrated clock-gating cell for OCC Controller clock gating logic
    #
    # You can specify one of your integrated clock-gating cells for OCC Controller
    # clock gating logic

    # Note that this is also used for serializer clock gating logic

    # set_app_var test_icg_p_ref_for_dft <library cell name>
    # set_app_var test_icg_n_ref_for_dft <library cell name>

puts "RM-Info: Completed script [info script]\n"
