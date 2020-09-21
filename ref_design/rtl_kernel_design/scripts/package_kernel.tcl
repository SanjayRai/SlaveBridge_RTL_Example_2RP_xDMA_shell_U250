
set path_to_hdl "./src/hdl"
set path_to_ip "./src/ip"
set path_to_packaged "./packaged_kernel_${suffix}"
set path_to_tmp_project "./tmp_kernel_pack_${suffix}"

create_project -force kernel_pack $path_to_tmp_project  -part xcu250-figd2104-2L-e
add_files -norecurse [glob $path_to_hdl/*.v $path_to_hdl/*.sv]
add_files -norecurse $path_to_ip/cdma/cdma.xci
add_files -norecurse $path_to_ip/bd/AXI_MM_IC/AXI_MM_IC.bd
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
ipx::package_project -root_dir $path_to_packaged -vendor xilinx.com -library RTLKernel -taxonomy /KernelIP -import_files -set_current false
ipx::unload_core $path_to_packaged/component.xml
ipx::edit_ip_in_project -upgrade true -name tmp_edit_project -directory $path_to_packaged $path_to_packaged/component.xml
set_property core_revision 2 [ipx::current_core]
foreach up [ipx::get_user_parameters] {
  ipx::remove_user_parameter [get_property NAME $up] [ipx::current_core]
}
set_property sdx_kernel true [ipx::current_core]
set_property sdx_kernel_type rtl [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::associate_bus_interfaces -busif m00_axi_gmem -clock ap_clk [ipx::current_core]
ipx::associate_bus_interfaces -busif m01_axi_gmem -clock ap_clk [ipx::current_core]
ipx::associate_bus_interfaces -busif m02_axi_gmem -clock ap_clk [ipx::current_core]
ipx::associate_bus_interfaces -busif m03_axi_gmem -clock ap_clk [ipx::current_core]
ipx::associate_bus_interfaces -busif m04_axi_gmem -clock ap_clk [ipx::current_core]
ipx::associate_bus_interfaces -busif m05_axi_gmem -clock ap_clk [ipx::current_core]
ipx::associate_bus_interfaces -busif s_axi_control -clock ap_clk [ipx::current_core]
set_property xpm_libraries {XPM_CDC XPM_MEMORY XPM_FIFO} [ipx::current_core]
set_property supported_families { } [ipx::current_core]
set_property auto_family_support_level level_2 [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
close_project
