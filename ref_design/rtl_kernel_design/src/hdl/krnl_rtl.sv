// Sanjay Rai (sanjay.d.rai@gmail.com)
//
`timescale 1 ps / 1 ps

module krnl_rtl #( 
  parameter integer  C_S_AXI_CONTROL_DATA_WIDTH = 32,
  parameter integer  C_S_AXI_CONTROL_ADDR_WIDTH = 32,
  parameter integer  C_M_AXI_GMEM_ID_WIDTH = 8,
  parameter integer  C_M_AXI_GMEM_ADDR_WIDTH = 64,
  parameter integer  C_M_AXI_GMEM_DATA_WIDTH = 512
)
(
  // System signals
  input  wire  ap_clk,
  input  wire  ap_rst_n,
  // AXI4 master interface 
  output wire                                 m00_axi_gmem_awvalid,
  input  wire                                 m00_axi_gmem_awready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m00_axi_gmem_awaddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m00_axi_gmem_awid,
  output wire [7:0]                           m00_axi_gmem_awlen,
  output wire [2:0]                           m00_axi_gmem_awsize,
  output wire [1:0]                           m00_axi_gmem_awburst,
  output wire [1:0]                           m00_axi_gmem_awlock,
  output wire [3:0]                           m00_axi_gmem_awcache,
  output wire [2:0]                           m00_axi_gmem_awprot,
  output wire [3:0]                           m00_axi_gmem_awqos,
  output wire [3:0]                           m00_axi_gmem_awregion,
  output wire                                 m00_axi_gmem_wvalid,
  input  wire                                 m00_axi_gmem_wready,
  output wire [C_M_AXI_GMEM_DATA_WIDTH-1:0]   m00_axi_gmem_wdata,
  output wire [C_M_AXI_GMEM_DATA_WIDTH/8-1:0] m00_axi_gmem_wstrb,
  output wire                                 m00_axi_gmem_wlast,
  output wire                                 m00_axi_gmem_arvalid,
  input  wire                                 m00_axi_gmem_arready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m00_axi_gmem_araddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH-1:0]     m00_axi_gmem_arid,
  output wire [7:0]                           m00_axi_gmem_arlen,
  output wire [2:0]                           m00_axi_gmem_arsize,
  output wire [1:0]                           m00_axi_gmem_arburst,
  output wire [1:0]                           m00_axi_gmem_arlock,
  output wire [3:0]                           m00_axi_gmem_arcache,
  output wire [2:0]                           m00_axi_gmem_arprot,
  output wire [3:0]                           m00_axi_gmem_arqos,
  output wire [3:0]                           m00_axi_gmem_arregion,
  input  wire                                 m00_axi_gmem_rvalid,
  output wire                                 m00_axi_gmem_rready,
  input  wire [C_M_AXI_GMEM_DATA_WIDTH - 1:0] m00_axi_gmem_rdata,
  input  wire                                 m00_axi_gmem_rlast,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m00_axi_gmem_rid,
  input  wire [1:0]                           m00_axi_gmem_rresp,
  input  wire                                 m00_axi_gmem_bvalid,
  output wire                                 m00_axi_gmem_bready,
  input  wire [1:0]                           m00_axi_gmem_bresp,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m00_axi_gmem_bid,

  output wire                                 m01_axi_gmem_awvalid,
  input  wire                                 m01_axi_gmem_awready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m01_axi_gmem_awaddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m01_axi_gmem_awid,
  output wire [7:0]                           m01_axi_gmem_awlen,
  output wire [2:0]                           m01_axi_gmem_awsize,
  output wire [1:0]                           m01_axi_gmem_awburst,
  output wire [1:0]                           m01_axi_gmem_awlock5,
  output wire [3:0]                           m01_axi_gmem_awcache,
  output wire [2:0]                           m01_axi_gmem_awprot,
  output wire [3:0]                           m01_axi_gmem_awqos,
  output wire [3:0]                           m01_axi_gmem_awregion,
  output wire                                 m01_axi_gmem_wvalid,
  input  wire                                 m01_axi_gmem_wready,
  output wire [C_M_AXI_GMEM_DATA_WIDTH-1:0]   m01_axi_gmem_wdata,
  output wire [C_M_AXI_GMEM_DATA_WIDTH/8-1:0] m01_axi_gmem_wstrb,
  output wire                                 m01_axi_gmem_wlast,
  output wire                                 m01_axi_gmem_arvalid,
  input  wire                                 m01_axi_gmem_arready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m01_axi_gmem_araddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH-1:0]     m01_axi_gmem_arid,
  output wire [7:0]                           m01_axi_gmem_arlen,
  output wire [2:0]                           m01_axi_gmem_arsize,
  output wire [1:0]                           m01_axi_gmem_arburst,
  output wire [1:0]                           m01_axi_gmem_arlock,
  output wire [3:0]                           m01_axi_gmem_arcache,
  output wire [2:0]                           m01_axi_gmem_arprot,
  output wire [3:0]                           m01_axi_gmem_arqos,
  output wire [3:0]                           m01_axi_gmem_arregion,
  input  wire                                 m01_axi_gmem_rvalid,
  output wire                                 m01_axi_gmem_rready,
  input  wire [C_M_AXI_GMEM_DATA_WIDTH - 1:0] m01_axi_gmem_rdata,
  input  wire                                 m01_axi_gmem_rlast,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m01_axi_gmem_rid,
  input  wire [1:0]                           m01_axi_gmem_rresp,
  input  wire                                 m01_axi_gmem_bvalid,
  output wire                                 m01_axi_gmem_bready,
  input  wire [1:0]                           m01_axi_gmem_bresp,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m01_axi_gmem_bid,

  output wire                                 m02_axi_gmem_awvalid,
  input  wire                                 m02_axi_gmem_awready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m02_axi_gmem_awaddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m02_axi_gmem_awid,
  output wire [7:0]                           m02_axi_gmem_awlen,
  output wire [2:0]                           m02_axi_gmem_awsize,
  output wire [1:0]                           m02_axi_gmem_awburst,
  output wire [1:0]                           m02_axi_gmem_awlock,
  output wire [3:0]                           m02_axi_gmem_awcache,
  output wire [2:0]                           m02_axi_gmem_awprot,
  output wire [3:0]                           m02_axi_gmem_awqos,
  output wire [3:0]                           m02_axi_gmem_awregion,
  output wire                                 m02_axi_gmem_wvalid,
  input  wire                                 m02_axi_gmem_wready,
  output wire [C_M_AXI_GMEM_DATA_WIDTH-1:0]   m02_axi_gmem_wdata,
  output wire [C_M_AXI_GMEM_DATA_WIDTH/8-1:0] m02_axi_gmem_wstrb,
  output wire                                 m02_axi_gmem_wlast,
  output wire                                 m02_axi_gmem_arvalid,
  input  wire                                 m02_axi_gmem_arready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m02_axi_gmem_araddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH-1:0]     m02_axi_gmem_arid,
  output wire [7:0]                           m02_axi_gmem_arlen,
  output wire [2:0]                           m02_axi_gmem_arsize,
  output wire [1:0]                           m02_axi_gmem_arburst,
  output wire [1:0]                           m02_axi_gmem_arlock,
  output wire [3:0]                           m02_axi_gmem_arcache,
  output wire [2:0]                           m02_axi_gmem_arprot,
  output wire [3:0]                           m02_axi_gmem_arqos,
  output wire [3:0]                           m02_axi_gmem_arregion,
  input  wire                                 m02_axi_gmem_rvalid,
  output wire                                 m02_axi_gmem_rready,
  input  wire [C_M_AXI_GMEM_DATA_WIDTH - 1:0] m02_axi_gmem_rdata,
  input  wire                                 m02_axi_gmem_rlast,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m02_axi_gmem_rid,
  input  wire [1:0]                           m02_axi_gmem_rresp,
  input  wire                                 m02_axi_gmem_bvalid,
  output wire                                 m02_axi_gmem_bready,
  input  wire [1:0]                           m02_axi_gmem_bresp,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m02_axi_gmem_bid,

  output wire                                 m03_axi_gmem_awvalid,
  input  wire                                 m03_axi_gmem_awready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m03_axi_gmem_awaddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m03_axi_gmem_awid,
  output wire [7:0]                           m03_axi_gmem_awlen,
  output wire [2:0]                           m03_axi_gmem_awsize,
  output wire [1:0]                           m03_axi_gmem_awburst,
  output wire [1:0]                           m03_axi_gmem_awlock,
  output wire [3:0]                           m03_axi_gmem_awcache,
  output wire [2:0]                           m03_axi_gmem_awprot,
  output wire [3:0]                           m03_axi_gmem_awqos,
  output wire [3:0]                           m03_axi_gmem_awregion,
  output wire                                 m03_axi_gmem_wvalid,
  input  wire                                 m03_axi_gmem_wready,
  output wire [C_M_AXI_GMEM_DATA_WIDTH-1:0]   m03_axi_gmem_wdata,
  output wire [C_M_AXI_GMEM_DATA_WIDTH/8-1:0] m03_axi_gmem_wstrb,
  output wire                                 m03_axi_gmem_wlast,
  output wire                                 m03_axi_gmem_arvalid,
  input  wire                                 m03_axi_gmem_arready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m03_axi_gmem_araddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH-1:0]     m03_axi_gmem_arid,
  output wire [7:0]                           m03_axi_gmem_arlen,
  output wire [2:0]                           m03_axi_gmem_arsize,
  output wire [1:0]                           m03_axi_gmem_arburst,
  output wire [1:0]                           m03_axi_gmem_arlock,
  output wire [3:0]                           m03_axi_gmem_arcache,
  output wire [2:0]                           m03_axi_gmem_arprot,
  output wire [3:0]                           m03_axi_gmem_arqos,
  output wire [3:0]                           m03_axi_gmem_arregion,
  input  wire                                 m03_axi_gmem_rvalid,
  output wire                                 m03_axi_gmem_rready,
  input  wire [C_M_AXI_GMEM_DATA_WIDTH - 1:0] m03_axi_gmem_rdata,
  input  wire                                 m03_axi_gmem_rlast,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m03_axi_gmem_rid,
  input  wire [1:0]                           m03_axi_gmem_rresp,
  input  wire                                 m03_axi_gmem_bvalid,
  output wire                                 m03_axi_gmem_bready,
  input  wire [1:0]                           m03_axi_gmem_bresp,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m03_axi_gmem_bid,

  output wire                                 m04_axi_gmem_awvalid,
  input  wire                                 m04_axi_gmem_awready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m04_axi_gmem_awaddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m04_axi_gmem_awid,
  output wire [7:0]                           m04_axi_gmem_awlen,
  output wire [2:0]                           m04_axi_gmem_awsize,
  output wire [1:0]                           m04_axi_gmem_awburst,
  output wire [1:0]                           m04_axi_gmem_awlock,
  output wire [3:0]                           m04_axi_gmem_awcache,
  output wire [2:0]                           m04_axi_gmem_awprot,
  output wire [3:0]                           m04_axi_gmem_awqos,
  output wire [3:0]                           m04_axi_gmem_awregion,
  output wire                                 m04_axi_gmem_wvalid,
  input  wire                                 m04_axi_gmem_wready,
  output wire [C_M_AXI_GMEM_DATA_WIDTH-1:0]   m04_axi_gmem_wdata,
  output wire [C_M_AXI_GMEM_DATA_WIDTH/8-1:0] m04_axi_gmem_wstrb,
  output wire                                 m04_axi_gmem_wlast,
  output wire                                 m04_axi_gmem_arvalid,
  input  wire                                 m04_axi_gmem_arready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m04_axi_gmem_araddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH-1:0]     m04_axi_gmem_arid,
  output wire [7:0]                           m04_axi_gmem_arlen,
  output wire [2:0]                           m04_axi_gmem_arsize,
  output wire [1:0]                           m04_axi_gmem_arburst,
  output wire [1:0]                           m04_axi_gmem_arlock,
  output wire [3:0]                           m04_axi_gmem_arcache,
  output wire [2:0]                           m04_axi_gmem_arprot,
  output wire [3:0]                           m04_axi_gmem_arqos,
  output wire [3:0]                           m04_axi_gmem_arregion,
  input  wire                                 m04_axi_gmem_rvalid,
  output wire                                 m04_axi_gmem_rready,
  input  wire [C_M_AXI_GMEM_DATA_WIDTH - 1:0] m04_axi_gmem_rdata,
  input  wire                                 m04_axi_gmem_rlast,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m04_axi_gmem_rid,
  input  wire [1:0]                           m04_axi_gmem_rresp,
  input  wire                                 m04_axi_gmem_bvalid,
  output wire                                 m04_axi_gmem_bready,
  input  wire [1:0]                           m04_axi_gmem_bresp,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m04_axi_gmem_bid,

  output wire                                 m05_axi_gmem_awvalid,
  input  wire                                 m05_axi_gmem_awready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m05_axi_gmem_awaddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m05_axi_gmem_awid,
  output wire [7:0]                           m05_axi_gmem_awlen,
  output wire [2:0]                           m05_axi_gmem_awsize,
  output wire [1:0]                           m05_axi_gmem_awburst,
  output wire [1:0]                           m05_axi_gmem_awlock,
  output wire [3:0]                           m05_axi_gmem_awcache,
  output wire [2:0]                           m05_axi_gmem_awprot,
  output wire [3:0]                           m05_axi_gmem_awqos,
  output wire [3:0]                           m05_axi_gmem_awregion,
  output wire                                 m05_axi_gmem_wvalid,
  input  wire                                 m05_axi_gmem_wready,
  output wire [C_M_AXI_GMEM_DATA_WIDTH-1:0]   m05_axi_gmem_wdata,
  output wire [C_M_AXI_GMEM_DATA_WIDTH/8-1:0] m05_axi_gmem_wstrb,
  output wire                                 m05_axi_gmem_wlast,
  output wire                                 m05_axi_gmem_arvalid,
  input  wire                                 m05_axi_gmem_arready,
  output wire [C_M_AXI_GMEM_ADDR_WIDTH-1:0]   m05_axi_gmem_araddr,
  output wire [C_M_AXI_GMEM_ID_WIDTH-1:0]     m05_axi_gmem_arid,
  output wire [7:0]                           m05_axi_gmem_arlen,
  output wire [2:0]                           m05_axi_gmem_arsize,
  output wire [1:0]                           m05_axi_gmem_arburst,
  output wire [1:0]                           m05_axi_gmem_arlock,
  output wire [3:0]                           m05_axi_gmem_arcache,
  output wire [2:0]                           m05_axi_gmem_arprot,
  output wire [3:0]                           m05_axi_gmem_arqos,
  output wire [3:0]                           m05_axi_gmem_arregion,
  input  wire                                 m05_axi_gmem_rvalid,
  output wire                                 m05_axi_gmem_rready,
  input  wire [C_M_AXI_GMEM_DATA_WIDTH - 1:0] m05_axi_gmem_rdata,
  input  wire                                 m05_axi_gmem_rlast,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m05_axi_gmem_rid,
  input  wire [1:0]                           m05_axi_gmem_rresp,
  input  wire                                 m05_axi_gmem_bvalid,
  output wire                                 m05_axi_gmem_bready,
  input  wire [1:0]                           m05_axi_gmem_bresp,
  input  wire [C_M_AXI_GMEM_ID_WIDTH - 1:0]   m05_axi_gmem_bid,

  // AXI4-Lite slave interface
  input  wire                                    s_axi_control_AWVALID,
  output wire                                    s_axi_control_AWREADY,
  input  wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_AWADDR,
  input  wire                                    s_axi_control_WVALID,
  output wire                                    s_axi_control_WREADY,
  input  wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_WDATA,
  input  wire [C_S_AXI_CONTROL_DATA_WIDTH/8-1:0] s_axi_control_WSTRB,
  input  wire                                    s_axi_control_ARVALID,
  output wire                                    s_axi_control_ARREADY,
  input  wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_ARADDR,
  output wire                                    s_axi_control_RVALID,
  input  wire                                    s_axi_control_RREADY,
  output wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_RDATA,
  output wire [1:0]                              s_axi_control_RRESP,
  output wire                                    s_axi_control_BVALID,
  input  wire                                    s_axi_control_BREADY,
  output wire [1:0]                              s_axi_control_BRESP,
  output wire                                    interrupt 
);

assign interrupt = 1'b0;
assign m00_axi_gmem_arid = 'd0;
assign m00_axi_gmem_awid = 'd0;
assign m01_axi_gmem_arid = 'd0;
assign m01_axi_gmem_awid = 'd0;
assign m02_axi_gmem_arid = 'd0;
assign m02_axi_gmem_awid = 'd0;
assign m03_axi_gmem_arid = 'd0;
assign m03_axi_gmem_awid = 'd0;
assign m04_axi_gmem_arid = 'd0;
assign m04_axi_gmem_awid = 'd0;
assign m05_axi_gmem_arid = 'd0;
assign m05_axi_gmem_awid = 'd0;

wire s_axi_gmem_arready;
wire s_axi_gmem_arvalid;
wire [63 : 0] s_axi_gmem_araddr;
wire [7 : 0] s_axi_gmem_arlen;
wire [2 : 0] s_axi_gmem_arsize;
wire [1 : 0] s_axi_gmem_arburst;
wire [2 : 0] s_axi_gmem_arprot;
wire [3 : 0] s_axi_gmem_arcache;
wire s_axi_gmem_rready;
wire s_axi_gmem_rvalid;
wire [511 : 0] s_axi_gmem_rdata;
wire [1 : 0] s_axi_gmem_rresp;
wire s_axi_gmem_rlast;
wire s_axi_gmem_awready;
wire s_axi_gmem_awvalid;
wire [63 : 0] s_axi_gmem_awaddr;
wire [7 : 0] s_axi_gmem_awlen;
wire [2 : 0] s_axi_gmem_awsize;
wire [1 : 0] s_axi_gmem_awburst;
wire [2 : 0] s_axi_gmem_awprot;
wire [3 : 0] s_axi_gmem_awcache;
wire s_axi_gmem_wready;
wire s_axi_gmem_wvalid;
wire [511 : 0] s_axi_gmem_wdata;
wire [63 : 0] s_axi_gmem_wstrb;
wire s_axi_gmem_wlast;
wire s_axi_gmem_bready;
wire s_axi_gmem_bvalid;
wire [1 : 0] s_axi_gmem_bresp;


cdma cdma_0 (
  .m_axi_aclk(ap_clk),                  // input wire m_axi_aclk
  .s_axi_lite_aclk(ap_clk),        // input wire s_axi_lite_aclk
  .s_axi_lite_aresetn(ap_rst_n),  // input wire s_axi_lite_aresetn
  .cdma_introut(),              // output wire cdma_introut
  .s_axi_lite_awready(s_axi_control_AWREADY),  // output wire s_axi_lite_awready
  .s_axi_lite_awvalid(s_axi_control_AWVALID),  // input wire s_axi_lite_awvalid
  .s_axi_lite_awaddr(s_axi_control_AWADDR),    // input wire [5 : 0] s_axi_lite_awaddr
  .s_axi_lite_wready(s_axi_control_WREADY),    // output wire s_axi_lite_wready
  .s_axi_lite_wvalid(s_axi_control_WVALID),    // input wire s_axi_lite_wvalid
  .s_axi_lite_wdata(s_axi_control_WDATA),      // input wire [31 : 0] s_axi_lite_wdata
  .s_axi_lite_bready(s_axi_control_BREADY),    // input wire s_axi_lite_bready
  .s_axi_lite_bvalid(s_axi_control_BVALID),    // output wire s_axi_lite_bvalid
  .s_axi_lite_bresp(s_axi_control_BRESP),      // output wire [1 : 0] s_axi_lite_bresp
  .s_axi_lite_arready(s_axi_control_ARREADY),  // output wire s_axi_lite_arready
  .s_axi_lite_arvalid(s_axi_control_ARVALID),  // input wire s_axi_lite_arvalid
  .s_axi_lite_araddr(s_axi_control_ARADDR),    // input wire [5 : 0] s_axi_lite_araddr
  .s_axi_lite_rready(s_axi_control_RREADY),    // input wire s_axi_lite_rready
  .s_axi_lite_rvalid(s_axi_control_RVALID),    // output wire s_axi_lite_rvalid
  .s_axi_lite_rdata(s_axi_control_RDATA),      // output wire [31 : 0] s_axi_lite_rdata
  .s_axi_lite_rresp(s_axi_control_RRESP),      // output wire [1 : 0] s_axi_lite_rresp
  .m_axi_arready(s_axi_gmem_arready),            // input wire m_axi_arready
  .m_axi_arvalid(s_axi_gmem_arvalid),            // output wire m_axi_arvalid
  .m_axi_araddr(s_axi_gmem_araddr),              // output wire [63 : 0] m_axi_araddr
  .m_axi_arlen(s_axi_gmem_arlen),                // output wire [7 : 0] m_axi_arlen
  .m_axi_arsize(s_axi_gmem_arsize),              // output wire [2 : 0] m_axi_arsize
  .m_axi_arburst(s_axi_gmem_arburst),            // output wire [1 : 0] m_axi_arburst
  .m_axi_arprot(s_axi_gmem_arprot),              // output wire [2 : 0] m_axi_arprot
  .m_axi_arcache(s_axi_gmem_arcache),            // output wire [3 : 0] m_axi_arcache
  .m_axi_rready(s_axi_gmem_rready),              // output wire m_axi_rready
  .m_axi_rvalid(s_axi_gmem_rvalid),              // input wire m_axi_rvalid
  .m_axi_rdata(s_axi_gmem_rdata),                // input wire [511 : 0] m_axi_rdata
  .m_axi_rresp(s_axi_gmem_rresp),                // input wire [1 : 0] m_axi_rresp
  .m_axi_rlast(s_axi_gmem_rlast),                // input wire m_axi_rlast
  .m_axi_awready(s_axi_gmem_awready),            // input wire m_axi_awready
  .m_axi_awvalid(s_axi_gmem_awvalid),            // output wire m_axi_awvalid
  .m_axi_awaddr(s_axi_gmem_awaddr),              // output wire [63 : 0] m_axi_awaddr
  .m_axi_awlen(s_axi_gmem_awlen),                // output wire [7 : 0] m_axi_awlen
  .m_axi_awsize(s_axi_gmem_awsize),              // output wire [2 : 0] m_axi_awsize
  .m_axi_awburst(s_axi_gmem_awburst),            // output wire [1 : 0] m_axi_awburst
  .m_axi_awprot(s_axi_gmem_awprot),              // output wire [2 : 0] m_axi_awprot
  .m_axi_awcache(s_axi_gmem_awcache),            // output wire [3 : 0] m_axi_awcache
  .m_axi_wready(s_axi_gmem_wready),              // input wire m_axi_wready
  .m_axi_wvalid(s_axi_gmem_wvalid),              // output wire m_axi_wvalid
  .m_axi_wdata(s_axi_gmem_wdata),                // output wire [511 : 0] m_axi_wdata
  .m_axi_wstrb(s_axi_gmem_wstrb),                // output wire [63 : 0] m_axi_wstrb
  .m_axi_wlast(s_axi_gmem_wlast),                // output wire m_axi_wlast
  .m_axi_bready(s_axi_gmem_bready),              // output wire m_axi_bready
  .m_axi_bvalid(s_axi_gmem_bvalid),              // input wire m_axi_bvalid
  .m_axi_bresp(s_axi_gmem_bresp),                // input wire [1 : 0] m_axi_bresp
  .cdma_tvect_out()          // output wire [31 : 0] cdma_tvect_out
);

  AXI_MM_IC AXI_MM_IC_i
       (.ACLK_IN(ap_clk),
        .ARESETN_IN(ap_rst_n),
        .M00_AXI_araddr(m00_axi_gmem_araddr),
        .M00_AXI_arburst(m00_axi_gmem_arburst),
        .M00_AXI_arcache(m00_axi_gmem_arcache),
        .M00_AXI_arlen(m00_axi_gmem_arlen),
        .M00_AXI_arlock(m00_axi_gmem_arlock),
        .M00_AXI_arprot(m00_axi_gmem_arprot),
        .M00_AXI_arqos(m00_axi_gmem_arqos),
        .M00_AXI_arready(m00_axi_gmem_arready),
        .M00_AXI_arregion(m00_axi_gmem_arregion),
        .M00_AXI_arsize(m00_axi_gmem_arsize),
        .M00_AXI_arvalid(m00_axi_gmem_arvalid),
        .M00_AXI_awaddr(m00_axi_gmem_awaddr),
        .M00_AXI_awburst(m00_axi_gmem_awburst),
        .M00_AXI_awcache(m00_axi_gmem_awcache),
        .M00_AXI_awlen(m00_axi_gmem_awlen),
        .M00_AXI_awlock(m00_axi_gmem_awlock),
        .M00_AXI_awprot(m00_axi_gmem_awprot),
        .M00_AXI_awqos(m00_axi_gmem_awqos),
        .M00_AXI_awready(m00_axi_gmem_awready),
        .M00_AXI_awregion(m00_axi_gmem_awregion),
        .M00_AXI_awsize(m00_axi_gmem_awsize),
        .M00_AXI_awvalid(m00_axi_gmem_awvalid),
        .M00_AXI_bready(m00_axi_gmem_bready),
        .M00_AXI_bresp(m00_axi_gmem_bresp),
        .M00_AXI_bvalid(m00_axi_gmem_bvalid),
        .M00_AXI_rdata(m00_axi_gmem_rdata),
        .M00_AXI_rlast(m00_axi_gmem_rlast),
        .M00_AXI_rready(m00_axi_gmem_rready),
        .M00_AXI_rresp(m00_axi_gmem_rresp),
        .M00_AXI_rvalid(m00_axi_gmem_rvalid),
        .M00_AXI_wdata(m00_axi_gmem_wdata),
        .M00_AXI_wlast(m00_axi_gmem_wlast),
        .M00_AXI_wready(m00_axi_gmem_wready),
        .M00_AXI_wstrb(m00_axi_gmem_wstrb),
        .M00_AXI_wvalid(m00_axi_gmem_wvalid),
        .M01_AXI_araddr(m01_axi_gmem_araddr),
        .M01_AXI_arburst(m01_axi_gmem_arburst),
        .M01_AXI_arcache(m01_axi_gmem_arcache),
        .M01_AXI_arlen(m01_axi_gmem_arlen),
        .M01_AXI_arlock(m01_axi_gmem_arlock),
        .M01_AXI_arprot(m01_axi_gmem_arprot),
        .M01_AXI_arqos(m01_axi_gmem_arqos),
        .M01_AXI_arready(m01_axi_gmem_arready),
        .M01_AXI_arregion(m01_axi_gmem_arregion),
        .M01_AXI_arsize(m01_axi_gmem_arsize),
        .M01_AXI_arvalid(m01_axi_gmem_arvalid),
        .M01_AXI_awaddr(m01_axi_gmem_awaddr),
        .M01_AXI_awburst(m01_axi_gmem_awburst),
        .M01_AXI_awcache(m01_axi_gmem_awcache),
        .M01_AXI_awlen(m01_axi_gmem_awlen),
        .M01_AXI_awlock(m01_axi_gmem_awlock),
        .M01_AXI_awprot(m01_axi_gmem_awprot),
        .M01_AXI_awqos(m01_axi_gmem_awqos),
        .M01_AXI_awready(m01_axi_gmem_awready),
        .M01_AXI_awregion(m01_axi_gmem_awregion),
        .M01_AXI_awsize(m01_axi_gmem_awsize),
        .M01_AXI_awvalid(m01_axi_gmem_awvalid),
        .M01_AXI_bready(m01_axi_gmem_bready),
        .M01_AXI_bresp(m01_axi_gmem_bresp),
        .M01_AXI_bvalid(m01_axi_gmem_bvalid),
        .M01_AXI_rdata(m01_axi_gmem_rdata),
        .M01_AXI_rlast(m01_axi_gmem_rlast),
        .M01_AXI_rready(m01_axi_gmem_rready),
        .M01_AXI_rresp(m01_axi_gmem_rresp),
        .M01_AXI_rvalid(m01_axi_gmem_rvalid),
        .M01_AXI_wdata(m01_axi_gmem_wdata),
        .M01_AXI_wlast(m01_axi_gmem_wlast),
        .M01_AXI_wready(m01_axi_gmem_wready),
        .M01_AXI_wstrb(m01_axi_gmem_wstrb),
        .M01_AXI_wvalid(m01_axi_gmem_wvalid),
        .M02_AXI_araddr(m02_axi_gmem_araddr),
        .M02_AXI_arburst(m02_axi_gmem_arburst),
        .M02_AXI_arcache(m02_axi_gmem_arcache),
        .M02_AXI_arlen(m02_axi_gmem_arlen),
        .M02_AXI_arlock(m02_axi_gmem_arlock),
        .M02_AXI_arprot(m02_axi_gmem_arprot),
        .M02_AXI_arqos(m02_axi_gmem_arqos),
        .M02_AXI_arready(m02_axi_gmem_arready),
        .M02_AXI_arregion(m02_axi_gmem_arregion),
        .M02_AXI_arsize(m02_axi_gmem_arsize),
        .M02_AXI_arvalid(m02_axi_gmem_arvalid),
        .M02_AXI_awaddr(m02_axi_gmem_awaddr),
        .M02_AXI_awburst(m02_axi_gmem_awburst),
        .M02_AXI_awcache(m02_axi_gmem_awcache),
        .M02_AXI_awlen(m02_axi_gmem_awlen),
        .M02_AXI_awlock(m02_axi_gmem_awlock),
        .M02_AXI_awprot(m02_axi_gmem_awprot),
        .M02_AXI_awqos(m02_axi_gmem_awqos),
        .M02_AXI_awready(m02_axi_gmem_awready),
        .M02_AXI_awregion(m02_axi_gmem_awregion),
        .M02_AXI_awsize(m02_axi_gmem_awsize),
        .M02_AXI_awvalid(m02_axi_gmem_awvalid),
        .M02_AXI_bready(m02_axi_gmem_bready),
        .M02_AXI_bresp(m02_axi_gmem_bresp),
        .M02_AXI_bvalid(m02_axi_gmem_bvalid),
        .M02_AXI_rdata(m02_axi_gmem_rdata),
        .M02_AXI_rlast(m02_axi_gmem_rlast),
        .M02_AXI_rready(m02_axi_gmem_rready),
        .M02_AXI_rresp(m02_axi_gmem_rresp),
        .M02_AXI_rvalid(m02_axi_gmem_rvalid),
        .M02_AXI_wdata(m02_axi_gmem_wdata),
        .M02_AXI_wlast(m02_axi_gmem_wlast),
        .M02_AXI_wready(m02_axi_gmem_wready),
        .M02_AXI_wstrb(m02_axi_gmem_wstrb),
        .M02_AXI_wvalid(m02_axi_gmem_wvalid),
        .M03_AXI_araddr(m03_axi_gmem_araddr),
        .M03_AXI_arburst(m03_axi_gmem_arburst),
        .M03_AXI_arcache(m03_axi_gmem_arcache),
        .M03_AXI_arlen(m03_axi_gmem_arlen),
        .M03_AXI_arlock(m03_axi_gmem_arlock),
        .M03_AXI_arprot(m03_axi_gmem_arprot),
        .M03_AXI_arqos(m03_axi_gmem_arqos),
        .M03_AXI_arready(m03_axi_gmem_arready),
        .M03_AXI_arregion(m03_axi_gmem_arregion),
        .M03_AXI_arsize(m03_axi_gmem_arsize),
        .M03_AXI_arvalid(m03_axi_gmem_arvalid),
        .M03_AXI_awaddr(m03_axi_gmem_awaddr),
        .M03_AXI_awburst(m03_axi_gmem_awburst),
        .M03_AXI_awcache(m03_axi_gmem_awcache),
        .M03_AXI_awlen(m03_axi_gmem_awlen),
        .M03_AXI_awlock(m03_axi_gmem_awlock),
        .M03_AXI_awprot(m03_axi_gmem_awprot),
        .M03_AXI_awqos(m03_axi_gmem_awqos),
        .M03_AXI_awready(m03_axi_gmem_awready),
        .M03_AXI_awregion(m03_axi_gmem_awregion),
        .M03_AXI_awsize(m03_axi_gmem_awsize),
        .M03_AXI_awvalid(m03_axi_gmem_awvalid),
        .M03_AXI_bready(m03_axi_gmem_bready),
        .M03_AXI_bresp(m03_axi_gmem_bresp),
        .M03_AXI_bvalid(m03_axi_gmem_bvalid),
        .M03_AXI_rdata(m03_axi_gmem_rdata),
        .M03_AXI_rlast(m03_axi_gmem_rlast),
        .M03_AXI_rready(m03_axi_gmem_rready),
        .M03_AXI_rresp(m03_axi_gmem_rresp),
        .M03_AXI_rvalid(m03_axi_gmem_rvalid),
        .M03_AXI_wdata(m03_axi_gmem_wdata),
        .M03_AXI_wlast(m03_axi_gmem_wlast),
        .M03_AXI_wready(m03_axi_gmem_wready),
        .M03_AXI_wstrb(m03_axi_gmem_wstrb),
        .M03_AXI_wvalid(m03_axi_gmem_wvalid),
        .M04_AXI_araddr(m04_axi_gmem_araddr),
        .M04_AXI_arburst(m04_axi_gmem_arburst),
        .M04_AXI_arcache(m04_axi_gmem_arcache),
        .M04_AXI_arlen(m04_axi_gmem_arlen),
        .M04_AXI_arlock(m04_axi_gmem_arlock),
        .M04_AXI_arprot(m04_axi_gmem_arprot),
        .M04_AXI_arqos(m04_axi_gmem_arqos),
        .M04_AXI_arready(m04_axi_gmem_arready),
        .M04_AXI_arregion(m04_axi_gmem_arregion),
        .M04_AXI_arsize(m04_axi_gmem_arsize),
        .M04_AXI_arvalid(m04_axi_gmem_arvalid),
        .M04_AXI_awaddr(m04_axi_gmem_awaddr),
        .M04_AXI_awburst(m04_axi_gmem_awburst),
        .M04_AXI_awcache(m04_axi_gmem_awcache),
        .M04_AXI_awlen(m04_axi_gmem_awlen),
        .M04_AXI_awlock(m04_axi_gmem_awlock),
        .M04_AXI_awprot(m04_axi_gmem_awprot),
        .M04_AXI_awqos(m04_axi_gmem_awqos),
        .M04_AXI_awready(m04_axi_gmem_awready),
        .M04_AXI_awregion(m04_axi_gmem_awregion),
        .M04_AXI_awsize(m04_axi_gmem_awsize),
        .M04_AXI_awvalid(m04_axi_gmem_awvalid),
        .M04_AXI_bready(m04_axi_gmem_bready),
        .M04_AXI_bresp(m04_axi_gmem_bresp),
        .M04_AXI_bvalid(m04_axi_gmem_bvalid),
        .M04_AXI_rdata(m04_axi_gmem_rdata),
        .M04_AXI_rlast(m04_axi_gmem_rlast),
        .M04_AXI_rready(m04_axi_gmem_rready),
        .M04_AXI_rresp(m04_axi_gmem_rresp),
        .M04_AXI_rvalid(m04_axi_gmem_rvalid),
        .M04_AXI_wdata(m04_axi_gmem_wdata),
        .M04_AXI_wlast(m04_axi_gmem_wlast),
        .M04_AXI_wready(m04_axi_gmem_wready),
        .M04_AXI_wstrb(m04_axi_gmem_wstrb),
        .M04_AXI_wvalid(m04_axi_gmem_wvalid),
        .M05_AXI_araddr(m05_axi_gmem_araddr),
        .M05_AXI_arburst(m05_axi_gmem_arburst),
        .M05_AXI_arcache(m05_axi_gmem_arcache),
        .M05_AXI_arlen(m05_axi_gmem_arlen),
        .M05_AXI_arlock(m05_axi_gmem_arlock),
        .M05_AXI_arprot(m05_axi_gmem_arprot),
        .M05_AXI_arqos(m05_axi_gmem_arqos),
        .M05_AXI_arready(m05_axi_gmem_arready),
        .M05_AXI_arregion(m05_axi_gmem_arregion),
        .M05_AXI_arsize(m05_axi_gmem_arsize),
        .M05_AXI_arvalid(m05_axi_gmem_arvalid),
        .M05_AXI_awaddr(m05_axi_gmem_awaddr),
        .M05_AXI_awburst(m05_axi_gmem_awburst),
        .M05_AXI_awcache(m05_axi_gmem_awcache),
        .M05_AXI_awlen(m05_axi_gmem_awlen),
        .M05_AXI_awlock(m05_axi_gmem_awlock),
        .M05_AXI_awprot(m05_axi_gmem_awprot),
        .M05_AXI_awqos(m05_axi_gmem_awqos),
        .M05_AXI_awready(m05_axi_gmem_awready),
        .M05_AXI_awregion(m05_axi_gmem_awregion),
        .M05_AXI_awsize(m05_axi_gmem_awsize),
        .M05_AXI_awvalid(m05_axi_gmem_awvalid),
        .M05_AXI_bready(m05_axi_gmem_bready),
        .M05_AXI_bresp(m05_axi_gmem_bresp),
        .M05_AXI_bvalid(m05_axi_gmem_bvalid),
        .M05_AXI_rdata(m05_axi_gmem_rdata),
        .M05_AXI_rlast(m05_axi_gmem_rlast),
        .M05_AXI_rready(m05_axi_gmem_rready),
        .M05_AXI_rresp(m05_axi_gmem_rresp),
        .M05_AXI_rvalid(m05_axi_gmem_rvalid),
        .M05_AXI_wdata(m05_axi_gmem_wdata),
        .M05_AXI_wlast(m05_axi_gmem_wlast),
        .M05_AXI_wready(m05_axi_gmem_wready),
        .M05_AXI_wstrb(m05_axi_gmem_wstrb),
        .M05_AXI_wvalid(m05_axi_gmem_wvalid),
        .S00_AXI_araddr(s_axi_gmem_araddr),
        .S00_AXI_arburst(s_axi_gmem_arburst),
        .S00_AXI_arcache(s_axi_gmem_arcache),
        .S00_AXI_arlen(s_axi_gmem_arlen),
        .S00_AXI_arlock(s_axi_gmem_arlock),
        .S00_AXI_arprot(s_axi_gmem_arprot),
        .S00_AXI_arqos(s_axi_gmem_arqos),
        .S00_AXI_arready(s_axi_gmem_arready),
        .S00_AXI_arsize(s_axi_gmem_arsize),
        .S00_AXI_arvalid(s_axi_gmem_arvalid),
        .S00_AXI_awaddr(s_axi_gmem_awaddr),
        .S00_AXI_awburst(s_axi_gmem_awburst),
        .S00_AXI_awcache(s_axi_gmem_awcache),
        .S00_AXI_awlen(s_axi_gmem_awlen),
        .S00_AXI_awlock(s_axi_gmem_awlock),
        .S00_AXI_awprot(s_axi_gmem_awprot),
        .S00_AXI_awqos(s_axi_gmem_awqos),
        .S00_AXI_awready(s_axi_gmem_awready),
        .S00_AXI_awsize(s_axi_gmem_awsize),
        .S00_AXI_awvalid(s_axi_gmem_awvalid),
        .S00_AXI_bready(s_axi_gmem_bready),
        .S00_AXI_bresp(s_axi_gmem_bresp),
        .S00_AXI_bvalid(s_axi_gmem_bvalid),
        .S00_AXI_rdata(s_axi_gmem_rdata),
        .S00_AXI_rlast(s_axi_gmem_rlast),
        .S00_AXI_rready(s_axi_gmem_rready),
        .S00_AXI_rresp(s_axi_gmem_rresp),
        .S00_AXI_rvalid(s_axi_gmem_rvalid),
        .S00_AXI_wdata(s_axi_gmem_wdata),
        .S00_AXI_wlast(s_axi_gmem_wlast),
        .S00_AXI_wready(s_axi_gmem_wready),
        .S00_AXI_wstrb(s_axi_gmem_wstrb),
        .S00_AXI_wvalid(s_axi_gmem_wvalid));
endmodule
