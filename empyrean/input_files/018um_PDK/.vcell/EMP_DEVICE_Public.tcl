###############################################################################
proc EMP_DEVICE_grid {val grid} {
   return [expr floor(($val + 0.5 * $grid) / $grid) * $grid]
}

#******************************************************************************
proc EMP_DEVICE_min { a b } {
    if { $a > $b } {
        return $b
    } else {
        return $a
    }
}
#******************************************************************************
proc EMP_DEVICE_max { a b } {
    if { $a > $b } {
        return $a
    } else {
        return $b
    }
}

#******************************************************************************

proc draw_act_default {act_box width_i gate_align contact_rule diff_layer diff_pur metal_layer metal_pur ct_layer ct_pur i Fingers minOd2PolySpace middle_contact_type minGrid} {
    set design [getCurDesign]

# act
    set contact_rule_list [lindex $contact_rule 0]
    set contact_mode [lindex $contact_rule_list 0]
    set align [lindex $contact_rule_list 1]
    set minCo2GateSpace [lindex $contact_rule_list 2]
    set contact_row [lindex $contact_rule_list 3]
    set contact_column [lindex $contact_rule_list 4]
    set minCoWidth_H [lindex $contact_rule_list 5]
    set minCoWidth_V [lindex $contact_rule_list 6]
    set minCoSpace_H [lindex $contact_rule_list 7]
    set minCoSpace_V [lindex $contact_rule_list 8]
    set minCo2MetEnclosure_H [lindex $contact_rule_list 9]
    set minCo2MetEnclosure_V [lindex $contact_rule_list 10]
    set minCo2OdEnclosure_H [lindex $contact_rule_list 11]
    set minCo2OdEnclosure_V [lindex $contact_rule_list 12]
    
    set diff_l [lindex $act_box 0]
    set diff_b [lindex $act_box 1]
    set diff_r [lindex $act_box 2]
    set diff_t [lindex $act_box 3]
    set str_l 0
    set str_b 0
    set str_r 0
    set str_t 0
    set dx1 0
    set dy1 0
    set dx2 0
    set dy2 0
    set dx3 0
    set dy3 0
    set dx4 0
    set dy4 0

    set box_height [expr $diff_t - $diff_b]
    set t_ext [expr $width_i - $box_height]
    
    set contact_width_V [expr ($contact_row - 1.0) * ($minCoWidth_V + $minCoSpace_V) + $minCo2OdEnclosure_V * 2.0 + $minCoWidth_V]
    set one_contact_width_V [expr $minCoWidth_V  + $minCo2OdEnclosure_V * 2.0]


    if { $i == 0 } {
        set dx2 [expr $dx2 - $minOd2PolySpace]
        set dx3 [expr $dx3 - $minOd2PolySpace]
    } elseif { $i == $Fingers } {
        set dx1 [expr $dx1 + $minOd2PolySpace]
        set dx4 [expr $dx4 + $minOd2PolySpace]
    } else {
        set dx2 [expr $dx2 - $minOd2PolySpace]
        set dx3 [expr $dx3 - $minOd2PolySpace]
        set dx1 [expr $dx1 + $minOd2PolySpace]
        set dx4 [expr $dx4 + $minOd2PolySpace]
    }
    if { $i != 0 && $i != $Fingers } {
        if { $gate_align == -1 } {
            if {$width_i > $box_height} {
                set str_t [expr $str_t + $t_ext]
            }
            set dy3 [expr $dy3 + $t_ext]
        } elseif { $gate_align == 1 } {
            if {$width_i > $box_height} {
                set str_b [expr $str_b - $t_ext]
            }
            set dy2 [expr $dy2 - $t_ext]
        } else {
            set str_align_middle [EMP_DEVICE_grid [expr ($width_i - $box_height) / 2.0] $minGrid]
            if {$width_i > $box_height} {
                set str_t [expr $str_t + $t_ext - $str_align_middle]
                set str_b [expr $str_b - $str_align_middle]
            }
            set dy3 [expr $dy3 + $t_ext - $str_align_middle]
            set dy2 [expr $dy2 - $str_align_middle]
        }
    }
    if { $middle_contact_type != 0 || $i == 0 || $i == $Fingers } {
        if { $contact_mode == 3 } {
            if { $contact_width_V > $width_i && $contact_width_V > $box_height } {
                set act_ext [expr $contact_width_V - [EMP_DEVICE_max $box_height $width_i]]
                set act_ext_b [EMP_DEVICE_grid [expr $act_ext / 2.0] $minGrid]
                set str_t [expr $str_t + $act_ext - $act_ext_b]
                set str_b [expr $str_b - $act_ext_b]
            }
        } else {
            if { $one_contact_width_V > $width_i && $one_contact_width_V > $box_height } {
                set act_ext [expr $one_contact_width_V - [EMP_DEVICE_max $box_height $width_i]]
                set act_ext_b [EMP_DEVICE_grid [expr $act_ext / 2.0] $minGrid]
                set str_t [expr $str_t + $act_ext - $act_ext_b]
                set str_b [expr $str_b - $act_ext_b]
            }
        }
    }

    set l [expr $diff_l ]
    set b [expr $diff_b + $str_b]
    set r [expr $diff_r ]
    set t [expr $diff_t + $str_t]
    
    set dy1 [expr $dy1 - $str_b]
    set dy2 [expr $dy2 - $str_b]
    set dy3 [expr $dy3 - $str_t]
    set dy4 [expr $dy4 - $str_t]
    
    set diff_str_i {} 
    lappend diff_str_i $i
    lappend diff_str_i $l
    lappend diff_str_i $b
    lappend diff_str_i $r
    lappend diff_str_i $t
    lappend diff_str_i $dx1
    lappend diff_str_i $dy1
    lappend diff_str_i $dx2
    lappend diff_str_i $dy2
    lappend diff_str_i $dx3
    lappend diff_str_i $dy3
    lappend diff_str_i $dx4
    lappend diff_str_i $dy4
    

    set diff [draw_act_by_list $diff_str_i $diff_layer $diff_pur]

# metal & cont
    set contact_mode [lindex $contact_rule_list 0]
    if { $i != 0 && $i != $Fingers && $middle_contact_type == 0 } {
        set contact_mode 0
    } 
    if { $contact_mode != 0 } {
        set metal_box [draw_cont_default $diff_str_i $Fingers $contact_rule $ct_layer $ct_pur $metal_layer $metal_pur $minGrid]
    }
    return $diff
}

