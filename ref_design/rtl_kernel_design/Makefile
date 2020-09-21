.PHONY: help

help::
	$(ECHO) "Makefile Usage:"
	$(ECHO) "make all "

# Points to Utility Directory
XSA := xilinx_u250_gen3x16_xdma_1_1_202010_1

TARGET := hw
DEVICE := $(DEVICES)
XCLBIN := ./xclbin

# Cleaning stuff
RM = rm -f
RMDIR = rm -rf

ECHO:= @echo

BUILD_DIR := ./_x

CXX :=g++ 
VPP := $(XILINX_VITIS)/bin/v++

include config.mk

CFLAGS := -g -std=c++11 -I$(XILINX_XRT)/include -I./src/common_src
LFLAGS := -L$(XILINX_XRT)/lib -lxilinxopencl -lxrt_core -lrt -luuid

HOST_SRCS = ./src/host.cpp ./src/common_src/srai_accel_utils.cpp


# Kernel compiler global settings
VPP_OPTS = -s -t $(TARGET) --platform $(XSA)
VPP_OPTS += --sp krnl_rtl_1.m00_axi_gmem:HOST[0]
VPP_OPTS += --sp krnl_rtl_1.m01_axi_gmem:PLRAM[0]
VPP_OPTS += --sp krnl_rtl_1.m02_axi_gmem:DDR[0]
VPP_OPTS += --sp krnl_rtl_1.m03_axi_gmem:DDR[1]
VPP_OPTS += --sp krnl_rtl_1.m04_axi_gmem:DDR[2]
VPP_OPTS += --sp krnl_rtl_1.m05_axi_gmem:DDR[3]
VPP_OPTS += --kernel_frequency "0:150|1:250"


# Kernel linker flags

EXECUTABLE = host
CMD_ARGS = $(XCLBIN)/rtl_ker.$(TARGET).$(XSA).xclbin

EMCONFIG_DIR = $(XCLBIN)/$(XSA)

BINARY_CONTAINERS += $(XCLBIN)/rtl_ker.$(TARGET).$(XSA).xclbin
BINARY_CONTAINER_OBJS += $(XCLBIN)/rtl_ker.$(TARGET).$(XSA).xo

CP = cp -rf

.PHONY: all clean cleanall docs emconfig
all: $(EXECUTABLE) $(BINARY_CONTAINERS) emconfig


.PHONY: exe
exe: $(EXECUTABLE)

.PHONY: build
build: $(BINARY_CONTAINERS)

# Building kernel
$(XCLBIN)/rtl_ker.$(TARGET).$(XSA).xclbin: $(BINARY_CONTAINER_OBJS)
	mkdir -p $(XCLBIN)
	$(VPP) $(VPP_OPTS) -lo $(XCLBIN)/rtl_ker.$(TARGET).$(XSA).xclbin $(XCLBIN)/rtl_ker.$(TARGET).$(XSA).xo

# Building Host
$(EXECUTABLE): $(HOST_SRCS)
	$(CXX) $(CFLAGS) -o '$@'  $(HOST_SRCS) $(LFLAGS)

emconfig:$(EMCONFIG_DIR)/emconfig.json
$(EMCONFIG_DIR)/emconfig.json:
	emconfigutil --nd 1 --platform $(XSA) --od $(EMCONFIG_DIR)

# Cleaning stuff
clean:
	-$(RMDIR) $(EXECUTABLE) $(XCLBIN)/{*sw_emu*,*hw_emu*} 
	-$(RMDIR) profile_* TempConfig system_estimate.xtxt *.rpt *.csv 
	-$(RMDIR) src/*.ll _xocc_* .Xil emconfig.json dltmp* xmltmp* *.log *.jou *.wcfg *.wdb

cleanall: clean
	-$(RMDIR) $(XCLBIN)
	-$(RMDIR) _x*
	-$(RMDIR) ./tmp_kernel_pack* ./packaged_kernel* 
