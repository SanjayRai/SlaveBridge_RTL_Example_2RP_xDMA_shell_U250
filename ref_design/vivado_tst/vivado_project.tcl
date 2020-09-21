create_project project_X project_X -part xcu250-figd2104-2L-e
set_property board_part xilinx.com:au250:part0:1.3 [current_project]
add_files -norecurse {
../rtl_kernel_design/src/hdl/krnl_rtl.sv
}
add_files -norecurse {
../rtl_kernel_design/src/ip/cdma/cdma.xci
../rtl_kernel_design/src/ip/bd/AXI_MM_IC/AXI_MM_IC.bd
}
reset_run synth_1
#launch_runs synth_1 -jobs 4
synth_design -top krnl_rtl -part xcu250-figd2104-2L-e
wait_on_run synth_1
open_run synth_1 -name synth_1


ipx::package_project -root_dir ../ip_pkg -vendor user.org -library user -taxonomy /UserIP -import_files -set_current false
ipx::unload_core ../ip_pkg/component.xml
ipx::edit_ip_in_project -upgrade true -name tmp_edit_project -directory ../ip_pkg ../ip_pkg/component.xml
update_compile_order -fileset sources_1
set_property core_revision 2 [ipx::current_core]
ipx::update_source_project_archive -component [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
close_project
