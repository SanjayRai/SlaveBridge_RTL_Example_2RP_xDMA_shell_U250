VIVADO := $(XILINX_VIVADO)/bin/vivado
$(XCLBIN)/rtl_ker.$(TARGET).$(XSA).xo: src/kernel.xml scripts/package_kernel.tcl scripts/gen_xo.tcl src/hdl/*.sv src/hdl/*.v
	mkdir -p $(XCLBIN)
	$(VIVADO) -mode batch -source scripts/gen_xo.tcl -tclargs $(XCLBIN)/rtl_ker.$(TARGET).$(XSA).xo rtl_ker $(TARGET) $(XSA)
