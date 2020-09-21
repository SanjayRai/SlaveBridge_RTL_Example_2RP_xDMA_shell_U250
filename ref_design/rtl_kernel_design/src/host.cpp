// Copyright (C) 2017-2020 Xilinx Inc.
// All rights reserved.
// UdayD@xilinx.com

#include <unistd.h>
#include <getopt.h>
#include <iostream>
#include <stdexcept>
#include <string>
#include <cstring>
#include <sys/mman.h>
#include <errno.h>
#include <inttypes.h>
#include <fstream>
#include <uuid/uuid.h>


#include "xclhal2.h"
#include "srai_accel_utils.h" 


using namespace std;

//static const int NO_OF_DATA = 1*1024*1024; // Max Bytes to Transfer is 8MB for CDMA
static const int NO_OF_DATA = 1024; // Max Bytes to Transfer is 8MB for CDMA

int main(int argc, char** argv)
{
    xclDeviceHandle handle;
    int not_match = 0;

    uint32_t ret_data = 0;
    uint32_t itn_count = 0;

    const size_t DATA_SIZE = NO_OF_DATA * sizeof(int);  // (1*1024*1024)*4 = 4 MB ::  Max Bytes to Transfer is 8MB for CDMA


    // Open the device
    handle = xclOpen(0, "hal.log", XCL_INFO);


    // Extract xclbin file
    string bitstreamFile("./xclbin/rtl_ker.hw.xilinx_u250_gen3x16_xdma_1_1_202010_1.xclbin");
    ifstream stream(bitstreamFile.c_str());
    stream.seekg(0, stream.end);
    int size = stream.tellg();
    stream.seekg(0, stream.beg);

    char *header = new char[size];
    stream.read(header, size);


    // Download bitstream on FPGA
    const xclBin *blob = (const xclBin *)header;
    if (xclLoadXclBin(handle, blob)) {
        delete [] header;
        cout<<"Bitstream download failed";
    }

    cout << "\nFinished downloading bitstream " << endl;

    // Extract UUID of XCLBIN
    uuid_t xclbinId;
    const axlf* top = (const axlf*)header;
    uuid_copy(xclbinId, top->m_header.uuid);

    delete [] header;


    // Allocate Buffers
    auto buf_in_a = xclAllocBO(handle, DATA_SIZE, 0, XCL_BO_FLAGS_HOST_ONLY|8); 
    auto buf_out = xclAllocBO(handle, DATA_SIZE, 0, XCL_BO_FLAGS_HOST_ONLY|8); 
 

    // Dummy buffer allocation: Buffer allocated for DDR : Not used
    auto dummy_buf_ddr = xclAllocBO(handle, DATA_SIZE, 0, XCL_BO_FLAGS_DEV_ONLY|0);


    // Map buffer to user space
    auto a_data = reinterpret_cast<int*>(xclMapBO(handle, buf_in_a, true));
    auto out_data = reinterpret_cast<int*>(xclMapBO(handle, buf_out, true)); 


    // Prepare Test data
    for(int i=0; i < NO_OF_DATA; i++){
        a_data[i] = i+3;
        out_data[i] = 0;
    }


    // Get the buffer physical address 
    xclBOProperties p;
    uint64_t a_addr = !xclGetBOProperties(handle,buf_in_a,&p) ? p.paddr : -1;
    uint64_t out_addr = !xclGetBOProperties(handle,buf_out,&p) ? p.paddr : -1;


    cout<<"\n Buffer a Physical address        0x"<< hex << a_addr;
    cout<<"\n Buffer out_addr Physical address 0x" << hex << out_addr;


    // CPU cache flush/invaliate
    xclSyncBO(handle, buf_in_a, XCL_BO_SYNC_BO_TO_DEVICE, DATA_SIZE,0);

    xclOpenContext(handle, xclbinId, KERNEL_INDEX, false);

    // Set Kernel data
    cout<<"\n Setting Kernel Data";

    uint32_t axi_ctrl = 0;
    int ret = 0;

    // Kernel start
    cout<<"\n Kernel Start,,,,  " << endl;
    fpga_CDMA_RESET(handle);
    usleep(250);
    fpga_CDMA_XFER (handle, a_addr, AXI_MM_DDR4_C0, DATA_SIZE);
    for (int i = 0; i < 100; i++) {
        fpga_CDMA_XFER (handle, AXI_MM_DDR4_C0, AXI_MM_DDR4_C1, DATA_SIZE);
        fpga_CDMA_XFER (handle, AXI_MM_DDR4_C1, AXI_MM_DDR4_C2, DATA_SIZE);
        fpga_CDMA_XFER (handle, AXI_MM_DDR4_C2, AXI_MM_DDR4_C3, DATA_SIZE);
        fpga_CDMA_XFER (handle, AXI_MM_DDR4_C3, out_addr, DATA_SIZE);
        fpga_CDMA_XFER (handle, out_addr, AXI_MM_DDR4_C0, DATA_SIZE);
    }


    cout<<"\n Kernel Done,,,,  " << endl;

    xclSyncBO(handle, buf_out, XCL_BO_SYNC_BO_FROM_DEVICE, DATA_SIZE, 0);

    xclCloseContext(handle, xclbinId, KERNEL_INDEX);
        

    cout<<"\n\n Checking Result";
    for(int i=0; i < NO_OF_DATA; i++){
        if (out_data[i] != (a_data[i])) {
            not_match = 1;
            break;
        }
     
    }



    xclFreeBO(handle,buf_in_a);
    xclFreeBO(handle,buf_out);

    cout << "\nTEST " << (not_match ? "FAILED" : "PASSED") << endl; 
    return (not_match ? EXIT_FAILURE :  EXIT_SUCCESS);
}
