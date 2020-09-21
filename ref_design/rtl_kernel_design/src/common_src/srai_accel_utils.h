/* Sanjay Rai - Routine to access PCIe via  dev.mem mmap  */
#ifndef SRAI_ACCEL_UTILS_H_
#define SRAI_ACCEL_UTILS_H_

/* Address Ranges as defined in VIvado IPI Address map */
/* NOTE: Be aware on any PCIe-AXI Address translation setup on the xDMA/PCIEBridge*/ 
/*       These address translations affect the address shown . THese address are  */
/*       exactly waht is populated on the IPI Address tab                         */
/* AXI MM Register interfaces */

#define AXI_MM_DDR4_C0         0x0000004000000000ULL
#define AXI_MM_DDR4_C1         0x0000005000000000ULL
#define AXI_MM_DDR4_C2         0x0000006000000000ULL
#define AXI_MM_DDR4_C3         0x0000007000000000ULL




#define KERNEL_INDEX 0
/* AXI LITE Register interfaces */
#define KERNEL_BASE_ADDRESS      0xc10000

#define CDMA_CTRL_REG            KERNEL_BASE_ADDRESS + 0x00UL
#define CDMA_STATUS_REG          KERNEL_BASE_ADDRESS + 0x04UL
#define CDMA_SOURCE_ADDR_LSB_REG KERNEL_BASE_ADDRESS + 0x18UL
#define CDMA_SOURCE_ADDR_MSB_REG KERNEL_BASE_ADDRESS + 0x1CUL
#define CDMA_DEST_ADDR_LSB_REG   KERNEL_BASE_ADDRESS + 0x20UL
#define CDMA_DEST_ADDR_MSB_REG   KERNEL_BASE_ADDRESS + 0x24UL
#define CDMA_BTT_REG             KERNEL_BASE_ADDRESS + 0x28UL


void SRAI_dbg_wait(std::string dbg_string);
bool fpga_CDMA_XFER (xclDeviceHandle handle, uint64_t SRC_ADDR, uint64_t DEST_ADDR, uint32_t XFER_SZ );
void fpga_CDMA_RESET (xclDeviceHandle handle);
#endif // SRAI_ACCEL_UTILS_H_