proc draw_act_by_list { diff_str_i diff_layer diff_pur} {
    set design [getCurDesign]
# act
    set i [lindex $diff_str_i 0]
    set l [lindex $diff_str_i 1]
    set b [lindex $diff_str_i 2]
    set r [lindex $diff_str_i 3]
    set t [lindex $diff_str_i 4]

    set dx1 [lindex $diff_str_i 5]
    set dy1 [lindex $diff_str_i 6]
    set dx2 [lindex $diff_str_i 7]
    set dy2 [lindex $diff_str_i 8]
    set dx3 [lindex $diff_str_i 9]
    set dy3 [lindex $diff_str_i 10]
    set dx4 [lindex $diff_str_i 11]
    set dy4 [lindex $diff_str_i 12]

    set point1_x [expr $l + $dx1]
    set point1_y $b
    set point2_x [expr $l + $dx1]
    set point2_y [expr $b + $dy1]
    set point3_x $l
    set point3_y [expr $b + $dy1]
    set point4_x $l
    set point4_y [expr $t + $dy4]
    set point5_x [expr $l + $dx4]
    set point5_y [expr $t + $dy4]
    set point6_x [expr $l + $dx4]
    set point6_y $t
    set point7_x [expr $r + $dx3]
    set point7_y $t
    set point8_x [expr $r + $dx3]
    set point8_y [expr $t + $dy3]
    set point9_x $r
    set point9_y [expr $t + $dy3]
    set point10_x $r
    set point10_y [expr $b + $dy2]
    set point11_x [expr $r + $dx2]
    set point11_y [expr $b + $dy2]
    set point12_x [expr $r + $dx2]
    set point12_y $b
 
    set diff [dbCrtPolygon -cv $design -points "($point1_x $point1_y) ($point2_x $point2_y) ($point3_x $point3_y) ($point4_x $point4_y) ($point5_x $point5_y) ($point6_x $point6_y) ($point7_x $point7_y) ($point8_x $point8_y) ($point9_x $point9_y) ($point10_x $point10_y) ($point11_x $point11_y) ($point12_x $point12_y)" -layer $diff_layer -purpose $diff_pur]
    dbCrtHandle -param "diff_str" -value "{$i $l $b $r $t $dx1 $dy1 $dx2 $dy2 $dx3 $dy3 $dx4 $dy4}" -shape $diff
    return $diff
}


