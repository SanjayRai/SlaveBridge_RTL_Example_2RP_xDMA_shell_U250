create_project project_X project_X -part xcu250-figd2104-2L-e
set_property board_part xilinx.com:au250:part0:1.3 [current_project]
add_files -norecurse {
../cdma/cdma.xci
../bd/AXI_MM_IC/AXI_MM_IC.bd
}
