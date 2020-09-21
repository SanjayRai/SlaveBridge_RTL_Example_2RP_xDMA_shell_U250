/* Sanjay Rai - Test routing to access PCIe via  dev.mem mmap  */
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <errno.h>
#include <time.h>
#include <inttypes.h>
#include <iostream>
#include <fstream>
#include <string>
#include <chrono>
#include <cmath>
#include "xclhal2.h"
#include "srai_accel_utils.h" 

using namespace std;

void fpga_CDMA_RESET (xclDeviceHandle handle) {
    uint32_t ret_data = 0;
    uint32_t itn_count = 0;
    xclRead(handle,XCL_ADDR_KERNEL_CTRL,CDMA_CTRL_REG, &ret_data, sizeof(ret_data));
    ret_data |= 0x00000004; 
    xclWrite(handle, XCL_ADDR_KERNEL_CTRL,CDMA_CTRL_REG, &ret_data, sizeof(ret_data));
    usleep(10);
    itn_count = 4;
    while (ret_data != 0x0) {
        xclRead(handle,XCL_ADDR_KERNEL_CTRL,CDMA_STATUS_REG, &ret_data, sizeof(ret_data));
        ret_data &= 0x00000004; 
        usleep(10);
        itn_count++; 
        if (itn_count > 10000000)  {
            cout << "CDMA Execution Error :: CDMA Reset register indicates not ready ...! reg = " << ret_data << endl;
            break;
        }
    }
}
bool fpga_CDMA_XFER (xclDeviceHandle handle, uint64_t SRC_ADDR, uint64_t DEST_ADDR, uint32_t XFER_SZ ) {
    uint32_t ret_data = 0;
    uint32_t write_data = 0;
    uint32_t itn_count = 0;
    fpga_CDMA_RESET(handle);
    // Check if the CDMA is Idle
    bool ret_val = false;
    while (ret_data != 0x2) {
        xclRead(handle,XCL_ADDR_KERNEL_CTRL,CDMA_STATUS_REG, &ret_data, sizeof(ret_data));
        ret_data &= 0x00000002; 
        itn_count++; 
        if (itn_count > 10000000)  {
            cout << "CDMA Execution Error :: CDMA Status register indicates not ready ...!\n";
            ret_val = true;
            break;
        }
    }

    //SRAI_dbg_wait("CDMA status loop 1");
    write_data = 0x00001000; //Enable IOC_Irq_enable (Interrupt on Complete) 
    xclWrite(handle, XCL_ADDR_KERNEL_CTRL,CDMA_CTRL_REG, &write_data, sizeof(write_data));
    write_data = (uint32_t)((0x00000000FFFFFFFFULL & SRC_ADDR));
    xclWrite(handle, XCL_ADDR_KERNEL_CTRL,CDMA_SOURCE_ADDR_LSB_REG, &write_data, sizeof(write_data));

    write_data = (uint32_t)((0xFFFFFFFF00000000ULL & SRC_ADDR) >> 32);
    xclWrite(handle, XCL_ADDR_KERNEL_CTRL,CDMA_SOURCE_ADDR_MSB_REG, &write_data, sizeof(write_data));

    write_data = (uint32_t)((0x00000000FFFFFFFFULL & DEST_ADDR));
    xclWrite(handle, XCL_ADDR_KERNEL_CTRL,CDMA_DEST_ADDR_LSB_REG, &write_data, sizeof(write_data));

    write_data = (uint32_t)((0xFFFFFFFF00000000ULL & DEST_ADDR) >> 32);
    xclWrite(handle, XCL_ADDR_KERNEL_CTRL,CDMA_DEST_ADDR_MSB_REG, &write_data, sizeof(write_data));
    usleep(250);
    write_data = (uint32_t)XFER_SZ;
    xclWrite(handle, XCL_ADDR_KERNEL_CTRL,CDMA_BTT_REG, &write_data, sizeof(write_data));
    //cout << "CDMA_STATUS_REG start = " << hex << (unsigned int)fpga_AXI_Lite_ptr->fpga_peek(CDMA_STATUS_REG) << endl;
    //usleep(150);
    usleep(250);
    ret_data = 0;
    itn_count = 0;
    while (ret_data != 0x00001002) {
        xclRead(handle,XCL_ADDR_KERNEL_CTRL,CDMA_STATUS_REG, &ret_data, sizeof(ret_data));
        ret_data &= 0x00001002;
        itn_count++; 
        if (itn_count > 10000000)  {
            cout << "CDMA Execution Timeout Error :: CDMA Interrupt Status register indicates no XFER happened!\n";
            break;
            ret_val = true;
        }
    }
    write_data =  0x00001000; 
    xclWrite(handle, XCL_ADDR_KERNEL_CTRL,CDMA_STATUS_REG, &write_data, sizeof(write_data));
    ret_data = 0;
    itn_count = 0;
    while (ret_data != 0x2) {
        xclRead(handle,XCL_ADDR_KERNEL_CTRL,CDMA_STATUS_REG, &ret_data, sizeof(ret_data));
        ret_data &= 0x00000002; 
        itn_count++; 
        if (itn_count > 10000000)  {
            cout << "CDMA Execution Error :: CDMA Status register indicates not ready!\n";
            break;
            ret_val = true;
        }
    }
    //cout << "CDMA_STATUS_REG end = " << hex << (unsigned int)fpga_AXI_Lite_ptr->fpga_peek(CDMA_STATUS_REG) << endl;
    return (ret_val);
}

void SRAI_dbg_wait (string dbg_string) {
    string Srai_dbg_wait;
    cout << "Dbg Pause : " << dbg_string << " : Enter any character (followed by Enter key) to proceed : ";
    cin >> Srai_dbg_wait;
}

