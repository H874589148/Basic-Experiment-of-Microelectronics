exit
_probe -file /tmp/plotU2TAKB
cross_probe -file /tmp/acG8TZTU
open_file /home/user1/simulation/user1/opamp_opamp_openloop_config_ALPS/opamp_opamp_openloop_config_Nominal.sp.sim/opamp_opamp_openloop_config_Nominal.sp.ac0
calc db(&f<0>::s<v(out)>&)
add_panel -1
calc phase(&f<0>::s<v(out)>&)
open_wave -group Doc_Not_Found,0,_calc_wfs_\(0\)
chaxis Log10
open_wave -group Doc_Not_Found,0,_calc_wfs_\(1\)
exit
