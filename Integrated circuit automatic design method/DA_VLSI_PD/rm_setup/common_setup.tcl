puts "RM-Info: Running script [info script]\n"

##########################################################################################
# Variables common to all reference methodology scripts
# Script: common_setup.tcl
# Version: H-2013.03 (April 15, 2013)
# Copyright (C) 2007-2013 Synopsys, Inc. All rights reserved.
##########################################################################################

set DESIGN_NAME                   "picorv32"  ;#  The name of the top-level design

set DESIGN_REF_DATA_PATH          "~/DA_VLSI_PD"  ;#  Absolute path prefix variable for library/design data.
                                       #  Use this variable to prefix the common absolute path  
                                       #  to the common variables defined below.
                                       #  Absolute paths are mandatory for hierarchical 
                                       #  reference methodology flow.
set DESIGN_INSTANCE			"testbench.uut"	;#  The Design Instance Name for read_saif
##########################################################################################
# Hierarchical Flow Design Variables
##########################################################################################

set HIERARCHICAL_DESIGNS           "" ;# List of hierarchical block design names "DesignA DesignB" ...
set HIERARCHICAL_CELLS             "" ;# List of hierarchical block cell instance names "u_DesignA u_DesignB" ...

##########################################################################################
# Library Setup Variables
##########################################################################################

# For the following variables, use a blank space to separate multiple entries.
# Example: set TARGET_LIBRARY_FILES "lib1.db lib2.db lib3.db"

set DESIGN_REF_PATH		  "/js1/songch/SAED32_EDK/lib"
set DESIGN_REF_NLDMA_PATH          "${DESIGN_REF_PATH}/stdcell_rvt"
set DESIGN_REF_NLDMB_PATH          "${DESIGN_REF_PATH}/stdcell_lvt"
set DESIGN_REF_NLDMC_PATH          "${DESIGN_REF_PATH}/stdcell_hvt"
set DESIGN_REF_RAMSA_PATH          "${DESIGN_REF_PATH}/sram"
set DESIGN_REF_RAMSB_PATH          "${DESIGN_REF_PATH}/sram_lp"
set DESIGN_REF_PLL_PATH           "${DESIGN_REF_PATH}/pll"
set DESIGN_REF_PADSA_PATH          "${DESIGN_REF_PATH}/io_std"
set DESIGN_REF_PADSB_PATH          "${DESIGN_REF_PATH}/io_sp"
set DESIGN_REF_TECH_PATH          "/js1/songch/SAED32_EDK/references/orca/dc/models"


#set ADDITIONAL_SEARCH_PATH        ""  ;#  Additional search path to be added to the default search path
set ADDITIONAL_SEARCH_PATH      " \
        ${DESIGN_REF_NLDMA_PATH}/db_nldm \
        ${DESIGN_REF_NLDMB_PATH}/db_nldm \
        ${DESIGN_REF_NLDMC_PATH}/db_nldm \
        ${DESIGN_REF_RAMSA_PATH}/db_nldm \
        ${DESIGN_REF_RAMSB_PATH}/db_nldm \
	${DESIGN_REF_PLL_PATH}/db_nldm \
	${DESIGN_REF_PADSA_PATH}/db_nldm \
	${DESIGN_REF_PADSB_PATH}/db_nldm \
	${DESIGN_REF_DATA_PATH}/results \
	${DESIGN_REF_TECH_PATH} \
        ${DESIGN_REF_DATA_PATH}/verilog \
        /js1/songch/SAED32_EDK/references/orca/icc/models \
	"

set TARGET_LIBRARY_FILES          "saed32rvt_tt1p05v125c.db saed32hvt_tt1p05v125c.db saed32lvt_tt1p05v125c.db" ;#  Target technology logical libraries
set ADDITIONAL_LINK_LIB_FILES     ""  ;#  Extra link logical libraries not included in TARGET_LIBRARY_FILES

set MIN_LIBRARY_FILES             ""  ;#  List of max min library pairs "max1 min1 max2 min2 max3 min3"...

#set MW_REFERENCE_LIB_DIRS         ""  ;#  Milkyway reference libraries (include IC Compiler ILMs here)
set MW_REFERENCE_LIB_DIRS  " \
	${DESIGN_REF_NLDMA_PATH}/milkyway/saed32nm_rvt_1p9m \
	${DESIGN_REF_NLDMB_PATH}/milkyway/saed32nm_lvt_1p9m \
	${DESIGN_REF_NLDMC_PATH}/milkyway/saed32nm_hvt_1p9m \
	"

set MW_REFERENCE_CONTROL_FILE     ""  ;#  Reference Control file to define the Milkyway reference libs

#set TECH_FILE                     ""  ;#  Milkyway technology file
#set MAP_FILE                      ""  ;#  Mapping file for TLUplus
#set TLUPLUS_MAX_FILE              ""  ;#  Max TLUplus file
#set TLUPLUS_MIN_FILE              ""  ;#  Min TLUplus file

set TECH_FILE        "/js1/songch/SAED32_EDK/references/orca/icc/ref/tech/saed32nm_1p9m_mw.tf"
set MAP_FILE         "/js1/songch/SAED32_EDK/references/orca/icc/ref/tlup/saed32nm_tf_itf_tluplus.map"
set TLUPLUS_MAX_FILE "/js1/songch/SAED32_EDK/references/orca/icc/ref/tlup/saed32nm_1p9m_Cmax.tluplus"
set TLUPLUS_MIN_FILE "/js1/songch/SAED32_EDK/references/orca/icc/ref/tlup/saed32nm_1p9m_Cmin.tluplus"

set MW_POWER_NET                "VDD" ;#
set MW_POWER_PORT               "VDD" ;#
set MW_GROUND_NET               "VSS" ;#
set MW_GROUND_PORT              "VSS" ;#

set MIN_ROUTING_LAYER            "M1"   ;# Min routing layer
set MAX_ROUTING_LAYER            "M8"   ;# Max routing layer

set LIBRARY_DONT_USE_FILE        ""   ;# Tcl file with library modifications for dont_use

##########################################################################################
# Multivoltage Common Variables
#
# Define the following multivoltage common variables for the reference methodology scripts 
# for multivoltage flows. 
# Use as few or as many of the following definitions as needed by your design.
##########################################################################################

set PD1                          ""           ;# Name of power domain/voltage area  1
set VA1_COORDINATES              {}           ;# Coordinates for voltage area 1
set MW_POWER_NET1                "VDD1"       ;# Power net for voltage area 1

set PD2                          ""           ;# Name of power domain/voltage area  2
set VA2_COORDINATES              {}           ;# Coordinates for voltage area 2
set MW_POWER_NET2                "VDD2"       ;# Power net for voltage area 2

set PD3                          ""           ;# Name of power domain/voltage area  3
set VA3_COORDINATES              {}           ;# Coordinates for voltage area 3
set MW_POWER_NET3                "VDD3"       ;# Power net for voltage area 3

set PD4                          ""           ;# Name of power domain/voltage area  4
set VA4_COORDINATES              {}           ;# Coordinates for voltage area 4
set MW_POWER_NET4                "VDD4"       ;# Power net for voltage area 4

puts "RM-Info: Completed script [info script]\n"

