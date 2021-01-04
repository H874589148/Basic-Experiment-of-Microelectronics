#set_operating_conditions -analysis_type bc_wc

# set clock signal name you used in the design 
set my_clock_pin   clk

# set the clock frequency
set my_clk_freq_MHz 500


set my_period [expr 1000 / $my_clk_freq_MHz]

set find_clock [ find port [list $my_clock_pin] ]
if {  $find_clock != [list] } {
   set clk_name $my_clock_pin
   create_clock -period $my_period $clk_name
} else {
   set clk_name vclk
   create_clock -period $my_period -name $clk_name

   # set a delay constraint for combinatioal circuits
   set_max_delay $my_period -from [all_input] -to [all_output]
}

set clock_uncertainty 0.1

set input_delay 0.5
set output_delay 0.5