proc draw_cont_default { diff_str_i Fingers contact_rule ct_layer ct_pur metal_layer metal_pur minGrid} {
    
    set design [getCurDesign]
    set contact_rule_list [lindex $contact_rule 0]
    set contact_mode [lindex $contact_rule_list 0]
    set align [lindex $contact_rule_list 1]
    set minCo2GateSpace [lindex $contact_rule_list 2]
    set contact_row [lindex $contact_rule_list 3]
    set contact_column [lindex $contact_rule_list 4]
    set minCoWidth_H [lindex $contact_rule_list 5]
    set minCoWidth_V [lindex $contact_rule_list 6]
    set minCoSpace_H [lindex $contact_rule_list 7]
    set minCoSpace_V [lindex $contact_rule_list 8]
    set minCo2MetEnclosure_H [lindex $contact_rule_list 9]
    set minCo2MetEnclosure_V [lindex $contact_rule_list 10]
    set minCo2OdEnclosure_H [lindex $contact_rule_list 11]
    set minCo2OdEnclosure_V [lindex $contact_rule_list 12]

    set i [lindex $diff_str_i 0]
    set l [lindex $diff_str_i 1]
    set b [lindex $diff_str_i 2]
    set r [lindex $diff_str_i 3]
    set t [lindex $diff_str_i 4]

    set dx1 [lindex $diff_str_i 5]
    set dy1 [lindex $diff_str_i 6]
    set dx2 [lindex $diff_str_i 7]
    set dy2 [lindex $diff_str_i 8]
    set dx3 [lindex $diff_str_i 9]
    set dy3 [lindex $diff_str_i 10]
    set dx4 [lindex $diff_str_i 11]
    set dy4 [lindex $diff_str_i 12]

    if { $minCo2GateSpace != $minCo2OdEnclosure_H } { 
        set od_ext [expr $minCo2OdEnclosure_H - $minCo2GateSpace]
        if { $i == 0 } {
            set r [expr $r + $od_ext]
            set dx2 [EMP_DEVICE_min [expr $dx2 - $od_ext] 0]
            set dx3 [EMP_DEVICE_min [expr $dx3 - $od_ext] 0]
        } elseif { $i == $Fingers } {
            set l [expr $l - $od_ext]
            set dx1 [EMP_DEVICE_max [expr $dx1 + $od_ext] 0]
            set dx4 [EMP_DEVICE_max [expr $dx4 + $od_ext] 0]
        } else {
            set r [expr $r + $od_ext]
            set dx2 [EMP_DEVICE_min [expr $dx2 - $od_ext] 0]
            set dx3 [EMP_DEVICE_min [expr $dx3 - $od_ext] 0]
            set l [expr $l - $od_ext]
            set dx1 [EMP_DEVICE_max [expr $dx1 + $od_ext] 0]
            set dx4 [EMP_DEVICE_max [expr $dx4 + $od_ext] 0]
        }
    }

    set point1_x [expr $l + $dx1]
    set point1_y $b
    set point2_x [expr $l + $dx1]
    set point2_y [expr $b + $dy1]
    set point3_x $l
    set point3_y [expr $b + $dy1]
    set point4_x $l
    set point4_y [expr $t + $dy4]
    set point5_x [expr $l + $dx4]
    set point5_y [expr $t + $dy4]
    set point6_x [expr $l + $dx4]
    set point6_y $t
    set point7_x [expr $r + $dx3]
    set point7_y $t
    set point8_x [expr $r + $dx3]
    set point8_y [expr $t + $dy3]
    set point9_x $r
    set point9_y [expr $t + $dy3]
    set point10_x $r
    set point10_y [expr $b + $dy2]
    set point11_x [expr $r + $dx2]
    set point11_y [expr $b + $dy2]
    set point12_x [expr $r + $dx2]
        

    set cont_pitch_V [expr $minCoWidth_V + $minCoSpace_V]
    set cont_pitch_H [expr $minCoWidth_H + $minCoSpace_H]
    set one_cont_width_V [expr $minCoWidth_V + 2*$minCo2OdEnclosure_V]
    set one_cont_width_H [expr $minCoWidth_H + 2*$minCo2OdEnclosure_H]

    set diff_box_l 0
    set diff_box_b 0
    set diff_box_r 0
    set diff_box_t 0 
    set cont_row 0
    set cont_col 0

    if { $dy1==0 && $dy2==0 && $dy3==0 && $dy4==0 } {
        set diff_box_l $l
        set diff_box_b $b
	set diff_box_r $r
	set diff_box_t $t
	set cont_row [expr floor(($t - $b - $one_cont_width_V + 1e-6)*1.0/$cont_pitch_V) + 1 ]
	set cont_col [expr floor(($r - $l - $one_cont_width_H + 1e-6)*1.0/$cont_pitch_H) + 1 ]
    } else {

# case 1 (v) : The contact region is from bottom to top vertical
        if { [expr [EMP_DEVICE_min $point8_x $point11_x] - [EMP_DEVICE_max $point5_x $point2_x]] >= [expr $one_cont_width_H - 1e-6] } {
                set diff_box_l [EMP_DEVICE_max $point5_x $point2_x]
		set diff_box_b $b
		set diff_box_r [EMP_DEVICE_min $point8_x $point11_x]
		set diff_box_t $t
                set cont_row [expr floor(($t - $b - $one_cont_width_V + 1e-6)*1.0/$cont_pitch_V) + 1 ]
                set cont_col [expr floor(([EMP_DEVICE_min $point8_x $point11_x] - [EMP_DEVICE_max $point5_x $point2_x] - $one_cont_width_H + 1e-6)*1.0/$cont_pitch_H) + 1 ]
        }

# case 2 (h) : The contact region is from left to right horizontal
        if { [expr [EMP_DEVICE_min $point4_y $point9_y] - [EMP_DEVICE_max $point3_y $point10_y]] >= [expr $one_cont_width_V - 1e-6] } {
	    set cont_row_h [expr floor(([EMP_DEVICE_min $point4_y $point9_y] - [EMP_DEVICE_max $point3_y $point10_y] - $one_cont_width_V + 1e-6)*1.0/$cont_pitch_V) + 1 ]
    	    set cont_col_h [expr floor(($r - $l - $one_cont_width_H + 1e-6)*1.0/$cont_pitch_H) + 1 ]
            if { $cont_row_h > $cont_row || ($cont_row_h == $cont_row && $cont_col_h > $cont_col) } {
                set diff_box_l $l
                set diff_box_b [EMP_DEVICE_max $point3_y $point10_y]
	        set diff_box_r $r
	        set diff_box_t [EMP_DEVICE_min $point4_y $point9_y]
	        set cont_row $cont_row_h
	        set cont_col $cont_col_h
            }
        }

# case 3 (l) : The contact region is left
        if { [expr [EMP_DEVICE_min $point8_x $point11_x] - $l + 1e-6] >= $one_cont_width_H && [expr $point4_y - $point3_y] >= [expr $one_cont_width_V -1e-6] } {
            set cont_row_l [expr floor(($point4_y - $point3_y - $one_cont_width_V + 1e-6)*1.0/$cont_pitch_V) + 1 ]
            set cont_col_l [expr floor(([EMP_DEVICE_min $point8_x $point11_x] - $l - $one_cont_width_H + 1e-6)*1.0/$cont_pitch_H) + 1 ]
            set height_diff [expr $point4_y - $point3_y - $diff_box_t + $diff_box_b]   
            if { $cont_row_l > $cont_row || ($cont_row_l == $cont_row && $cont_col_l > $cont_col) || ($cont_row_l == $cont_row && $cont_col_l == $cont_col && $height_diff > 0) } {
                set diff_box_l $l
                set diff_box_b $point3_y
                set diff_box_r [EMP_DEVICE_min $point8_x $point11_x]
                set diff_box_t $point4_y
                set cont_row $cont_row_l
                set cont_col $cont_col_l
            }
        }

# case 4 (b) : The contact region is bottom
        if { [expr $point12_x - $point1_x + 1e-6] >= $one_cont_width_H && [expr [EMP_DEVICE_min $point5_y $point8_y] - $b] >= [expr $one_cont_width_V - 1e-6] } {
            set cont_row_b [expr floor(([EMP_DEVICE_min $point5_y $point8_y] - $b - $one_cont_width_V + 1e-6)*1.0/$cont_pitch_V) + 1 ]
            set cont_col_b [expr floor(($point12_x - $point1_x - $one_cont_width_H + 1e-6)*1.0/$cont_pitch_H) + 1 ]
            set height_diff [expr [EMP_DEVICE_min $point5_y $point8_y] - $b - $diff_box_t + $diff_box_b]   
            if { $cont_row_b > $cont_row || ($cont_row_b == $cont_row && $cont_col_b > $cont_col) || ($cont_row_b == $cont_row && $cont_col_b == $cont_col && $height_diff > 0) } {
                set diff_box_l $point1_x
                set diff_box_b $b
                set diff_box_r $point12_x
                set diff_box_t [EMP_DEVICE_min $point5_y $point8_y]
                set cont_row $cont_row_b
                set cont_col $cont_col_b
            }
        }  

# case 5 (r) : The contact region is right
        if { [expr $r - [EMP_DEVICE_max $point5_x $point2_x] + 1e-6] >= $one_cont_width_H && [expr $point9_y - $point10_y] >= [expr $one_cont_width_V -1e-6] } {
            set cont_row_r [expr floor(($point9_y - $point10_y - $one_cont_width_V + 1e-6)*1.0/$cont_pitch_V) + 1 ]
            set cont_col_r [expr floor(($r - [EMP_DEVICE_max $point5_x $point2_x] - $one_cont_width_H + 1e-6)*1.0/$cont_pitch_H) + 1 ]
            set height_diff [expr $point9_y - $point10_y - $diff_box_t + $diff_box_b]   
            if { $cont_row_r > $cont_row || ($cont_row_r == $cont_row && $cont_col_r > $cont_col) || ($cont_row_r == $cont_row && $cont_col_r == $cont_col && $height_diff > 0) } {
                set diff_box_l [EMP_DEVICE_max $point5_x $point2_x]
                set diff_box_b $point10_y
                set diff_box_r $r
                set diff_box_t $point9_y 
                set cont_row $cont_row_r
                set cont_col $cont_col_r
            }
        }

# case 6 (t) : The contact region is top 
        if { [expr $point7_x - $point6_x + 1e-6] >= $one_cont_width_H && [expr $t - [EMP_DEVICE_max $point2_y $point11_y]] >= [expr $one_cont_width_V -1e-6] } {
            set cont_row_t [expr floor(($t - [EMP_DEVICE_max $point2_y $point11_y] - $one_cont_width_V + 1e-6)*1.0/$cont_pitch_V) + 1 ]
            set cont_col_t [expr floor(($point7_x - $point6_x - $one_cont_width_H + 1e-6)*1.0/$cont_pitch_H) + 1 ]
            set height_diff [expr $t - [EMP_DEVICE_max $point2_y $point11_y] - $diff_box_t + $diff_box_b]   
            if { $cont_row_t > $cont_row || ($cont_row_t == $cont_row && $cont_col_t > $cont_col) || ($cont_row_t == $cont_row && $cont_col_t == $cont_col && $height_diff > 0) } {
                set diff_box_l $point6_x
                set diff_box_b [EMP_DEVICE_max $point2_y $point11_y]
                set diff_box_r $point7_x
                set diff_box_t $t
                set cont_row $cont_row_t
                set cont_col $cont_col_t
            }
        }
    }
    if { $contact_mode == 2 } {
        if { $align == 0 } {
            set diff_box_v [EMP_DEVICE_grid [expr ($diff_box_t -$diff_box_b - $minCoWidth_V)/2.0] $minGrid]
        } elseif {$align == -1 } {
            set diff_box_v $minCo2OdEnclosure_V
        } else {
            set diff_box_v [expr $diff_box_t -$diff_box_b - $minCoWidth_V - $minCo2OdEnclosure_V] 
        }
        set diff_box_h [EMP_DEVICE_grid [expr ($diff_box_r - $diff_box_l - $minCoWidth_H ) / 2.0] $minGrid]
        set cont_row 1
        set cont_col 1
    } elseif { $contact_mode ==3 } {
        set cont_row $contact_row
        set cont_col $contact_column
        if { $align == 0 } {
            set diff_box_v [EMP_DEVICE_grid [expr ($diff_box_t - $diff_box_b - $contact_row * $cont_pitch_V + $minCoSpace_V) / 2.0] $minGrid]
        } elseif {$align == -1 } {
            set diff_box_v $minCo2OdEnclosure_V
        } else {
            set diff_box_v [expr $diff_box_t - $diff_box_b - $contact_row * $cont_pitch_V + $minCoSpace_V - $minCo2OdEnclosure_V] 
        }
        set diff_box_h [EMP_DEVICE_grid [expr ($diff_box_r - $diff_box_l - ($cont_col - 1) * $cont_pitch_H - $minCoWidth_H) / 2.0] $minGrid]
    } else {
        if { $align == 0 || $contact_mode == 4 } {
            set diff_box_v [EMP_DEVICE_grid [expr ($diff_box_t - $diff_box_b - $cont_row * $cont_pitch_V + $minCoSpace_V) / 2.0] $minGrid]
        } elseif {$align == -1 } {
            set diff_box_v $minCo2OdEnclosure_V
        } else {
            set diff_box_v [expr $diff_box_t - $diff_box_b - $cont_row * $cont_pitch_V + $minCoSpace_V - $minCo2OdEnclosure_V] 
        }
        set diff_box_h [EMP_DEVICE_grid [expr ($diff_box_r - $diff_box_l - ($cont_col - 1) * $cont_pitch_H - $minCoWidth_H) / 2.0] $minGrid]
    }

    for {set row 0} {$row < $cont_row} {incr row 1} {
        
        set cont_b [expr $diff_box_b + $diff_box_v + $cont_pitch_V * $row]
        set cont_t [expr $cont_b + $minCoWidth_V]
        if { $contact_mode == 4 && $row == 0 && $cont_b > [expr $diff_box_b + $minCo2OdEnclosure_V] } {
            set cont_b [expr $diff_box_b + $minCo2OdEnclosure_V]
        }
        if { $contact_mode == 4 && $row == [expr $cont_row - 1] && $cont_t < [expr $diff_box_t - $minCo2OdEnclosure_V] } {
            set cont_t [expr $diff_box_t - $minCo2OdEnclosure_V]
        }

        for {set col 0} {$col < $cont_col} {incr col 1} {
            set cont_l [expr $diff_box_l + $diff_box_h + $cont_pitch_H * $col]
            set cont_r [expr $cont_l + $minCoWidth_H]
            if { $contact_mode == 4 && $col == 0 && $cont_l > [expr $diff_box_l + $minCo2OdEnclosure_H] } {
                set cont_l [expr $diff_box_l + $minCo2OdEnclosure_H]
            }
            if { $contact_mode == 4 && $col == [expr $cont_col - 1] && $cont_r < [expr $diff_box_r - $minCo2OdEnclosure_H] } {
                set cont_r [expr $diff_box_r - $minCo2OdEnclosure_H]
            }
            set cont_box [list $cont_l $cont_b $cont_r $cont_t]
            dbCrtRect -cv $design -bbox $cont_box -layer $ct_layer -purpose $ct_pur
        }
    }
    
    if { $contact_mode == 4 } {
        set metal_box_l [expr $diff_box_l + $minCo2OdEnclosure_H - $minCo2MetEnclosure_H]
    } else {
        set metal_box_l [expr $diff_box_l + $diff_box_h - $minCo2MetEnclosure_H]
    }
    if { $contact_mode == 4 } {
        set metal_box_b [expr $diff_box_b + $minCo2OdEnclosure_V - $minCo2MetEnclosure_V]
    } else {
        set metal_box_b [expr $diff_box_b + $diff_box_v - $minCo2MetEnclosure_V]
    }
    set metal_box_r [expr $cont_r + $minCo2MetEnclosure_H] 
    set metal_box_t [expr $cont_t + $minCo2MetEnclosure_V] 
    set metal_box [list $metal_box_l $metal_box_b $metal_box_r $metal_box_t]
    set metal_i [dbCrtRect -cv $design -bbox $metal_box -layer $metal_layer -purpose $metal_pur]

    dbCrtHandle -param "metal_list" -value "{$i $contact_mode $metal_box_l $metal_box_b $metal_box_r $metal_box_t}" -shape $metal_i
}

