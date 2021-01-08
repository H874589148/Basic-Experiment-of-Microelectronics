#########################################################################
#
#	Change Log:
#
##########################################################################
if {[catch { package require tbcload 1.4 } err_msg ]} {
    puts "Error: $err_msg"
    puts "try to load again"
    set libtbcload_so "$env(PANDA_HOME)/../platform/$env(PLATFORM)/lib/tbcload1.4/libtbcload1.4.so"
    if {[catch { load "$libtbcload_so" tbcload } err_msg ]} {
        puts "Error: $err_msg"
    }
}

foreach f [exec find [oa::getPath [oa::LibFind $emy_currentLib]]/.tcl/callbacks -maxdepth 1 -name "*.tbc"] {
#puts $f
source $f
}
foreach f [exec find [oa::getPath [oa::LibFind $emy_currentLib]]/.tcl/support/Empyrean -maxdepth 1 -name "*.tbc"] {
#puts $f
source $f
}
foreach f [exec find [oa::getPath [oa::LibFind $emy_currentLib]]/.tcl/support/Empyrean -maxdepth 1 -name "*.tcl"] {
#puts $f
source $f
}
foreach f [exec find [oa::getPath [oa::LibFind $emy_currentLib]]/.tcl/callbacks -maxdepth 1 -name "*.tcl"] {
#puts $f
source $f
}

#source [oa::getPath [oa::LibFind $emy_currentLib]]/../.empyrean/.common/abutProcedures.tcl

###################################################################################
# emp_getPDKVersion is a procedure gives the information about the version of the of the PDK
#
# Outputs:
# ---------
# Prints the PDK library name, Version and release date on console
#
###################################################################################
proc emp_getPDKVersion { lib} {
    puts "\t#######################################"
    puts "\tPDK Library Name\t: $lib"
    puts "\tPDK Version\t\t: 2.0 (ePDK)"
    puts "\tPDK Release Date\t: 9-Jan 2012 "
    puts "\t#######################################\n"
}

emp_getPDKVersion $emy_currentLib
