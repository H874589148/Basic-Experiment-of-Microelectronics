set TARGET_LIBRARY_FILES          "saed32rvt_tt1p05v125c.db saed32hvt_tt1p05v125c.db saed32lvt_tt1p05v125c.db"

set_app_var target_library ${TARGET_LIBRARY_FILES}
set_app_var synthetic_library dw_foundation.sldb
set_app_var link_library "* $target_library $synthetic_library" 