proc draw_cont_by_list {metal_box contact_rule cont_layer cont_pur minGrid} {
    
    set design [getCurDesign]
    set contact_rule_list [lindex $contact_rule 0]
    set minCoWidth_H [lindex $contact_rule_list 5]
    set minCoWidth_V [lindex $contact_rule_list 6]
    set minCoSpace_H [lindex $contact_rule_list 7]
    set minCoSpace_V [lindex $contact_rule_list 8]
    set minCo2MetEnclosure_H [lindex $contact_rule_list 9]
    set minCo2MetEnclosure_V [lindex $contact_rule_list 10]
    set metal_box_l [lindex $metal_box 0]
    set metal_box_b [lindex $metal_box 1]
    set metal_box_r [lindex $metal_box 2]
    set metal_box_t [lindex $metal_box 3]

    set cont_pitch_V [expr $minCoWidth_V + $minCoSpace_V]
    set cont_pitch_H [expr $minCoWidth_H + $minCoSpace_H]
    set one_cont_width_V [expr $minCoWidth_V + 2*$minCo2MetEnclosure_V]
    set one_cont_width_H [expr $minCoWidth_H + 2*$minCo2MetEnclosure_H]
    set cont_row [expr floor(($metal_box_t - $metal_box_b - $one_cont_width_V + 1e-6)*1.0/$cont_pitch_V + 1) ]
    set cont_col [expr floor(($metal_box_r - $metal_box_l - $one_cont_width_H + 1e-6)*1.0/$cont_pitch_H + 1) ]
   
    
    set metal_box_h [EMP_DEVICE_grid [expr ($metal_box_r - $metal_box_l - ($cont_col - 1) * $cont_pitch_H - $minCoWidth_H) / 2.0] $minGrid]
    set metal_box_v [EMP_DEVICE_grid [expr ($metal_box_t - $metal_box_b - ($cont_row - 1) * $cont_pitch_V - $minCoWidth_V) / 2.0] $minGrid]

    set cont_b [expr $metal_box_b + $metal_box_v - $cont_pitch_V]
    for {set row 0} {$row < $cont_row} {incr row 1} {
        set cont_b [expr $cont_b + $cont_pitch_V]
        set cont_t [expr $cont_b + $minCoWidth_V]
        set cont_l [expr $metal_box_l + $metal_box_h - $cont_pitch_H]
        for {set col 0} {$col < $cont_col} {incr col 1} {
            set cont_l [expr $cont_l + $cont_pitch_H] 
            set cont_r [expr $cont_l + $minCoWidth_H]
            set cont_box [list $cont_l $cont_b $cont_r $cont_t]
            dbCrtRect -cv $design -bbox $cont_box -layer $cont_layer -purpose $cont_pur
        }
    }
}
    
