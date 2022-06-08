module basic (
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 2 3.3V supply
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // User maskable interrupt signals
    output [2:0] user_irq
);


//wire maxi_awready = 1;
// wire [31:0] rdata; 
wire maxi_awready =0;
wire maxi_wready=0;
wire [2-1:0] maxi_bresp=0;
wire maxi_bvalid=0;
wire maxi_arready=1;
wire [32-1:0] maxi_rdata;
assign maxi_rdata = wbs_dat_i;
wire [2-1:0] maxi_rresp=1;
wire maxi_rlast=1;
wire maxi_rvalid=1;
wire [32-1:0] saxi_awaddr=0;
wire [4-1:0] saxi_awcache=0;
wire [3-1:0] saxi_awprot=0;
wire saxi_awvalid=1;
wire [32-1:0] saxi_wdata=8;
wire [4-1:0] saxi_wstrb=1;
wire saxi_wvalid=1;
wire saxi_bready=1;
wire [32-1:0] saxi_araddr;
assign saxi_araddr = wbs_adr_i;
wire [4-1:0] saxi_arcache=1;
wire [3-1:0] saxi_arprot=1;
wire saxi_arvalid=1;
wire saxi_rready=1;



wire irq;
assign user_irq = irq*4;
wire[32-1:0] maxi_awaddr;
wire[8-1:0] maxi_awlen;
wire [3-1:0] maxi_awsize;
wire [2-1:0] maxi_awburst;
wire [1-1:0] maxi_awlock;
wire [4-1:0] maxi_awcache;
wire [3-1:0] maxi_awprot;
wire [4-1:0] maxi_awqos;
wire [2-1:0] maxi_awuser;
wire maxi_awvalid;
//input maxi_awready;
wire[32-1:0] maxi_wdata;
wire[4-1:0] maxi_wstrb;
wire maxi_wlast;
wire maxi_wvalid;
//input maxi_wready;
//input [2-1:0] maxi_bresp;
//input maxi_bvalid;
wire maxi_bready;
wire[32-1:0] maxi_araddr;
wire[8-1:0] maxi_arlen;
wire [3-1:0] maxi_arsize;
wire [2-1:0] maxi_arburst;
wire [1-1:0] maxi_arlock;
wire [4-1:0] maxi_arcache;
wire [3-1:0] maxi_arprot;
wire [4-1:0] maxi_arqos;
wire [2-1:0] maxi_aruser;
wire maxi_arvalid;
// input maxi_arready;
// input [32-1:0] maxi_rdata;
// input [2-1:0] maxi_rresp;
// input maxi_rlast;
// input maxi_rvalid;
wire maxi_rready;
// input [32-1:0] saxi_awaddr;
// input [4-1:0] saxi_awcache;
// input [3-1:0] saxi_awprot;
// input saxi_awvalid;
wire saxi_awready;
// input [32-1:0] saxi_wdata;
// input [4-1:0] saxi_wstrb;
// input saxi_wvalid;
wire saxi_wready;
wire [2-1:0] saxi_bresp;
wire saxi_bvalid;
// input saxi_bready;
// input [32-1:0] saxi_araddr;
// input [4-1:0] saxi_arcache;
// input [3-1:0] saxi_arprot;
// input saxi_arvalid;
wire saxi_arready;
wire[32-1:0] saxi_rdata;
wire [2-1:0] saxi_rresp;
wire saxi_rvalid;
// input saxi_rready;

basic_0 basic_0(
  .CLK(wb_clk_i),
  .RESETN(wb_rst_i),
  .irq(irq),
  .maxi_awaddr(maxi_awaddr),
  .maxi_awlen(maxi_awlen),
  .maxi_awsize(maxi_awsize),
  .maxi_awburst(maxi_awburst),
  .maxi_awlock(maxi_awlock),
  .maxi_awcache(maxi_awcache),
  .maxi_awprot(maxi_awprot),
  .maxi_awqos(maxi_awqos),
  .maxi_awuser(maxi_awuser),
  .maxi_awvalid(maxi_awvalid),
  .maxi_awready(maxi_awready),
  .maxi_wdata(maxi_wdata),
  .maxi_wstrb(maxi_wstrb),
  .maxi_wlast(maxi_wlast),
  .maxi_wvalid(maxi_wvalid),
  .maxi_wready(maxi_wready),
  .maxi_bresp(maxi_bresp),
  .maxi_bvalid(maxi_bvalid),
  .maxi_bready(maxi_bready),
  .maxi_araddr(maxi_araddr),
  .maxi_arlen(maxi_arlen),
  .maxi_arsize(maxi_arsize),
  .maxi_arburst(maxi_arburst),
  .maxi_arlock(maxi_arlock),
  .maxi_arcache(maxi_arcache),
  .maxi_arprot(maxi_arprot),
  .maxi_arqos(maxi_arqos),
  .maxi_aruser(maxi_aruser),
  .maxi_arvalid(maxi_arvalid),
  .maxi_arready(maxi_arready),
  .maxi_rdata(maxi_rdata),
  .maxi_rresp(maxi_rresp),
  .maxi_rlast(maxi_rlast),
  .maxi_rvalid(maxi_rvalid),
  .maxi_rready(maxi_rready),
  .saxi_awaddr(saxi_awaddr),
  .saxi_awcache(saxi_awcache),
  .saxi_awprot(saxi_awprot),
  .saxi_awvalid(saxi_awvalid),
  .saxi_awready(saxi_awready),
  .saxi_wdata(saxi_wdata),
  .saxi_wstrb(saxi_wstrb),
  .saxi_wvalid(saxi_wvalid),
  .saxi_wready(saxi_wready),
  .saxi_bresp(saxi_bresp),
  .saxi_bvalid(saxi_bvalid),
  .saxi_bready(saxi_bready),
  .saxi_araddr(saxi_araddr),
  .saxi_arcache(saxi_arcache),
  .saxi_arprot(saxi_arprot),
  .saxi_arvalid(saxi_arvalid),
  .saxi_arready(saxi_arready),
  .saxi_rdata(saxi_rdata),
  .saxi_rresp(saxi_rresp),
  .saxi_rvalid(saxi_rvalid),
  .saxi_rready(saxi_rready)
);

endmodule



module basic_0
(
  input CLK,
  input RESETN,
  output reg irq,
  output reg [32-1:0] maxi_awaddr,
  output reg [8-1:0] maxi_awlen,
  output [3-1:0] maxi_awsize,
  output [2-1:0] maxi_awburst,
  output [1-1:0] maxi_awlock,
  output [4-1:0] maxi_awcache,
  output [3-1:0] maxi_awprot,
  output [4-1:0] maxi_awqos,
  output [2-1:0] maxi_awuser,
  output reg maxi_awvalid,
  input maxi_awready,
  output reg [32-1:0] maxi_wdata,
  output reg [4-1:0] maxi_wstrb,
  output reg maxi_wlast,
  output reg maxi_wvalid,
  input maxi_wready,
  input [2-1:0] maxi_bresp,
  input maxi_bvalid,
  output maxi_bready,
  output reg [32-1:0] maxi_araddr,
  output reg [8-1:0] maxi_arlen,
  output [3-1:0] maxi_arsize,
  output [2-1:0] maxi_arburst,
  output [1-1:0] maxi_arlock,
  output [4-1:0] maxi_arcache,
  output [3-1:0] maxi_arprot,
  output [4-1:0] maxi_arqos,
  output [2-1:0] maxi_aruser,
  output reg maxi_arvalid,
  input maxi_arready,
  input [32-1:0] maxi_rdata,
  input [2-1:0] maxi_rresp,
  input maxi_rlast,
  input maxi_rvalid,
  output maxi_rready,
  input [32-1:0] saxi_awaddr,
  input [4-1:0] saxi_awcache,
  input [3-1:0] saxi_awprot,
  input saxi_awvalid,
  output saxi_awready,
  input [32-1:0] saxi_wdata,
  input [4-1:0] saxi_wstrb,
  input saxi_wvalid,
  output saxi_wready,
  output [2-1:0] saxi_bresp,
  output reg saxi_bvalid,
  input saxi_bready,
  input [32-1:0] saxi_araddr,
  input [4-1:0] saxi_arcache,
  input [3-1:0] saxi_arprot,
  input saxi_arvalid,
  output saxi_arready,
  output reg [32-1:0] saxi_rdata,
  output [2-1:0] saxi_rresp,
  output reg saxi_rvalid,
  input saxi_rready
);

  wire RESETN_inv;
  assign RESETN_inv = !RESETN;
  wire RESETN_inv_buf;
  reg _RESETN_inv_1;
  reg _RESETN_inv_2;
  assign RESETN_inv_buf = _RESETN_inv_2;
  assign maxi_awsize = 2;
  assign maxi_awburst = 1;
  assign maxi_awlock = 0;
  assign maxi_awcache = 3;
  assign maxi_awprot = 0;
  assign maxi_awqos = 0;
  assign maxi_awuser = 0;
  assign maxi_bready = 1;
  assign maxi_arsize = 2;
  assign maxi_arburst = 1;
  assign maxi_arlock = 0;
  assign maxi_arcache = 3;
  assign maxi_arprot = 0;
  assign maxi_arqos = 0;
  assign maxi_aruser = 0;
  reg [3-1:0] outstanding_wcount_0;
  reg _maxi_read_start;
  reg [8-1:0] _maxi_read_op_sel;
  reg [32-1:0] _maxi_read_global_addr;
  reg [33-1:0] _maxi_read_global_size;
  reg [32-1:0] _maxi_read_local_addr;
  reg [32-1:0] _maxi_read_local_stride;
  reg [33-1:0] _maxi_read_local_size;
  reg [32-1:0] _maxi_read_local_blocksize;
  wire _maxi_read_req_fifo_enq;
  wire [137-1:0] _maxi_read_req_fifo_wdata;
  wire _maxi_read_req_fifo_full;
  wire _maxi_read_req_fifo_almost_full;
  wire _maxi_read_req_fifo_deq;
  wire [137-1:0] _maxi_read_req_fifo_rdata;
  wire _maxi_read_req_fifo_empty;
  wire _maxi_read_req_fifo_almost_empty;

  _maxi_read_req_fifo
  inst__maxi_read_req_fifo
  (
    .CLK(CLK),
    .RST(RESETN_inv_buf),
    ._maxi_read_req_fifo_enq(_maxi_read_req_fifo_enq),
    ._maxi_read_req_fifo_wdata(_maxi_read_req_fifo_wdata),
    ._maxi_read_req_fifo_full(_maxi_read_req_fifo_full),
    ._maxi_read_req_fifo_almost_full(_maxi_read_req_fifo_almost_full),
    ._maxi_read_req_fifo_deq(_maxi_read_req_fifo_deq),
    ._maxi_read_req_fifo_rdata(_maxi_read_req_fifo_rdata),
    ._maxi_read_req_fifo_empty(_maxi_read_req_fifo_empty),
    ._maxi_read_req_fifo_almost_empty(_maxi_read_req_fifo_almost_empty)
  );

  reg [4-1:0] count__maxi_read_req_fifo;
  wire [8-1:0] _maxi_read_op_sel_fifo;
  wire [32-1:0] _maxi_read_local_addr_fifo;
  wire [32-1:0] _maxi_read_local_stride_fifo;
  wire [33-1:0] _maxi_read_local_size_fifo;
  wire [32-1:0] _maxi_read_local_blocksize_fifo;
  wire [8-1:0] unpack_read_req_op_sel_1;
  wire [32-1:0] unpack_read_req_local_addr_2;
  wire [32-1:0] unpack_read_req_local_stride_3;
  wire [33-1:0] unpack_read_req_local_size_4;
  wire [32-1:0] unpack_read_req_local_blocksize_5;
  assign unpack_read_req_op_sel_1 = _maxi_read_req_fifo_rdata[136:129];
  assign unpack_read_req_local_addr_2 = _maxi_read_req_fifo_rdata[128:97];
  assign unpack_read_req_local_stride_3 = _maxi_read_req_fifo_rdata[96:65];
  assign unpack_read_req_local_size_4 = _maxi_read_req_fifo_rdata[64:32];
  assign unpack_read_req_local_blocksize_5 = _maxi_read_req_fifo_rdata[31:0];
  assign _maxi_read_op_sel_fifo = unpack_read_req_op_sel_1;
  assign _maxi_read_local_addr_fifo = unpack_read_req_local_addr_2;
  assign _maxi_read_local_stride_fifo = unpack_read_req_local_stride_3;
  assign _maxi_read_local_size_fifo = unpack_read_req_local_size_4;
  assign _maxi_read_local_blocksize_fifo = unpack_read_req_local_blocksize_5;
  reg [8-1:0] _maxi_read_op_sel_buf;
  reg [32-1:0] _maxi_read_local_addr_buf;
  reg [32-1:0] _maxi_read_local_stride_buf;
  reg [33-1:0] _maxi_read_local_size_buf;
  reg [32-1:0] _maxi_read_local_blocksize_buf;
  reg _maxi_read_req_idle;
  reg _maxi_read_data_idle;
  wire _maxi_read_idle;
  assign _maxi_read_idle = !_maxi_read_start && _maxi_read_req_idle && _maxi_read_req_fifo_empty && _maxi_read_data_idle;
  reg _maxi_write_start;
  reg [8-1:0] _maxi_write_op_sel;
  reg [32-1:0] _maxi_write_global_addr;
  reg [33-1:0] _maxi_write_global_size;
  reg [32-1:0] _maxi_write_local_addr;
  reg [32-1:0] _maxi_write_local_stride;
  reg [33-1:0] _maxi_write_local_size;
  reg [32-1:0] _maxi_write_local_blocksize;
  wire _maxi_write_req_fifo_enq;
  wire [137-1:0] _maxi_write_req_fifo_wdata;
  wire _maxi_write_req_fifo_full;
  wire _maxi_write_req_fifo_almost_full;
  wire _maxi_write_req_fifo_deq;
  wire [137-1:0] _maxi_write_req_fifo_rdata;
  wire _maxi_write_req_fifo_empty;
  wire _maxi_write_req_fifo_almost_empty;

  _maxi_write_req_fifo
  inst__maxi_write_req_fifo
  (
    .CLK(CLK),
    .RST(RESETN_inv_buf),
    ._maxi_write_req_fifo_enq(_maxi_write_req_fifo_enq),
    ._maxi_write_req_fifo_wdata(_maxi_write_req_fifo_wdata),
    ._maxi_write_req_fifo_full(_maxi_write_req_fifo_full),
    ._maxi_write_req_fifo_almost_full(_maxi_write_req_fifo_almost_full),
    ._maxi_write_req_fifo_deq(_maxi_write_req_fifo_deq),
    ._maxi_write_req_fifo_rdata(_maxi_write_req_fifo_rdata),
    ._maxi_write_req_fifo_empty(_maxi_write_req_fifo_empty),
    ._maxi_write_req_fifo_almost_empty(_maxi_write_req_fifo_almost_empty)
  );

  reg [4-1:0] count__maxi_write_req_fifo;
  wire [8-1:0] _maxi_write_op_sel_fifo;
  wire [32-1:0] _maxi_write_local_addr_fifo;
  wire [32-1:0] _maxi_write_local_stride_fifo;
  wire [33-1:0] _maxi_write_size_fifo;
  wire [32-1:0] _maxi_write_local_blocksize_fifo;
  wire [8-1:0] unpack_write_req_op_sel_6;
  wire [32-1:0] unpack_write_req_local_addr_7;
  wire [32-1:0] unpack_write_req_local_stride_8;
  wire [33-1:0] unpack_write_req_size_9;
  wire [32-1:0] unpack_write_req_local_blocksize_10;
  assign unpack_write_req_op_sel_6 = _maxi_write_req_fifo_rdata[136:129];
  assign unpack_write_req_local_addr_7 = _maxi_write_req_fifo_rdata[128:97];
  assign unpack_write_req_local_stride_8 = _maxi_write_req_fifo_rdata[96:65];
  assign unpack_write_req_size_9 = _maxi_write_req_fifo_rdata[64:32];
  assign unpack_write_req_local_blocksize_10 = _maxi_write_req_fifo_rdata[31:0];
  assign _maxi_write_op_sel_fifo = unpack_write_req_op_sel_6;
  assign _maxi_write_local_addr_fifo = unpack_write_req_local_addr_7;
  assign _maxi_write_local_stride_fifo = unpack_write_req_local_stride_8;
  assign _maxi_write_size_fifo = unpack_write_req_size_9;
  assign _maxi_write_local_blocksize_fifo = unpack_write_req_local_blocksize_10;
  reg [8-1:0] _maxi_write_op_sel_buf;
  reg [32-1:0] _maxi_write_local_addr_buf;
  reg [32-1:0] _maxi_write_local_stride_buf;
  reg [33-1:0] _maxi_write_size_buf;
  reg [32-1:0] _maxi_write_local_blocksize_buf;
  reg _maxi_write_req_idle;
  reg _maxi_write_data_idle;
  wire _maxi_write_idle;
  assign _maxi_write_idle = !_maxi_write_start && _maxi_write_req_idle && _maxi_write_req_fifo_empty && _maxi_write_data_idle;
  reg [32-1:0] _maxi_global_base_addr;
  assign saxi_bresp = 0;
  assign saxi_rresp = 0;
  reg signed [32-1:0] _saxi_register_0;
  reg signed [32-1:0] _saxi_register_1;
  reg signed [32-1:0] _saxi_register_2;
  reg signed [32-1:0] _saxi_register_3;
  reg signed [32-1:0] _saxi_register_4;
  reg signed [32-1:0] _saxi_register_5;
  reg signed [32-1:0] _saxi_register_6;
  reg signed [32-1:0] _saxi_register_7;
  reg signed [32-1:0] _saxi_register_8;
  reg signed [32-1:0] _saxi_register_9;
  reg signed [32-1:0] _saxi_register_10;
  reg signed [32-1:0] _saxi_register_11;
  reg signed [32-1:0] _saxi_register_12;
  reg signed [32-1:0] _saxi_register_13;
  reg signed [32-1:0] _saxi_register_14;
  reg signed [32-1:0] _saxi_register_15;
  reg signed [32-1:0] _saxi_register_16;
  reg signed [32-1:0] _saxi_register_17;
  reg signed [32-1:0] _saxi_register_18;
  reg signed [32-1:0] _saxi_register_19;
  reg signed [32-1:0] _saxi_register_20;
  reg signed [32-1:0] _saxi_register_21;
  reg signed [32-1:0] _saxi_register_22;
  reg signed [32-1:0] _saxi_register_23;
  reg signed [32-1:0] _saxi_register_24;
  reg signed [32-1:0] _saxi_register_25;
  reg signed [32-1:0] _saxi_register_26;
  reg signed [32-1:0] _saxi_register_27;
  reg signed [32-1:0] _saxi_register_28;
  reg signed [32-1:0] _saxi_register_29;
  reg signed [32-1:0] _saxi_register_30;
  reg signed [32-1:0] _saxi_register_31;
  reg signed [32-1:0] _saxi_register_32;
  reg signed [32-1:0] _saxi_register_33;
  reg signed [32-1:0] _saxi_register_34;
  reg signed [32-1:0] _saxi_register_35;
  reg signed [32-1:0] _saxi_register_36;
  reg signed [32-1:0] _saxi_register_37;
  reg _saxi_flag_0;
  reg _saxi_flag_1;
  reg _saxi_flag_2;
  reg _saxi_flag_3;
  reg _saxi_flag_4;
  reg _saxi_flag_5;
  reg _saxi_flag_6;
  reg _saxi_flag_7;
  reg _saxi_flag_8;
  reg _saxi_flag_9;
  reg _saxi_flag_10;
  reg _saxi_flag_11;
  reg _saxi_flag_12;
  reg _saxi_flag_13;
  reg _saxi_flag_14;
  reg _saxi_flag_15;
  reg _saxi_flag_16;
  reg _saxi_flag_17;
  reg _saxi_flag_18;
  reg _saxi_flag_19;
  reg _saxi_flag_20;
  reg _saxi_flag_21;
  reg _saxi_flag_22;
  reg _saxi_flag_23;
  reg _saxi_flag_24;
  reg _saxi_flag_25;
  reg _saxi_flag_26;
  reg _saxi_flag_27;
  reg _saxi_flag_28;
  reg _saxi_flag_29;
  reg _saxi_flag_30;
  reg _saxi_flag_31;
  reg _saxi_flag_32;
  reg _saxi_flag_33;
  reg _saxi_flag_34;
  reg _saxi_flag_35;
  reg _saxi_flag_36;
  reg _saxi_flag_37;
  reg signed [32-1:0] _saxi_resetval_0;
  reg signed [32-1:0] _saxi_resetval_1;
  reg signed [32-1:0] _saxi_resetval_2;
  reg signed [32-1:0] _saxi_resetval_3;
  reg signed [32-1:0] _saxi_resetval_4;
  reg signed [32-1:0] _saxi_resetval_5;
  reg signed [32-1:0] _saxi_resetval_6;
  reg signed [32-1:0] _saxi_resetval_7;
  reg signed [32-1:0] _saxi_resetval_8;
  reg signed [32-1:0] _saxi_resetval_9;
  reg signed [32-1:0] _saxi_resetval_10;
  reg signed [32-1:0] _saxi_resetval_11;
  reg signed [32-1:0] _saxi_resetval_12;
  reg signed [32-1:0] _saxi_resetval_13;
  reg signed [32-1:0] _saxi_resetval_14;
  reg signed [32-1:0] _saxi_resetval_15;
  reg signed [32-1:0] _saxi_resetval_16;
  reg signed [32-1:0] _saxi_resetval_17;
  reg signed [32-1:0] _saxi_resetval_18;
  reg signed [32-1:0] _saxi_resetval_19;
  reg signed [32-1:0] _saxi_resetval_20;
  reg signed [32-1:0] _saxi_resetval_21;
  reg signed [32-1:0] _saxi_resetval_22;
  reg signed [32-1:0] _saxi_resetval_23;
  reg signed [32-1:0] _saxi_resetval_24;
  reg signed [32-1:0] _saxi_resetval_25;
  reg signed [32-1:0] _saxi_resetval_26;
  reg signed [32-1:0] _saxi_resetval_27;
  reg signed [32-1:0] _saxi_resetval_28;
  reg signed [32-1:0] _saxi_resetval_29;
  reg signed [32-1:0] _saxi_resetval_30;
  reg signed [32-1:0] _saxi_resetval_31;
  reg signed [32-1:0] _saxi_resetval_32;
  reg signed [32-1:0] _saxi_resetval_33;
  reg signed [32-1:0] _saxi_resetval_34;
  reg signed [32-1:0] _saxi_resetval_35;
  reg signed [32-1:0] _saxi_resetval_36;
  reg signed [32-1:0] _saxi_resetval_37;
  localparam _saxi_maskwidth = 6;
  localparam _saxi_mask = { _saxi_maskwidth{ 1'd1 } };
  localparam _saxi_shift = 2;
  reg [32-1:0] _saxi_register_fsm;
  localparam _saxi_register_fsm_init = 0;
  reg [32-1:0] addr_11;
  reg writevalid_12;
  reg readvalid_13;
  reg prev_awvalid_14;
  reg prev_arvalid_15;
  assign saxi_awready = (_saxi_register_fsm == 0) && (!writevalid_12 && !readvalid_13 && !saxi_bvalid && prev_awvalid_14);
  assign saxi_arready = (_saxi_register_fsm == 0) && (!readvalid_13 && !writevalid_12 && prev_arvalid_15 && !prev_awvalid_14);
  reg [_saxi_maskwidth-1:0] axis_maskaddr_16;
  wire signed [32-1:0] axislite_rdata_17;
  assign axislite_rdata_17 = (axis_maskaddr_16 == 0)? _saxi_register_0 : 
                             (axis_maskaddr_16 == 1)? _saxi_register_1 : 
                             (axis_maskaddr_16 == 2)? _saxi_register_2 : 
                             (axis_maskaddr_16 == 3)? _saxi_register_3 : 
                             (axis_maskaddr_16 == 4)? _saxi_register_4 : 
                             (axis_maskaddr_16 == 5)? _saxi_register_5 : 
                             (axis_maskaddr_16 == 6)? _saxi_register_6 : 
                             (axis_maskaddr_16 == 7)? _saxi_register_7 : 
                             (axis_maskaddr_16 == 8)? _saxi_register_8 : 
                             (axis_maskaddr_16 == 9)? _saxi_register_9 : 
                             (axis_maskaddr_16 == 10)? _saxi_register_10 : 
                             (axis_maskaddr_16 == 11)? _saxi_register_11 : 
                             (axis_maskaddr_16 == 12)? _saxi_register_12 : 
                             (axis_maskaddr_16 == 13)? _saxi_register_13 : 
                             (axis_maskaddr_16 == 14)? _saxi_register_14 : 
                             (axis_maskaddr_16 == 15)? _saxi_register_15 : 
                             (axis_maskaddr_16 == 16)? _saxi_register_16 : 
                             (axis_maskaddr_16 == 17)? _saxi_register_17 : 
                             (axis_maskaddr_16 == 18)? _saxi_register_18 : 
                             (axis_maskaddr_16 == 19)? _saxi_register_19 : 
                             (axis_maskaddr_16 == 20)? _saxi_register_20 : 
                             (axis_maskaddr_16 == 21)? _saxi_register_21 : 
                             (axis_maskaddr_16 == 22)? _saxi_register_22 : 
                             (axis_maskaddr_16 == 23)? _saxi_register_23 : 
                             (axis_maskaddr_16 == 24)? _saxi_register_24 : 
                             (axis_maskaddr_16 == 25)? _saxi_register_25 : 
                             (axis_maskaddr_16 == 26)? _saxi_register_26 : 
                             (axis_maskaddr_16 == 27)? _saxi_register_27 : 
                             (axis_maskaddr_16 == 28)? _saxi_register_28 : 
                             (axis_maskaddr_16 == 29)? _saxi_register_29 : 
                             (axis_maskaddr_16 == 30)? _saxi_register_30 : 
                             (axis_maskaddr_16 == 31)? _saxi_register_31 : 
                             (axis_maskaddr_16 == 32)? _saxi_register_32 : 
                             (axis_maskaddr_16 == 33)? _saxi_register_33 : 
                             (axis_maskaddr_16 == 34)? _saxi_register_34 : 
                             (axis_maskaddr_16 == 35)? _saxi_register_35 : 
                             (axis_maskaddr_16 == 36)? _saxi_register_36 : 
                             (axis_maskaddr_16 == 37)? _saxi_register_37 : 'hx;
  wire axislite_flag_18;
  assign axislite_flag_18 = (axis_maskaddr_16 == 0)? _saxi_flag_0 : 
                            (axis_maskaddr_16 == 1)? _saxi_flag_1 : 
                            (axis_maskaddr_16 == 2)? _saxi_flag_2 : 
                            (axis_maskaddr_16 == 3)? _saxi_flag_3 : 
                            (axis_maskaddr_16 == 4)? _saxi_flag_4 : 
                            (axis_maskaddr_16 == 5)? _saxi_flag_5 : 
                            (axis_maskaddr_16 == 6)? _saxi_flag_6 : 
                            (axis_maskaddr_16 == 7)? _saxi_flag_7 : 
                            (axis_maskaddr_16 == 8)? _saxi_flag_8 : 
                            (axis_maskaddr_16 == 9)? _saxi_flag_9 : 
                            (axis_maskaddr_16 == 10)? _saxi_flag_10 : 
                            (axis_maskaddr_16 == 11)? _saxi_flag_11 : 
                            (axis_maskaddr_16 == 12)? _saxi_flag_12 : 
                            (axis_maskaddr_16 == 13)? _saxi_flag_13 : 
                            (axis_maskaddr_16 == 14)? _saxi_flag_14 : 
                            (axis_maskaddr_16 == 15)? _saxi_flag_15 : 
                            (axis_maskaddr_16 == 16)? _saxi_flag_16 : 
                            (axis_maskaddr_16 == 17)? _saxi_flag_17 : 
                            (axis_maskaddr_16 == 18)? _saxi_flag_18 : 
                            (axis_maskaddr_16 == 19)? _saxi_flag_19 : 
                            (axis_maskaddr_16 == 20)? _saxi_flag_20 : 
                            (axis_maskaddr_16 == 21)? _saxi_flag_21 : 
                            (axis_maskaddr_16 == 22)? _saxi_flag_22 : 
                            (axis_maskaddr_16 == 23)? _saxi_flag_23 : 
                            (axis_maskaddr_16 == 24)? _saxi_flag_24 : 
                            (axis_maskaddr_16 == 25)? _saxi_flag_25 : 
                            (axis_maskaddr_16 == 26)? _saxi_flag_26 : 
                            (axis_maskaddr_16 == 27)? _saxi_flag_27 : 
                            (axis_maskaddr_16 == 28)? _saxi_flag_28 : 
                            (axis_maskaddr_16 == 29)? _saxi_flag_29 : 
                            (axis_maskaddr_16 == 30)? _saxi_flag_30 : 
                            (axis_maskaddr_16 == 31)? _saxi_flag_31 : 
                            (axis_maskaddr_16 == 32)? _saxi_flag_32 : 
                            (axis_maskaddr_16 == 33)? _saxi_flag_33 : 
                            (axis_maskaddr_16 == 34)? _saxi_flag_34 : 
                            (axis_maskaddr_16 == 35)? _saxi_flag_35 : 
                            (axis_maskaddr_16 == 36)? _saxi_flag_36 : 
                            (axis_maskaddr_16 == 37)? _saxi_flag_37 : 'hx;
  wire signed [32-1:0] axislite_resetval_19;
  assign axislite_resetval_19 = (axis_maskaddr_16 == 0)? _saxi_resetval_0 : 
                                (axis_maskaddr_16 == 1)? _saxi_resetval_1 : 
                                (axis_maskaddr_16 == 2)? _saxi_resetval_2 : 
                                (axis_maskaddr_16 == 3)? _saxi_resetval_3 : 
                                (axis_maskaddr_16 == 4)? _saxi_resetval_4 : 
                                (axis_maskaddr_16 == 5)? _saxi_resetval_5 : 
                                (axis_maskaddr_16 == 6)? _saxi_resetval_6 : 
                                (axis_maskaddr_16 == 7)? _saxi_resetval_7 : 
                                (axis_maskaddr_16 == 8)? _saxi_resetval_8 : 
                                (axis_maskaddr_16 == 9)? _saxi_resetval_9 : 
                                (axis_maskaddr_16 == 10)? _saxi_resetval_10 : 
                                (axis_maskaddr_16 == 11)? _saxi_resetval_11 : 
                                (axis_maskaddr_16 == 12)? _saxi_resetval_12 : 
                                (axis_maskaddr_16 == 13)? _saxi_resetval_13 : 
                                (axis_maskaddr_16 == 14)? _saxi_resetval_14 : 
                                (axis_maskaddr_16 == 15)? _saxi_resetval_15 : 
                                (axis_maskaddr_16 == 16)? _saxi_resetval_16 : 
                                (axis_maskaddr_16 == 17)? _saxi_resetval_17 : 
                                (axis_maskaddr_16 == 18)? _saxi_resetval_18 : 
                                (axis_maskaddr_16 == 19)? _saxi_resetval_19 : 
                                (axis_maskaddr_16 == 20)? _saxi_resetval_20 : 
                                (axis_maskaddr_16 == 21)? _saxi_resetval_21 : 
                                (axis_maskaddr_16 == 22)? _saxi_resetval_22 : 
                                (axis_maskaddr_16 == 23)? _saxi_resetval_23 : 
                                (axis_maskaddr_16 == 24)? _saxi_resetval_24 : 
                                (axis_maskaddr_16 == 25)? _saxi_resetval_25 : 
                                (axis_maskaddr_16 == 26)? _saxi_resetval_26 : 
                                (axis_maskaddr_16 == 27)? _saxi_resetval_27 : 
                                (axis_maskaddr_16 == 28)? _saxi_resetval_28 : 
                                (axis_maskaddr_16 == 29)? _saxi_resetval_29 : 
                                (axis_maskaddr_16 == 30)? _saxi_resetval_30 : 
                                (axis_maskaddr_16 == 31)? _saxi_resetval_31 : 
                                (axis_maskaddr_16 == 32)? _saxi_resetval_32 : 
                                (axis_maskaddr_16 == 33)? _saxi_resetval_33 : 
                                (axis_maskaddr_16 == 34)? _saxi_resetval_34 : 
                                (axis_maskaddr_16 == 35)? _saxi_resetval_35 : 
                                (axis_maskaddr_16 == 36)? _saxi_resetval_36 : 
                                (axis_maskaddr_16 == 37)? _saxi_resetval_37 : 'hx;
  reg _saxi_cond_0_1;
  assign saxi_wready = _saxi_register_fsm == 2;
  wire maxi_idle;
  assign maxi_idle = _maxi_write_idle & _maxi_read_idle;
  wire sw_rst_logic;
  assign sw_rst_logic = maxi_idle & _saxi_register_6;
  wire rst_logic;
  assign rst_logic = RESETN_inv_buf | sw_rst_logic;
  reg RST;
  reg _rst_logic_1;
  reg _rst_logic_2;
  wire signed [32-1:0] irq_20;
  assign irq_20 = _saxi_register_9 & _saxi_register_10;
  wire irq_busy;
  assign irq_busy = _saxi_register_5[0];
  reg irq_busy_edge_21;
  wire irq_busy_edge_22;
  assign irq_busy_edge_22 = irq_busy_edge_21 & !irq_busy;
  wire irq_extern;
  assign irq_extern = |_saxi_register_7;
  reg irq_extern_edge_23;
  wire irq_extern_edge_24;
  assign irq_extern_edge_24 = !irq_extern_edge_23 & irq_extern;
  wire [9-1:0] ram_w8_l2048_id0_0_0_addr;
  wire [8-1:0] ram_w8_l2048_id0_0_0_rdata;
  wire [8-1:0] ram_w8_l2048_id0_0_0_wdata;
  wire ram_w8_l2048_id0_0_0_wenable;
  wire ram_w8_l2048_id0_0_0_enable;
  wire [9-1:0] ram_w8_l2048_id0_0_1_addr;
  wire [8-1:0] ram_w8_l2048_id0_0_1_rdata;
  wire [8-1:0] ram_w8_l2048_id0_0_1_wdata;
  wire ram_w8_l2048_id0_0_1_wenable;
  wire ram_w8_l2048_id0_0_1_enable;
  assign ram_w8_l2048_id0_0_0_wdata = 'hx;
  assign ram_w8_l2048_id0_0_0_wenable = 0;

  ram_w8_l2048_id0_0
  inst_ram_w8_l2048_id0_0
  (
    .CLK(CLK),
    .ram_w8_l2048_id0_0_0_addr(ram_w8_l2048_id0_0_0_addr),
    .ram_w8_l2048_id0_0_0_rdata(ram_w8_l2048_id0_0_0_rdata),
    .ram_w8_l2048_id0_0_0_wdata(ram_w8_l2048_id0_0_0_wdata),
    .ram_w8_l2048_id0_0_0_wenable(ram_w8_l2048_id0_0_0_wenable),
    .ram_w8_l2048_id0_0_0_enable(ram_w8_l2048_id0_0_0_enable),
    .ram_w8_l2048_id0_0_1_addr(ram_w8_l2048_id0_0_1_addr),
    .ram_w8_l2048_id0_0_1_rdata(ram_w8_l2048_id0_0_1_rdata),
    .ram_w8_l2048_id0_0_1_wdata(ram_w8_l2048_id0_0_1_wdata),
    .ram_w8_l2048_id0_0_1_wenable(ram_w8_l2048_id0_0_1_wenable),
    .ram_w8_l2048_id0_0_1_enable(ram_w8_l2048_id0_0_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id0_1_0_addr;
  wire [8-1:0] ram_w8_l2048_id0_1_0_rdata;
  wire [8-1:0] ram_w8_l2048_id0_1_0_wdata;
  wire ram_w8_l2048_id0_1_0_wenable;
  wire ram_w8_l2048_id0_1_0_enable;
  wire [9-1:0] ram_w8_l2048_id0_1_1_addr;
  wire [8-1:0] ram_w8_l2048_id0_1_1_rdata;
  wire [8-1:0] ram_w8_l2048_id0_1_1_wdata;
  wire ram_w8_l2048_id0_1_1_wenable;
  wire ram_w8_l2048_id0_1_1_enable;
  assign ram_w8_l2048_id0_1_0_wdata = 'hx;
  assign ram_w8_l2048_id0_1_0_wenable = 0;

  ram_w8_l2048_id0_1
  inst_ram_w8_l2048_id0_1
  (
    .CLK(CLK),
    .ram_w8_l2048_id0_1_0_addr(ram_w8_l2048_id0_1_0_addr),
    .ram_w8_l2048_id0_1_0_rdata(ram_w8_l2048_id0_1_0_rdata),
    .ram_w8_l2048_id0_1_0_wdata(ram_w8_l2048_id0_1_0_wdata),
    .ram_w8_l2048_id0_1_0_wenable(ram_w8_l2048_id0_1_0_wenable),
    .ram_w8_l2048_id0_1_0_enable(ram_w8_l2048_id0_1_0_enable),
    .ram_w8_l2048_id0_1_1_addr(ram_w8_l2048_id0_1_1_addr),
    .ram_w8_l2048_id0_1_1_rdata(ram_w8_l2048_id0_1_1_rdata),
    .ram_w8_l2048_id0_1_1_wdata(ram_w8_l2048_id0_1_1_wdata),
    .ram_w8_l2048_id0_1_1_wenable(ram_w8_l2048_id0_1_1_wenable),
    .ram_w8_l2048_id0_1_1_enable(ram_w8_l2048_id0_1_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id0_2_0_addr;
  wire [8-1:0] ram_w8_l2048_id0_2_0_rdata;
  wire [8-1:0] ram_w8_l2048_id0_2_0_wdata;
  wire ram_w8_l2048_id0_2_0_wenable;
  wire ram_w8_l2048_id0_2_0_enable;
  wire [9-1:0] ram_w8_l2048_id0_2_1_addr;
  wire [8-1:0] ram_w8_l2048_id0_2_1_rdata;
  wire [8-1:0] ram_w8_l2048_id0_2_1_wdata;
  wire ram_w8_l2048_id0_2_1_wenable;
  wire ram_w8_l2048_id0_2_1_enable;
  assign ram_w8_l2048_id0_2_0_wdata = 'hx;
  assign ram_w8_l2048_id0_2_0_wenable = 0;

  ram_w8_l2048_id0_2
  inst_ram_w8_l2048_id0_2
  (
    .CLK(CLK),
    .ram_w8_l2048_id0_2_0_addr(ram_w8_l2048_id0_2_0_addr),
    .ram_w8_l2048_id0_2_0_rdata(ram_w8_l2048_id0_2_0_rdata),
    .ram_w8_l2048_id0_2_0_wdata(ram_w8_l2048_id0_2_0_wdata),
    .ram_w8_l2048_id0_2_0_wenable(ram_w8_l2048_id0_2_0_wenable),
    .ram_w8_l2048_id0_2_0_enable(ram_w8_l2048_id0_2_0_enable),
    .ram_w8_l2048_id0_2_1_addr(ram_w8_l2048_id0_2_1_addr),
    .ram_w8_l2048_id0_2_1_rdata(ram_w8_l2048_id0_2_1_rdata),
    .ram_w8_l2048_id0_2_1_wdata(ram_w8_l2048_id0_2_1_wdata),
    .ram_w8_l2048_id0_2_1_wenable(ram_w8_l2048_id0_2_1_wenable),
    .ram_w8_l2048_id0_2_1_enable(ram_w8_l2048_id0_2_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id0_3_0_addr;
  wire [8-1:0] ram_w8_l2048_id0_3_0_rdata;
  wire [8-1:0] ram_w8_l2048_id0_3_0_wdata;
  wire ram_w8_l2048_id0_3_0_wenable;
  wire ram_w8_l2048_id0_3_0_enable;
  wire [9-1:0] ram_w8_l2048_id0_3_1_addr;
  wire [8-1:0] ram_w8_l2048_id0_3_1_rdata;
  wire [8-1:0] ram_w8_l2048_id0_3_1_wdata;
  wire ram_w8_l2048_id0_3_1_wenable;
  wire ram_w8_l2048_id0_3_1_enable;
  assign ram_w8_l2048_id0_3_0_wdata = 'hx;
  assign ram_w8_l2048_id0_3_0_wenable = 0;

  ram_w8_l2048_id0_3
  inst_ram_w8_l2048_id0_3
  (
    .CLK(CLK),
    .ram_w8_l2048_id0_3_0_addr(ram_w8_l2048_id0_3_0_addr),
    .ram_w8_l2048_id0_3_0_rdata(ram_w8_l2048_id0_3_0_rdata),
    .ram_w8_l2048_id0_3_0_wdata(ram_w8_l2048_id0_3_0_wdata),
    .ram_w8_l2048_id0_3_0_wenable(ram_w8_l2048_id0_3_0_wenable),
    .ram_w8_l2048_id0_3_0_enable(ram_w8_l2048_id0_3_0_enable),
    .ram_w8_l2048_id0_3_1_addr(ram_w8_l2048_id0_3_1_addr),
    .ram_w8_l2048_id0_3_1_rdata(ram_w8_l2048_id0_3_1_rdata),
    .ram_w8_l2048_id0_3_1_wdata(ram_w8_l2048_id0_3_1_wdata),
    .ram_w8_l2048_id0_3_1_wenable(ram_w8_l2048_id0_3_1_wenable),
    .ram_w8_l2048_id0_3_1_enable(ram_w8_l2048_id0_3_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id1_0_0_addr;
  wire [8-1:0] ram_w8_l2048_id1_0_0_rdata;
  wire [8-1:0] ram_w8_l2048_id1_0_0_wdata;
  wire ram_w8_l2048_id1_0_0_wenable;
  wire ram_w8_l2048_id1_0_0_enable;
  wire [9-1:0] ram_w8_l2048_id1_0_1_addr;
  wire [8-1:0] ram_w8_l2048_id1_0_1_rdata;
  wire [8-1:0] ram_w8_l2048_id1_0_1_wdata;
  wire ram_w8_l2048_id1_0_1_wenable;
  wire ram_w8_l2048_id1_0_1_enable;
  assign ram_w8_l2048_id1_0_0_wdata = 'hx;
  assign ram_w8_l2048_id1_0_0_wenable = 0;

  ram_w8_l2048_id1_0
  inst_ram_w8_l2048_id1_0
  (
    .CLK(CLK),
    .ram_w8_l2048_id1_0_0_addr(ram_w8_l2048_id1_0_0_addr),
    .ram_w8_l2048_id1_0_0_rdata(ram_w8_l2048_id1_0_0_rdata),
    .ram_w8_l2048_id1_0_0_wdata(ram_w8_l2048_id1_0_0_wdata),
    .ram_w8_l2048_id1_0_0_wenable(ram_w8_l2048_id1_0_0_wenable),
    .ram_w8_l2048_id1_0_0_enable(ram_w8_l2048_id1_0_0_enable),
    .ram_w8_l2048_id1_0_1_addr(ram_w8_l2048_id1_0_1_addr),
    .ram_w8_l2048_id1_0_1_rdata(ram_w8_l2048_id1_0_1_rdata),
    .ram_w8_l2048_id1_0_1_wdata(ram_w8_l2048_id1_0_1_wdata),
    .ram_w8_l2048_id1_0_1_wenable(ram_w8_l2048_id1_0_1_wenable),
    .ram_w8_l2048_id1_0_1_enable(ram_w8_l2048_id1_0_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id1_1_0_addr;
  wire [8-1:0] ram_w8_l2048_id1_1_0_rdata;
  wire [8-1:0] ram_w8_l2048_id1_1_0_wdata;
  wire ram_w8_l2048_id1_1_0_wenable;
  wire ram_w8_l2048_id1_1_0_enable;
  wire [9-1:0] ram_w8_l2048_id1_1_1_addr;
  wire [8-1:0] ram_w8_l2048_id1_1_1_rdata;
  wire [8-1:0] ram_w8_l2048_id1_1_1_wdata;
  wire ram_w8_l2048_id1_1_1_wenable;
  wire ram_w8_l2048_id1_1_1_enable;
  assign ram_w8_l2048_id1_1_0_wdata = 'hx;
  assign ram_w8_l2048_id1_1_0_wenable = 0;

  ram_w8_l2048_id1_1
  inst_ram_w8_l2048_id1_1
  (
    .CLK(CLK),
    .ram_w8_l2048_id1_1_0_addr(ram_w8_l2048_id1_1_0_addr),
    .ram_w8_l2048_id1_1_0_rdata(ram_w8_l2048_id1_1_0_rdata),
    .ram_w8_l2048_id1_1_0_wdata(ram_w8_l2048_id1_1_0_wdata),
    .ram_w8_l2048_id1_1_0_wenable(ram_w8_l2048_id1_1_0_wenable),
    .ram_w8_l2048_id1_1_0_enable(ram_w8_l2048_id1_1_0_enable),
    .ram_w8_l2048_id1_1_1_addr(ram_w8_l2048_id1_1_1_addr),
    .ram_w8_l2048_id1_1_1_rdata(ram_w8_l2048_id1_1_1_rdata),
    .ram_w8_l2048_id1_1_1_wdata(ram_w8_l2048_id1_1_1_wdata),
    .ram_w8_l2048_id1_1_1_wenable(ram_w8_l2048_id1_1_1_wenable),
    .ram_w8_l2048_id1_1_1_enable(ram_w8_l2048_id1_1_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id1_2_0_addr;
  wire [8-1:0] ram_w8_l2048_id1_2_0_rdata;
  wire [8-1:0] ram_w8_l2048_id1_2_0_wdata;
  wire ram_w8_l2048_id1_2_0_wenable;
  wire ram_w8_l2048_id1_2_0_enable;
  wire [9-1:0] ram_w8_l2048_id1_2_1_addr;
  wire [8-1:0] ram_w8_l2048_id1_2_1_rdata;
  wire [8-1:0] ram_w8_l2048_id1_2_1_wdata;
  wire ram_w8_l2048_id1_2_1_wenable;
  wire ram_w8_l2048_id1_2_1_enable;
  assign ram_w8_l2048_id1_2_0_wdata = 'hx;
  assign ram_w8_l2048_id1_2_0_wenable = 0;

  ram_w8_l2048_id1_2
  inst_ram_w8_l2048_id1_2
  (
    .CLK(CLK),
    .ram_w8_l2048_id1_2_0_addr(ram_w8_l2048_id1_2_0_addr),
    .ram_w8_l2048_id1_2_0_rdata(ram_w8_l2048_id1_2_0_rdata),
    .ram_w8_l2048_id1_2_0_wdata(ram_w8_l2048_id1_2_0_wdata),
    .ram_w8_l2048_id1_2_0_wenable(ram_w8_l2048_id1_2_0_wenable),
    .ram_w8_l2048_id1_2_0_enable(ram_w8_l2048_id1_2_0_enable),
    .ram_w8_l2048_id1_2_1_addr(ram_w8_l2048_id1_2_1_addr),
    .ram_w8_l2048_id1_2_1_rdata(ram_w8_l2048_id1_2_1_rdata),
    .ram_w8_l2048_id1_2_1_wdata(ram_w8_l2048_id1_2_1_wdata),
    .ram_w8_l2048_id1_2_1_wenable(ram_w8_l2048_id1_2_1_wenable),
    .ram_w8_l2048_id1_2_1_enable(ram_w8_l2048_id1_2_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id1_3_0_addr;
  wire [8-1:0] ram_w8_l2048_id1_3_0_rdata;
  wire [8-1:0] ram_w8_l2048_id1_3_0_wdata;
  wire ram_w8_l2048_id1_3_0_wenable;
  wire ram_w8_l2048_id1_3_0_enable;
  wire [9-1:0] ram_w8_l2048_id1_3_1_addr;
  wire [8-1:0] ram_w8_l2048_id1_3_1_rdata;
  wire [8-1:0] ram_w8_l2048_id1_3_1_wdata;
  wire ram_w8_l2048_id1_3_1_wenable;
  wire ram_w8_l2048_id1_3_1_enable;
  assign ram_w8_l2048_id1_3_0_wdata = 'hx;
  assign ram_w8_l2048_id1_3_0_wenable = 0;

  ram_w8_l2048_id1_3
  inst_ram_w8_l2048_id1_3
  (
    .CLK(CLK),
    .ram_w8_l2048_id1_3_0_addr(ram_w8_l2048_id1_3_0_addr),
    .ram_w8_l2048_id1_3_0_rdata(ram_w8_l2048_id1_3_0_rdata),
    .ram_w8_l2048_id1_3_0_wdata(ram_w8_l2048_id1_3_0_wdata),
    .ram_w8_l2048_id1_3_0_wenable(ram_w8_l2048_id1_3_0_wenable),
    .ram_w8_l2048_id1_3_0_enable(ram_w8_l2048_id1_3_0_enable),
    .ram_w8_l2048_id1_3_1_addr(ram_w8_l2048_id1_3_1_addr),
    .ram_w8_l2048_id1_3_1_rdata(ram_w8_l2048_id1_3_1_rdata),
    .ram_w8_l2048_id1_3_1_wdata(ram_w8_l2048_id1_3_1_wdata),
    .ram_w8_l2048_id1_3_1_wenable(ram_w8_l2048_id1_3_1_wenable),
    .ram_w8_l2048_id1_3_1_enable(ram_w8_l2048_id1_3_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id2_0_0_addr;
  wire [8-1:0] ram_w8_l2048_id2_0_0_rdata;
  wire [8-1:0] ram_w8_l2048_id2_0_0_wdata;
  wire ram_w8_l2048_id2_0_0_wenable;
  wire ram_w8_l2048_id2_0_0_enable;
  wire [9-1:0] ram_w8_l2048_id2_0_1_addr;
  wire [8-1:0] ram_w8_l2048_id2_0_1_rdata;
  wire [8-1:0] ram_w8_l2048_id2_0_1_wdata;
  wire ram_w8_l2048_id2_0_1_wenable;
  wire ram_w8_l2048_id2_0_1_enable;
  assign ram_w8_l2048_id2_0_1_wdata = 'hx;
  assign ram_w8_l2048_id2_0_1_wenable = 0;

  ram_w8_l2048_id2_0
  inst_ram_w8_l2048_id2_0
  (
    .CLK(CLK),
    .ram_w8_l2048_id2_0_0_addr(ram_w8_l2048_id2_0_0_addr),
    .ram_w8_l2048_id2_0_0_rdata(ram_w8_l2048_id2_0_0_rdata),
    .ram_w8_l2048_id2_0_0_wdata(ram_w8_l2048_id2_0_0_wdata),
    .ram_w8_l2048_id2_0_0_wenable(ram_w8_l2048_id2_0_0_wenable),
    .ram_w8_l2048_id2_0_0_enable(ram_w8_l2048_id2_0_0_enable),
    .ram_w8_l2048_id2_0_1_addr(ram_w8_l2048_id2_0_1_addr),
    .ram_w8_l2048_id2_0_1_rdata(ram_w8_l2048_id2_0_1_rdata),
    .ram_w8_l2048_id2_0_1_wdata(ram_w8_l2048_id2_0_1_wdata),
    .ram_w8_l2048_id2_0_1_wenable(ram_w8_l2048_id2_0_1_wenable),
    .ram_w8_l2048_id2_0_1_enable(ram_w8_l2048_id2_0_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id2_1_0_addr;
  wire [8-1:0] ram_w8_l2048_id2_1_0_rdata;
  wire [8-1:0] ram_w8_l2048_id2_1_0_wdata;
  wire ram_w8_l2048_id2_1_0_wenable;
  wire ram_w8_l2048_id2_1_0_enable;
  wire [9-1:0] ram_w8_l2048_id2_1_1_addr;
  wire [8-1:0] ram_w8_l2048_id2_1_1_rdata;
  wire [8-1:0] ram_w8_l2048_id2_1_1_wdata;
  wire ram_w8_l2048_id2_1_1_wenable;
  wire ram_w8_l2048_id2_1_1_enable;
  assign ram_w8_l2048_id2_1_1_wdata = 'hx;
  assign ram_w8_l2048_id2_1_1_wenable = 0;

  ram_w8_l2048_id2_1
  inst_ram_w8_l2048_id2_1
  (
    .CLK(CLK),
    .ram_w8_l2048_id2_1_0_addr(ram_w8_l2048_id2_1_0_addr),
    .ram_w8_l2048_id2_1_0_rdata(ram_w8_l2048_id2_1_0_rdata),
    .ram_w8_l2048_id2_1_0_wdata(ram_w8_l2048_id2_1_0_wdata),
    .ram_w8_l2048_id2_1_0_wenable(ram_w8_l2048_id2_1_0_wenable),
    .ram_w8_l2048_id2_1_0_enable(ram_w8_l2048_id2_1_0_enable),
    .ram_w8_l2048_id2_1_1_addr(ram_w8_l2048_id2_1_1_addr),
    .ram_w8_l2048_id2_1_1_rdata(ram_w8_l2048_id2_1_1_rdata),
    .ram_w8_l2048_id2_1_1_wdata(ram_w8_l2048_id2_1_1_wdata),
    .ram_w8_l2048_id2_1_1_wenable(ram_w8_l2048_id2_1_1_wenable),
    .ram_w8_l2048_id2_1_1_enable(ram_w8_l2048_id2_1_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id2_2_0_addr;
  wire [8-1:0] ram_w8_l2048_id2_2_0_rdata;
  wire [8-1:0] ram_w8_l2048_id2_2_0_wdata;
  wire ram_w8_l2048_id2_2_0_wenable;
  wire ram_w8_l2048_id2_2_0_enable;
  wire [9-1:0] ram_w8_l2048_id2_2_1_addr;
  wire [8-1:0] ram_w8_l2048_id2_2_1_rdata;
  wire [8-1:0] ram_w8_l2048_id2_2_1_wdata;
  wire ram_w8_l2048_id2_2_1_wenable;
  wire ram_w8_l2048_id2_2_1_enable;
  assign ram_w8_l2048_id2_2_1_wdata = 'hx;
  assign ram_w8_l2048_id2_2_1_wenable = 0;

  ram_w8_l2048_id2_2
  inst_ram_w8_l2048_id2_2
  (
    .CLK(CLK),
    .ram_w8_l2048_id2_2_0_addr(ram_w8_l2048_id2_2_0_addr),
    .ram_w8_l2048_id2_2_0_rdata(ram_w8_l2048_id2_2_0_rdata),
    .ram_w8_l2048_id2_2_0_wdata(ram_w8_l2048_id2_2_0_wdata),
    .ram_w8_l2048_id2_2_0_wenable(ram_w8_l2048_id2_2_0_wenable),
    .ram_w8_l2048_id2_2_0_enable(ram_w8_l2048_id2_2_0_enable),
    .ram_w8_l2048_id2_2_1_addr(ram_w8_l2048_id2_2_1_addr),
    .ram_w8_l2048_id2_2_1_rdata(ram_w8_l2048_id2_2_1_rdata),
    .ram_w8_l2048_id2_2_1_wdata(ram_w8_l2048_id2_2_1_wdata),
    .ram_w8_l2048_id2_2_1_wenable(ram_w8_l2048_id2_2_1_wenable),
    .ram_w8_l2048_id2_2_1_enable(ram_w8_l2048_id2_2_1_enable)
  );

  wire [9-1:0] ram_w8_l2048_id2_3_0_addr;
  wire [8-1:0] ram_w8_l2048_id2_3_0_rdata;
  wire [8-1:0] ram_w8_l2048_id2_3_0_wdata;
  wire ram_w8_l2048_id2_3_0_wenable;
  wire ram_w8_l2048_id2_3_0_enable;
  wire [9-1:0] ram_w8_l2048_id2_3_1_addr;
  wire [8-1:0] ram_w8_l2048_id2_3_1_rdata;
  wire [8-1:0] ram_w8_l2048_id2_3_1_wdata;
  wire ram_w8_l2048_id2_3_1_wenable;
  wire ram_w8_l2048_id2_3_1_enable;
  assign ram_w8_l2048_id2_3_1_wdata = 'hx;
  assign ram_w8_l2048_id2_3_1_wenable = 0;

  ram_w8_l2048_id2_3
  inst_ram_w8_l2048_id2_3
  (
    .CLK(CLK),
    .ram_w8_l2048_id2_3_0_addr(ram_w8_l2048_id2_3_0_addr),
    .ram_w8_l2048_id2_3_0_rdata(ram_w8_l2048_id2_3_0_rdata),
    .ram_w8_l2048_id2_3_0_wdata(ram_w8_l2048_id2_3_0_wdata),
    .ram_w8_l2048_id2_3_0_wenable(ram_w8_l2048_id2_3_0_wenable),
    .ram_w8_l2048_id2_3_0_enable(ram_w8_l2048_id2_3_0_enable),
    .ram_w8_l2048_id2_3_1_addr(ram_w8_l2048_id2_3_1_addr),
    .ram_w8_l2048_id2_3_1_rdata(ram_w8_l2048_id2_3_1_rdata),
    .ram_w8_l2048_id2_3_1_wdata(ram_w8_l2048_id2_3_1_wdata),
    .ram_w8_l2048_id2_3_1_wenable(ram_w8_l2048_id2_3_1_wenable),
    .ram_w8_l2048_id2_3_1_enable(ram_w8_l2048_id2_3_1_enable)
  );

  wire [3-1:0] cparam_add_2_dma_size;
  wire [1-1:0] cparam_add_2_num_comp;
  wire [3-1:0] cparam_add_2_addr_inc;
  wire [1-1:0] cparam_add_2_arg_addr_incs_0;
  wire [1-1:0] cparam_add_2_arg_addr_incs_1;
  wire [1-1:0] cparam_add_2_arg_trip_sizes_0;
  wire [1-1:0] cparam_add_2_arg_trip_sizes_1;
  wire [1-1:0] cparam_add_2_arg_repeat_sizes_0;
  wire [1-1:0] cparam_add_2_arg_repeat_sizes_1;
  wire [1-1:0] cparam_add_2_arg_omit_dmas_0;
  wire [1-1:0] cparam_add_2_arg_omit_dmas_1;
  wire [1-1:0] cparam_add_2_arg_stride_zeros_0;
  wire [1-1:0] cparam_add_2_arg_stride_zeros_1;
  assign cparam_add_2_dma_size = 4;
  assign cparam_add_2_num_comp = 1;
  assign cparam_add_2_addr_inc = 4;
  assign cparam_add_2_arg_addr_incs_0 = 0;
  assign cparam_add_2_arg_addr_incs_1 = 0;
  assign cparam_add_2_arg_trip_sizes_0 = 1;
  assign cparam_add_2_arg_trip_sizes_1 = 1;
  assign cparam_add_2_arg_repeat_sizes_0 = 1;
  assign cparam_add_2_arg_repeat_sizes_1 = 1;
  assign cparam_add_2_arg_omit_dmas_0 = 1;
  assign cparam_add_2_arg_omit_dmas_1 = 1;
  assign cparam_add_2_arg_stride_zeros_0 = 1;
  assign cparam_add_2_arg_stride_zeros_1 = 1;
  reg _stream_add_2_stream_ivalid;
  wire _stream_add_2_stream_oready;
  wire _stream_add_2_stream_internal_oready;
  assign _stream_add_2_stream_internal_oready = 1;
  assign _stream_add_2_stream_oready = _stream_add_2_stream_internal_oready;
  reg [32-1:0] _stream_add_2_fsm;
  localparam _stream_add_2_fsm_init = 0;
  wire _stream_add_2_run_flag;
  reg _stream_add_2_source_start;
  wire _stream_add_2_source_stop;
  reg _stream_add_2_source_busy;
  wire _stream_add_2_sink_start;
  wire _stream_add_2_sink_stop;
  wire _stream_add_2_sink_busy;
  wire _stream_add_2_busy;
  reg _stream_add_2_busy_reg;
  wire _stream_add_2_is_root;
  assign _stream_add_2_is_root = 1;
  reg [1-1:0] _stream_add_2_parameter_0_next_parameter_data;
  reg _stream_add_2_source_1_idle;
  reg [33-1:0] _stream_add_2_source_1_source_count;
  reg [5-1:0] _stream_add_2_source_1_source_mode;
  reg [16-1:0] _stream_add_2_source_1_source_generator_id;
  reg [32-1:0] _stream_add_2_source_1_source_offset;
  reg [33-1:0] _stream_add_2_source_1_source_size;
  reg [32-1:0] _stream_add_2_source_1_source_stride;
  reg [32-1:0] _stream_add_2_source_1_source_offset_buf;
  reg [33-1:0] _stream_add_2_source_1_source_size_buf;
  reg [32-1:0] _stream_add_2_source_1_source_stride_buf;
  reg [8-1:0] _stream_add_2_source_1_source_sel;
  reg [32-1:0] _stream_add_2_source_1_source_ram_raddr;
  reg _stream_add_2_source_1_source_ram_renable;
  wire [8-1:0] _stream_add_2_source_1_source_ram_rdata;
  reg _stream_add_2_source_1_source_fifo_deq;
  wire [8-1:0] _stream_add_2_source_1_source_fifo_rdata;
  reg [8-1:0] _stream_add_2_source_1_source_empty_data;
  reg [1-1:0] _stream_add_2_parameter_2_next_parameter_data;
  reg _stream_add_2_source_3_idle;
  reg [33-1:0] _stream_add_2_source_3_source_count;
  reg [5-1:0] _stream_add_2_source_3_source_mode;
  reg [16-1:0] _stream_add_2_source_3_source_generator_id;
  reg [32-1:0] _stream_add_2_source_3_source_offset;
  reg [33-1:0] _stream_add_2_source_3_source_size;
  reg [32-1:0] _stream_add_2_source_3_source_stride;
  reg [32-1:0] _stream_add_2_source_3_source_offset_buf;
  reg [33-1:0] _stream_add_2_source_3_source_size_buf;
  reg [32-1:0] _stream_add_2_source_3_source_stride_buf;
  reg [8-1:0] _stream_add_2_source_3_source_sel;
  reg [32-1:0] _stream_add_2_source_3_source_ram_raddr;
  reg _stream_add_2_source_3_source_ram_renable;
  wire [8-1:0] _stream_add_2_source_3_source_ram_rdata;
  reg _stream_add_2_source_3_source_fifo_deq;
  wire [8-1:0] _stream_add_2_source_3_source_fifo_rdata;
  reg [8-1:0] _stream_add_2_source_3_source_empty_data;
  reg [33-1:0] _stream_add_2_sink_4_sink_count;
  reg [5-1:0] _stream_add_2_sink_4_sink_mode;
  reg [16-1:0] _stream_add_2_sink_4_sink_generator_id;
  reg [32-1:0] _stream_add_2_sink_4_sink_offset;
  reg [33-1:0] _stream_add_2_sink_4_sink_size;
  reg [32-1:0] _stream_add_2_sink_4_sink_stride;
  reg [32-1:0] _stream_add_2_sink_4_sink_offset_buf;
  reg [33-1:0] _stream_add_2_sink_4_sink_size_buf;
  reg [32-1:0] _stream_add_2_sink_4_sink_stride_buf;
  reg [8-1:0] _stream_add_2_sink_4_sink_sel;
  reg [32-1:0] _stream_add_2_sink_4_sink_waddr;
  reg _stream_add_2_sink_4_sink_wenable;
  reg [8-1:0] _stream_add_2_sink_4_sink_wdata;
  reg _stream_add_2_sink_4_sink_fifo_enq;
  reg [8-1:0] _stream_add_2_sink_4_sink_fifo_wdata;
  reg [8-1:0] _stream_add_2_sink_4_sink_immediate;
  reg [32-1:0] main_fsm;
  localparam main_fsm_init = 0;
  reg [32-1:0] internal_state_counter;
  reg [32-1:0] add_2_objaddr;
  reg [32-1:0] add_2_arg_objaddr_0;
  reg [32-1:0] add_2_arg_objaddr_1;
  reg [32-1:0] control_add_2;
  localparam control_add_2_init = 0;
  reg _control_add_2_called;
  reg [32-1:0] add_2_out_gaddr;
  reg [33-1:0] add_2_comp_count;
  reg [32-1:0] add_2_arg_gaddr_offset_0_0;
  reg [32-1:0] add_2_arg_gaddr_offset_1_0;
  wire [32-1:0] add_2_arg_gaddr_0;
  wire [32-1:0] add_2_arg_gaddr_1;
  assign add_2_arg_gaddr_0 = add_2_arg_gaddr_offset_0_0;
  assign add_2_arg_gaddr_1 = add_2_arg_gaddr_offset_1_0;
  reg [33-1:0] add_2_arg_trip_count_0_0;
  reg [33-1:0] add_2_arg_trip_count_1_0;
  reg [33-1:0] add_2_arg_repeat_count_0_0;
  reg [33-1:0] add_2_arg_repeat_count_1_0;
  reg add_2_out_page;
  reg [32-1:0] add_2_out_page_comp_offset;
  reg [32-1:0] add_2_out_page_dma_offset;
  reg add_2_arg_page_0;
  reg add_2_arg_page_1;
  reg [32-1:0] add_2_arg_page_comp_offset_0;
  reg [32-1:0] add_2_arg_page_comp_offset_1;
  reg [32-1:0] add_2_arg_page_dma_offset_0;
  reg [32-1:0] add_2_arg_page_dma_offset_1;
  reg add_2_skip_read;
  reg add_2_skip_comp;
  reg add_2_skip_write;
  wire [3-1:0] _dma_read_packed_high_local_size_25;
  assign _dma_read_packed_high_local_size_25 = cparam_add_2_dma_size >> 2;
  wire [2-1:0] _dma_read_packed_low_local_size_26;
  assign _dma_read_packed_low_local_size_26 = cparam_add_2_dma_size & { 2{ 1'd1 } };
  wire [3-1:0] _dma_read_packed_local_packed_size_27;
  assign _dma_read_packed_local_packed_size_27 = (_dma_read_packed_low_local_size_26 > 0)? _dma_read_packed_high_local_size_25 + 1 : _dma_read_packed_high_local_size_25;
  wire [32-1:0] mask_addr_shifted_28;
  assign mask_addr_shifted_28 = add_2_arg_objaddr_0 + add_2_arg_gaddr_0 + _maxi_global_base_addr >> 2;
  wire [32-1:0] mask_addr_masked_29;
  assign mask_addr_masked_29 = mask_addr_shifted_28 << 2;
  reg [32-1:0] _maxi_read_req_fsm;
  localparam _maxi_read_req_fsm_init = 0;
  reg [33-1:0] _maxi_read_cur_global_size;
  reg _maxi_read_cont;
  wire [8-1:0] pack_read_req_op_sel_30;
  wire [32-1:0] pack_read_req_local_addr_31;
  wire [32-1:0] pack_read_req_local_stride_32;
  wire [33-1:0] pack_read_req_local_size_33;
  wire [32-1:0] pack_read_req_local_blocksize_34;
  assign pack_read_req_op_sel_30 = _maxi_read_op_sel;
  assign pack_read_req_local_addr_31 = _maxi_read_local_addr;
  assign pack_read_req_local_stride_32 = _maxi_read_local_stride;
  assign pack_read_req_local_size_33 = _maxi_read_local_size;
  assign pack_read_req_local_blocksize_34 = _maxi_read_local_blocksize;
  wire [137-1:0] pack_read_req_packed_35;
  assign pack_read_req_packed_35 = { pack_read_req_op_sel_30, pack_read_req_local_addr_31, pack_read_req_local_stride_32, pack_read_req_local_size_33, pack_read_req_local_blocksize_34 };
  assign _maxi_read_req_fifo_wdata = ((_maxi_read_req_fsm == 0) && _maxi_read_start && !_maxi_read_req_fifo_almost_full)? pack_read_req_packed_35 : 'hx;
  assign _maxi_read_req_fifo_enq = ((_maxi_read_req_fsm == 0) && _maxi_read_start && !_maxi_read_req_fifo_almost_full)? (_maxi_read_req_fsm == 0) && _maxi_read_start && !_maxi_read_req_fifo_almost_full && !_maxi_read_req_fifo_almost_full : 0;
  localparam _tmp_36 = 1;
  wire [_tmp_36-1:0] _tmp_37;
  assign _tmp_37 = !_maxi_read_req_fifo_almost_full;
  reg [_tmp_36-1:0] __tmp_37_1;
  wire [32-1:0] mask_addr_shifted_38;
  assign mask_addr_shifted_38 = _maxi_read_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_39;
  assign mask_addr_masked_39 = mask_addr_shifted_38 << 2;
  wire [32-1:0] mask_addr_shifted_40;
  assign mask_addr_shifted_40 = _maxi_read_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_41;
  assign mask_addr_masked_41 = mask_addr_shifted_40 << 2;
  wire [32-1:0] mask_addr_shifted_42;
  assign mask_addr_shifted_42 = _maxi_read_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_43;
  assign mask_addr_masked_43 = mask_addr_shifted_42 << 2;
  wire [32-1:0] mask_addr_shifted_44;
  assign mask_addr_shifted_44 = _maxi_read_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_45;
  assign mask_addr_masked_45 = mask_addr_shifted_44 << 2;
  wire [32-1:0] mask_addr_shifted_46;
  assign mask_addr_shifted_46 = _maxi_read_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_47;
  assign mask_addr_masked_47 = mask_addr_shifted_46 << 2;
  wire [32-1:0] mask_addr_shifted_48;
  assign mask_addr_shifted_48 = _maxi_read_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_49;
  assign mask_addr_masked_49 = mask_addr_shifted_48 << 2;
  reg _maxi_cond_0_1;
  reg [32-1:0] _maxi_read_data_fsm;
  localparam _maxi_read_data_fsm_init = 0;
  reg [32-1:0] write_burst_packed_fsm_0;
  localparam write_burst_packed_fsm_0_init = 0;
  reg [11-1:0] write_burst_packed_addr_50;
  reg [11-1:0] write_burst_packed_stride_51;
  reg [33-1:0] write_burst_packed_length_52;
  reg write_burst_packed_done_53;
  wire [9-1:0] write_burst_packed_ram_addr_54;
  assign write_burst_packed_ram_addr_54 = write_burst_packed_addr_50 >> 2;
  wire [8-1:0] write_burst_packed_ram_wdata_55;
  assign write_burst_packed_ram_wdata_55 = maxi_rdata >> 0;
  assign ram_w8_l2048_id0_0_1_addr = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? write_burst_packed_ram_addr_54 : 'hx;
  assign ram_w8_l2048_id0_0_1_wdata = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? write_burst_packed_ram_wdata_55 : 'hx;
  assign ram_w8_l2048_id0_0_1_wenable = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? 1'd1 : 0;
  assign ram_w8_l2048_id0_0_1_enable = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? 1'd1 : 0;
  wire [9-1:0] write_burst_packed_ram_addr_56;
  assign write_burst_packed_ram_addr_56 = write_burst_packed_addr_50 >> 2;
  wire [8-1:0] write_burst_packed_ram_wdata_57;
  assign write_burst_packed_ram_wdata_57 = maxi_rdata >> 8;
  assign ram_w8_l2048_id0_1_1_addr = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? write_burst_packed_ram_addr_56 : 'hx;
  assign ram_w8_l2048_id0_1_1_wdata = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? write_burst_packed_ram_wdata_57 : 'hx;
  assign ram_w8_l2048_id0_1_1_wenable = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? 1'd1 : 0;
  assign ram_w8_l2048_id0_1_1_enable = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? 1'd1 : 0;
  wire [9-1:0] write_burst_packed_ram_addr_58;
  assign write_burst_packed_ram_addr_58 = write_burst_packed_addr_50 >> 2;
  wire [8-1:0] write_burst_packed_ram_wdata_59;
  assign write_burst_packed_ram_wdata_59 = maxi_rdata >> 16;
  assign ram_w8_l2048_id0_2_1_addr = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? write_burst_packed_ram_addr_58 : 'hx;
  assign ram_w8_l2048_id0_2_1_wdata = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? write_burst_packed_ram_wdata_59 : 'hx;
  assign ram_w8_l2048_id0_2_1_wenable = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? 1'd1 : 0;
  assign ram_w8_l2048_id0_2_1_enable = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? 1'd1 : 0;
  wire [9-1:0] write_burst_packed_ram_addr_60;
  assign write_burst_packed_ram_addr_60 = write_burst_packed_addr_50 >> 2;
  wire [8-1:0] write_burst_packed_ram_wdata_61;
  assign write_burst_packed_ram_wdata_61 = maxi_rdata >> 24;
  assign ram_w8_l2048_id0_3_1_addr = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? write_burst_packed_ram_addr_60 : 'hx;
  assign ram_w8_l2048_id0_3_1_wdata = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? write_burst_packed_ram_wdata_61 : 'hx;
  assign ram_w8_l2048_id0_3_1_wenable = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? 1'd1 : 0;
  assign ram_w8_l2048_id0_3_1_enable = ((write_burst_packed_fsm_0 == 1) && maxi_rvalid)? 1'd1 : 0;
  wire [2-1:0] _dma_read_packed_high_local_size_62;
  assign _dma_read_packed_high_local_size_62 = 0;
  wire [2-1:0] _dma_read_packed_low_local_size_63;
  assign _dma_read_packed_low_local_size_63 = 1 & { 2{ 1'd1 } };
  wire [2-1:0] _dma_read_packed_local_packed_size_64;
  assign _dma_read_packed_local_packed_size_64 = (_dma_read_packed_low_local_size_63 > 0)? _dma_read_packed_high_local_size_62 + 1 : _dma_read_packed_high_local_size_62;
  wire [32-1:0] mask_addr_shifted_65;
  assign mask_addr_shifted_65 = add_2_arg_objaddr_0 + add_2_arg_gaddr_0 + _maxi_global_base_addr >> 2;
  wire [32-1:0] mask_addr_masked_66;
  assign mask_addr_masked_66 = mask_addr_shifted_65 << 2;
  wire [3-1:0] _dma_read_packed_high_local_size_67;
  assign _dma_read_packed_high_local_size_67 = cparam_add_2_dma_size >> 2;
  wire [2-1:0] _dma_read_packed_low_local_size_68;
  assign _dma_read_packed_low_local_size_68 = cparam_add_2_dma_size & { 2{ 1'd1 } };
  wire [3-1:0] _dma_read_packed_local_packed_size_69;
  assign _dma_read_packed_local_packed_size_69 = (_dma_read_packed_low_local_size_68 > 0)? _dma_read_packed_high_local_size_67 + 1 : _dma_read_packed_high_local_size_67;
  wire [32-1:0] mask_addr_shifted_70;
  assign mask_addr_shifted_70 = add_2_arg_objaddr_1 + add_2_arg_gaddr_1 + _maxi_global_base_addr >> 2;
  wire [32-1:0] mask_addr_masked_71;
  assign mask_addr_masked_71 = mask_addr_shifted_70 << 2;
  assign _maxi_read_req_fifo_deq = ((_maxi_read_data_fsm == 0) && (_maxi_read_data_idle && !_maxi_read_req_fifo_empty && (_maxi_read_op_sel_fifo == 2)) && !_maxi_read_req_fifo_empty)? 1 : 
                                   ((_maxi_read_data_fsm == 0) && (_maxi_read_data_idle && !_maxi_read_req_fifo_empty && (_maxi_read_op_sel_fifo == 1)) && !_maxi_read_req_fifo_empty)? 1 : 0;
  reg [32-1:0] write_burst_packed_fsm_1;
  localparam write_burst_packed_fsm_1_init = 0;
  reg [11-1:0] write_burst_packed_addr_72;
  reg [11-1:0] write_burst_packed_stride_73;
  reg [33-1:0] write_burst_packed_length_74;
  reg write_burst_packed_done_75;
  wire [9-1:0] write_burst_packed_ram_addr_76;
  assign write_burst_packed_ram_addr_76 = write_burst_packed_addr_72 >> 2;
  wire [8-1:0] write_burst_packed_ram_wdata_77;
  assign write_burst_packed_ram_wdata_77 = maxi_rdata >> 0;
  assign ram_w8_l2048_id1_0_1_addr = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? write_burst_packed_ram_addr_76 : 'hx;
  assign ram_w8_l2048_id1_0_1_wdata = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? write_burst_packed_ram_wdata_77 : 'hx;
  assign ram_w8_l2048_id1_0_1_wenable = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? 1'd1 : 0;
  assign ram_w8_l2048_id1_0_1_enable = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? 1'd1 : 0;
  wire [9-1:0] write_burst_packed_ram_addr_78;
  assign write_burst_packed_ram_addr_78 = write_burst_packed_addr_72 >> 2;
  wire [8-1:0] write_burst_packed_ram_wdata_79;
  assign write_burst_packed_ram_wdata_79 = maxi_rdata >> 8;
  assign ram_w8_l2048_id1_1_1_addr = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? write_burst_packed_ram_addr_78 : 'hx;
  assign ram_w8_l2048_id1_1_1_wdata = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? write_burst_packed_ram_wdata_79 : 'hx;
  assign ram_w8_l2048_id1_1_1_wenable = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? 1'd1 : 0;
  assign ram_w8_l2048_id1_1_1_enable = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? 1'd1 : 0;
  wire [9-1:0] write_burst_packed_ram_addr_80;
  assign write_burst_packed_ram_addr_80 = write_burst_packed_addr_72 >> 2;
  wire [8-1:0] write_burst_packed_ram_wdata_81;
  assign write_burst_packed_ram_wdata_81 = maxi_rdata >> 16;
  assign ram_w8_l2048_id1_2_1_addr = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? write_burst_packed_ram_addr_80 : 'hx;
  assign ram_w8_l2048_id1_2_1_wdata = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? write_burst_packed_ram_wdata_81 : 'hx;
  assign ram_w8_l2048_id1_2_1_wenable = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? 1'd1 : 0;
  assign ram_w8_l2048_id1_2_1_enable = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? 1'd1 : 0;
  wire [9-1:0] write_burst_packed_ram_addr_82;
  assign write_burst_packed_ram_addr_82 = write_burst_packed_addr_72 >> 2;
  wire [8-1:0] write_burst_packed_ram_wdata_83;
  assign write_burst_packed_ram_wdata_83 = maxi_rdata >> 24;
  assign ram_w8_l2048_id1_3_1_addr = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? write_burst_packed_ram_addr_82 : 'hx;
  assign ram_w8_l2048_id1_3_1_wdata = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? write_burst_packed_ram_wdata_83 : 'hx;
  assign ram_w8_l2048_id1_3_1_wenable = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? 1'd1 : 0;
  assign ram_w8_l2048_id1_3_1_enable = ((write_burst_packed_fsm_1 == 1) && maxi_rvalid)? 1'd1 : 0;
  assign maxi_rready = (_maxi_read_data_fsm == 2) || (_maxi_read_data_fsm == 2);
  wire [2-1:0] _dma_read_packed_high_local_size_84;
  assign _dma_read_packed_high_local_size_84 = 0;
  wire [2-1:0] _dma_read_packed_low_local_size_85;
  assign _dma_read_packed_low_local_size_85 = 1 & { 2{ 1'd1 } };
  wire [2-1:0] _dma_read_packed_local_packed_size_86;
  assign _dma_read_packed_local_packed_size_86 = (_dma_read_packed_low_local_size_85 > 0)? _dma_read_packed_high_local_size_84 + 1 : _dma_read_packed_high_local_size_84;
  wire [32-1:0] mask_addr_shifted_87;
  assign mask_addr_shifted_87 = add_2_arg_objaddr_1 + add_2_arg_gaddr_1 + _maxi_global_base_addr >> 2;
  wire [32-1:0] mask_addr_masked_88;
  assign mask_addr_masked_88 = mask_addr_shifted_87 << 2;
  wire [1-1:0] stream_add_2_parameter_0_data;
  wire [8-1:0] stream_add_2_source_1_data;
  wire [1-1:0] stream_add_2_parameter_2_data;
  wire [8-1:0] stream_add_2_source_3_data;
  reg __stream_add_2_stream_ivalid_1;
  wire [8-1:0] _reinterpretcast_src_2;
  assign _reinterpretcast_src_2 = stream_add_2_source_1_data;
  wire signed [8-1:0] _reinterpretcast_data_2;
  assign _reinterpretcast_data_2 = _reinterpretcast_src_2;
  wire [8-1:0] _reinterpretcast_src_5;
  assign _reinterpretcast_src_5 = stream_add_2_source_3_data;
  wire signed [8-1:0] _reinterpretcast_data_5;
  assign _reinterpretcast_data_5 = _reinterpretcast_src_5;
  reg signed [8-1:0] _plus_data_6;
  wire signed [8-1:0] _reinterpretcast_src_7;
  assign _reinterpretcast_src_7 = _plus_data_6;
  wire signed [8-1:0] _reinterpretcast_data_7;
  assign _reinterpretcast_data_7 = _reinterpretcast_src_7;
  wire signed [8-1:0] stream_add_2_sink_4_data;
  assign stream_add_2_sink_4_data = _reinterpretcast_data_7;
  wire _set_flag_89;
  assign _set_flag_89 = control_add_2 == 21;
  reg [1-1:0] __variable_wdata_0;
  assign stream_add_2_parameter_0_data = __variable_wdata_0;
  wire _set_flag_90;
  assign _set_flag_90 = control_add_2 == 21;
  wire [2-1:0] read_rtl_bank_91;
  assign read_rtl_bank_91 = _stream_add_2_source_1_source_ram_raddr;
  reg [2-1:0] _tmp_92;
  assign ram_w8_l2048_id0_0_0_addr = (_stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1))? _stream_add_2_source_1_source_ram_raddr >> 2 : 'hx;
  assign ram_w8_l2048_id0_0_0_enable = (_stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1))? 1'd1 : 0;
  localparam _tmp_93 = 1;
  wire [_tmp_93-1:0] _tmp_94;
  assign _tmp_94 = _stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1);
  reg [_tmp_93-1:0] __tmp_94_1;
  assign ram_w8_l2048_id0_1_0_addr = (_stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1))? _stream_add_2_source_1_source_ram_raddr >> 2 : 'hx;
  assign ram_w8_l2048_id0_1_0_enable = (_stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1))? 1'd1 : 0;
  localparam _tmp_95 = 1;
  wire [_tmp_95-1:0] _tmp_96;
  assign _tmp_96 = _stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1);
  reg [_tmp_95-1:0] __tmp_96_1;
  assign ram_w8_l2048_id0_2_0_addr = (_stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1))? _stream_add_2_source_1_source_ram_raddr >> 2 : 'hx;
  assign ram_w8_l2048_id0_2_0_enable = (_stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1))? 1'd1 : 0;
  localparam _tmp_97 = 1;
  wire [_tmp_97-1:0] _tmp_98;
  assign _tmp_98 = _stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1);
  reg [_tmp_97-1:0] __tmp_98_1;
  assign ram_w8_l2048_id0_3_0_addr = (_stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1))? _stream_add_2_source_1_source_ram_raddr >> 2 : 'hx;
  assign ram_w8_l2048_id0_3_0_enable = (_stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1))? 1'd1 : 0;
  localparam _tmp_99 = 1;
  wire [_tmp_99-1:0] _tmp_100;
  assign _tmp_100 = _stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1);
  reg [_tmp_99-1:0] __tmp_100_1;
  wire signed [8-1:0] read_rtl_rdata_101;
  wire read_rtl_rvalid_102;
  assign read_rtl_rdata_101 = (_tmp_92 == 0)? ram_w8_l2048_id0_0_0_rdata : 
                              (_tmp_92 == 1)? ram_w8_l2048_id0_1_0_rdata : 
                              (_tmp_92 == 2)? ram_w8_l2048_id0_2_0_rdata : 
                              (_tmp_92 == 3)? ram_w8_l2048_id0_3_0_rdata : 0;
  assign read_rtl_rvalid_102 = __tmp_94_1;
  assign _stream_add_2_source_1_source_ram_rdata = (_stream_add_2_source_1_source_sel == 1)? read_rtl_rdata_101 : 'hx;
  reg [8-1:0] __variable_wdata_1;
  assign stream_add_2_source_1_data = __variable_wdata_1;
  reg [32-1:0] _stream_add_2_source_1_source_fsm_0;
  localparam _stream_add_2_source_1_source_fsm_0_init = 0;
  wire _set_flag_103;
  assign _set_flag_103 = control_add_2 == 21;
  reg [1-1:0] __variable_wdata_3;
  assign stream_add_2_parameter_2_data = __variable_wdata_3;
  wire _set_flag_104;
  assign _set_flag_104 = control_add_2 == 21;
  wire [2-1:0] read_rtl_bank_105;
  assign read_rtl_bank_105 = _stream_add_2_source_3_source_ram_raddr;
  reg [2-1:0] _tmp_106;
  assign ram_w8_l2048_id1_0_0_addr = (_stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2))? _stream_add_2_source_3_source_ram_raddr >> 2 : 'hx;
  assign ram_w8_l2048_id1_0_0_enable = (_stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2))? 1'd1 : 0;
  localparam _tmp_107 = 1;
  wire [_tmp_107-1:0] _tmp_108;
  assign _tmp_108 = _stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2);
  reg [_tmp_107-1:0] __tmp_108_1;
  assign ram_w8_l2048_id1_1_0_addr = (_stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2))? _stream_add_2_source_3_source_ram_raddr >> 2 : 'hx;
  assign ram_w8_l2048_id1_1_0_enable = (_stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2))? 1'd1 : 0;
  localparam _tmp_109 = 1;
  wire [_tmp_109-1:0] _tmp_110;
  assign _tmp_110 = _stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2);
  reg [_tmp_109-1:0] __tmp_110_1;
  assign ram_w8_l2048_id1_2_0_addr = (_stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2))? _stream_add_2_source_3_source_ram_raddr >> 2 : 'hx;
  assign ram_w8_l2048_id1_2_0_enable = (_stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2))? 1'd1 : 0;
  localparam _tmp_111 = 1;
  wire [_tmp_111-1:0] _tmp_112;
  assign _tmp_112 = _stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2);
  reg [_tmp_111-1:0] __tmp_112_1;
  assign ram_w8_l2048_id1_3_0_addr = (_stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2))? _stream_add_2_source_3_source_ram_raddr >> 2 : 'hx;
  assign ram_w8_l2048_id1_3_0_enable = (_stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2))? 1'd1 : 0;
  localparam _tmp_113 = 1;
  wire [_tmp_113-1:0] _tmp_114;
  assign _tmp_114 = _stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2);
  reg [_tmp_113-1:0] __tmp_114_1;
  wire signed [8-1:0] read_rtl_rdata_115;
  wire read_rtl_rvalid_116;
  assign read_rtl_rdata_115 = (_tmp_106 == 0)? ram_w8_l2048_id1_0_0_rdata : 
                              (_tmp_106 == 1)? ram_w8_l2048_id1_1_0_rdata : 
                              (_tmp_106 == 2)? ram_w8_l2048_id1_2_0_rdata : 
                              (_tmp_106 == 3)? ram_w8_l2048_id1_3_0_rdata : 0;
  assign read_rtl_rvalid_116 = __tmp_108_1;
  assign _stream_add_2_source_3_source_ram_rdata = (_stream_add_2_source_3_source_sel == 2)? read_rtl_rdata_115 : 'hx;
  reg [8-1:0] __variable_wdata_4;
  assign stream_add_2_source_3_data = __variable_wdata_4;
  reg [32-1:0] _stream_add_2_source_3_source_fsm_1;
  localparam _stream_add_2_source_3_source_fsm_1_init = 0;
  wire _set_flag_117;
  assign _set_flag_117 = control_add_2 == 21;
  reg _tmp_118;
  reg _tmp_119;
  reg _tmp_120;
  reg [32-1:0] _tmp_121;
  reg [32-1:0] _tmp_122;
  reg [32-1:0] _tmp_123;
  reg [3-1:0] _tmp_124;
  reg [3-1:0] _tmp_125;
  reg [3-1:0] _tmp_126;
  wire [2-1:0] write_rtl_bank_127;
  assign write_rtl_bank_127 = _stream_add_2_sink_4_sink_waddr;
  assign ram_w8_l2048_id2_0_0_addr = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 0))? _stream_add_2_sink_4_sink_waddr >> 2 : 'hx;
  assign ram_w8_l2048_id2_0_0_wdata = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 0))? _stream_add_2_sink_4_sink_wdata : 'hx;
  assign ram_w8_l2048_id2_0_0_wenable = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 0))? 1'd1 : 0;
  assign ram_w8_l2048_id2_0_0_enable = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 0))? 1'd1 : 0;
  assign ram_w8_l2048_id2_1_0_addr = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 1))? _stream_add_2_sink_4_sink_waddr >> 2 : 'hx;
  assign ram_w8_l2048_id2_1_0_wdata = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 1))? _stream_add_2_sink_4_sink_wdata : 'hx;
  assign ram_w8_l2048_id2_1_0_wenable = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 1))? 1'd1 : 0;
  assign ram_w8_l2048_id2_1_0_enable = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 1))? 1'd1 : 0;
  assign ram_w8_l2048_id2_2_0_addr = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 2))? _stream_add_2_sink_4_sink_waddr >> 2 : 'hx;
  assign ram_w8_l2048_id2_2_0_wdata = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 2))? _stream_add_2_sink_4_sink_wdata : 'hx;
  assign ram_w8_l2048_id2_2_0_wenable = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 2))? 1'd1 : 0;
  assign ram_w8_l2048_id2_2_0_enable = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 2))? 1'd1 : 0;
  assign ram_w8_l2048_id2_3_0_addr = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 3))? _stream_add_2_sink_4_sink_waddr >> 2 : 'hx;
  assign ram_w8_l2048_id2_3_0_wdata = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 3))? _stream_add_2_sink_4_sink_wdata : 'hx;
  assign ram_w8_l2048_id2_3_0_wenable = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 3))? 1'd1 : 0;
  assign ram_w8_l2048_id2_3_0_enable = (_stream_add_2_stream_oready && _stream_add_2_sink_4_sink_wenable && (_stream_add_2_sink_4_sink_sel == 3) && (write_rtl_bank_127 == 3))? 1'd1 : 0;
  reg [32-1:0] _stream_add_2_sink_4_sink_fsm_2;
  localparam _stream_add_2_sink_4_sink_fsm_2_init = 0;
  wire _set_flag_128;
  assign _set_flag_128 = control_add_2 == 23;
  assign _stream_add_2_run_flag = (_set_flag_128)? 1 : 0;
  reg _tmp_129;
  reg _tmp_130;
  reg _tmp_131;
  assign _stream_add_2_source_stop = _stream_add_2_stream_oready && (_stream_add_2_source_1_idle && _stream_add_2_source_3_idle && (_stream_add_2_fsm == 3));
  localparam _tmp_132 = 1;
  wire [_tmp_132-1:0] _tmp_133;
  assign _tmp_133 = _stream_add_2_source_1_idle && _stream_add_2_source_3_idle && (_stream_add_2_fsm == 3);
  reg [_tmp_132-1:0] _tmp_134;
  reg _tmp_135;
  reg _tmp_136;
  reg _tmp_137;
  assign _stream_add_2_sink_start = _tmp_137;
  reg _tmp_138;
  reg _tmp_139;
  reg _tmp_140;
  assign _stream_add_2_sink_stop = _tmp_140;
  reg _tmp_141;
  reg _tmp_142;
  reg _tmp_143;
  assign _stream_add_2_sink_busy = _tmp_143;
  reg _tmp_144;
  assign _stream_add_2_busy = _stream_add_2_source_busy || _stream_add_2_sink_busy || _stream_add_2_busy_reg;
  wire [3-1:0] _dma_write_packed_high_local_size_145;
  assign _dma_write_packed_high_local_size_145 = cparam_add_2_dma_size >> 2;
  wire [2-1:0] _dma_write_packed_low_local_size_146;
  assign _dma_write_packed_low_local_size_146 = cparam_add_2_dma_size & { 2{ 1'd1 } };
  wire [3-1:0] _dma_write_packed_local_packed_size_147;
  assign _dma_write_packed_local_packed_size_147 = (_dma_write_packed_low_local_size_146 > 0)? _dma_write_packed_high_local_size_145 + 1 : _dma_write_packed_high_local_size_145;
  wire [32-1:0] mask_addr_shifted_148;
  assign mask_addr_shifted_148 = add_2_objaddr + add_2_out_gaddr + _maxi_global_base_addr >> 2;
  wire [32-1:0] mask_addr_masked_149;
  assign mask_addr_masked_149 = mask_addr_shifted_148 << 2;
  reg [32-1:0] _maxi_write_req_fsm;
  localparam _maxi_write_req_fsm_init = 0;
  reg [33-1:0] _maxi_write_cur_global_size;
  reg _maxi_write_cont;
  wire [8-1:0] pack_write_req_op_sel_150;
  wire [32-1:0] pack_write_req_local_addr_151;
  wire [32-1:0] pack_write_req_local_stride_152;
  wire [33-1:0] pack_write_req_size_153;
  wire [32-1:0] pack_write_req_local_blocksize_154;
  assign pack_write_req_op_sel_150 = _maxi_write_op_sel;
  assign pack_write_req_local_addr_151 = _maxi_write_local_addr;
  assign pack_write_req_local_stride_152 = _maxi_write_local_stride;
  assign pack_write_req_size_153 = _maxi_write_local_size;
  assign pack_write_req_local_blocksize_154 = _maxi_write_local_blocksize;
  wire [137-1:0] pack_write_req_packed_155;
  assign pack_write_req_packed_155 = { pack_write_req_op_sel_150, pack_write_req_local_addr_151, pack_write_req_local_stride_152, pack_write_req_size_153, pack_write_req_local_blocksize_154 };
  localparam _tmp_156 = 1;
  wire [_tmp_156-1:0] _tmp_157;
  assign _tmp_157 = !_maxi_write_req_fifo_almost_full;
  reg [_tmp_156-1:0] __tmp_157_1;
  wire [32-1:0] mask_addr_shifted_158;
  assign mask_addr_shifted_158 = _maxi_write_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_159;
  assign mask_addr_masked_159 = mask_addr_shifted_158 << 2;
  wire [32-1:0] mask_addr_shifted_160;
  assign mask_addr_shifted_160 = _maxi_write_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_161;
  assign mask_addr_masked_161 = mask_addr_shifted_160 << 2;
  wire [32-1:0] mask_addr_shifted_162;
  assign mask_addr_shifted_162 = _maxi_write_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_163;
  assign mask_addr_masked_163 = mask_addr_shifted_162 << 2;
  wire [32-1:0] mask_addr_shifted_164;
  assign mask_addr_shifted_164 = _maxi_write_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_165;
  assign mask_addr_masked_165 = mask_addr_shifted_164 << 2;
  wire [32-1:0] mask_addr_shifted_166;
  assign mask_addr_shifted_166 = _maxi_write_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_167;
  assign mask_addr_masked_167 = mask_addr_shifted_166 << 2;
  wire [32-1:0] mask_addr_shifted_168;
  assign mask_addr_shifted_168 = _maxi_write_global_addr >> 2;
  wire [32-1:0] mask_addr_masked_169;
  assign mask_addr_masked_169 = mask_addr_shifted_168 << 2;
  wire [8-1:0] pack_write_req_op_sel_170;
  wire [32-1:0] pack_write_req_local_addr_171;
  wire [32-1:0] pack_write_req_local_stride_172;
  wire [33-1:0] pack_write_req_size_173;
  wire [32-1:0] pack_write_req_local_blocksize_174;
  assign pack_write_req_op_sel_170 = _maxi_write_op_sel;
  assign pack_write_req_local_addr_171 = _maxi_write_local_addr;
  assign pack_write_req_local_stride_172 = _maxi_write_local_stride;
  assign pack_write_req_size_173 = _maxi_write_cur_global_size;
  assign pack_write_req_local_blocksize_174 = _maxi_write_local_blocksize;
  wire [137-1:0] pack_write_req_packed_175;
  assign pack_write_req_packed_175 = { pack_write_req_op_sel_170, pack_write_req_local_addr_171, pack_write_req_local_stride_172, pack_write_req_size_173, pack_write_req_local_blocksize_174 };
  assign _maxi_write_req_fifo_wdata = ((_maxi_write_req_fsm == 1) && !_maxi_write_req_fifo_almost_full && (maxi_awready || !maxi_awvalid) && (outstanding_wcount_0 < 6))? pack_write_req_packed_175 : 
                                      ((_maxi_write_req_fsm == 0) && _maxi_write_start && !_maxi_write_req_fifo_almost_full)? pack_write_req_packed_155 : 'hx;
  assign _maxi_write_req_fifo_enq = ((_maxi_write_req_fsm == 1) && !_maxi_write_req_fifo_almost_full && (maxi_awready || !maxi_awvalid) && (outstanding_wcount_0 < 6))? (_maxi_write_req_fsm == 1) && !_maxi_write_req_fifo_almost_full && (maxi_awready || !maxi_awvalid) && (outstanding_wcount_0 < 6) && !_maxi_write_req_fifo_almost_full : 
                                    ((_maxi_write_req_fsm == 0) && _maxi_write_start && !_maxi_write_req_fifo_almost_full)? (_maxi_write_req_fsm == 0) && _maxi_write_start && !_maxi_write_req_fifo_almost_full && !_maxi_write_req_fifo_almost_full : 0;
  localparam _tmp_176 = 1;
  wire [_tmp_176-1:0] _tmp_177;
  assign _tmp_177 = !_maxi_write_req_fifo_almost_full;
  reg [_tmp_176-1:0] __tmp_177_1;
  reg _maxi_cond_1_1;
  reg [32-1:0] _maxi_write_data_fsm;
  localparam _maxi_write_data_fsm_init = 0;
  reg [32-1:0] read_burst_packed_fsm_2;
  localparam read_burst_packed_fsm_2_init = 0;
  reg [11-1:0] read_burst_packed_addr_178;
  reg [11-1:0] read_burst_packed_stride_179;
  reg [33-1:0] read_burst_packed_length_180;
  reg read_burst_packed_rvalid_181;
  reg read_burst_packed_rlast_182;
  wire [9-1:0] read_burst_packed_ram_addr_183;
  assign read_burst_packed_ram_addr_183 = read_burst_packed_addr_178 >> 2;
  assign ram_w8_l2048_id2_0_1_addr = ((read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0)))? read_burst_packed_ram_addr_183 : 'hx;
  assign ram_w8_l2048_id2_0_1_enable = ((read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0)))? 1'd1 : 0;
  localparam _tmp_184 = 1;
  wire [_tmp_184-1:0] _tmp_185;
  assign _tmp_185 = (read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0));
  reg [_tmp_184-1:0] __tmp_185_1;
  wire [8-1:0] read_burst_packed_ram_rdata_186;
  assign read_burst_packed_ram_rdata_186 = ram_w8_l2048_id2_0_1_rdata;
  wire [9-1:0] read_burst_packed_ram_addr_187;
  assign read_burst_packed_ram_addr_187 = read_burst_packed_addr_178 >> 2;
  assign ram_w8_l2048_id2_1_1_addr = ((read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0)))? read_burst_packed_ram_addr_187 : 'hx;
  assign ram_w8_l2048_id2_1_1_enable = ((read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0)))? 1'd1 : 0;
  localparam _tmp_188 = 1;
  wire [_tmp_188-1:0] _tmp_189;
  assign _tmp_189 = (read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0));
  reg [_tmp_188-1:0] __tmp_189_1;
  wire [8-1:0] read_burst_packed_ram_rdata_190;
  assign read_burst_packed_ram_rdata_190 = ram_w8_l2048_id2_1_1_rdata;
  wire [9-1:0] read_burst_packed_ram_addr_191;
  assign read_burst_packed_ram_addr_191 = read_burst_packed_addr_178 >> 2;
  assign ram_w8_l2048_id2_2_1_addr = ((read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0)))? read_burst_packed_ram_addr_191 : 'hx;
  assign ram_w8_l2048_id2_2_1_enable = ((read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0)))? 1'd1 : 0;
  localparam _tmp_192 = 1;
  wire [_tmp_192-1:0] _tmp_193;
  assign _tmp_193 = (read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0));
  reg [_tmp_192-1:0] __tmp_193_1;
  wire [8-1:0] read_burst_packed_ram_rdata_194;
  assign read_burst_packed_ram_rdata_194 = ram_w8_l2048_id2_2_1_rdata;
  wire [9-1:0] read_burst_packed_ram_addr_195;
  assign read_burst_packed_ram_addr_195 = read_burst_packed_addr_178 >> 2;
  assign ram_w8_l2048_id2_3_1_addr = ((read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0)))? read_burst_packed_ram_addr_195 : 'hx;
  assign ram_w8_l2048_id2_3_1_enable = ((read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0)))? 1'd1 : 0;
  localparam _tmp_196 = 1;
  wire [_tmp_196-1:0] _tmp_197;
  assign _tmp_197 = (read_burst_packed_fsm_2 == 1) && (!read_burst_packed_rvalid_181 || (maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0));
  reg [_tmp_196-1:0] __tmp_197_1;
  wire [8-1:0] read_burst_packed_ram_rdata_198;
  assign read_burst_packed_ram_rdata_198 = ram_w8_l2048_id2_3_1_rdata;
  wire [32-1:0] read_burst_packed_rdata_199;
  assign read_burst_packed_rdata_199 = { read_burst_packed_ram_rdata_198, read_burst_packed_ram_rdata_194, read_burst_packed_ram_rdata_190, read_burst_packed_ram_rdata_186 };
  assign _maxi_write_req_fifo_deq = ((_maxi_write_data_fsm == 2) && (!_maxi_write_req_fifo_empty && (_maxi_write_size_buf == 0)) && !_maxi_write_req_fifo_empty)? 1 : 
                                    ((_maxi_write_data_fsm == 0) && (_maxi_write_data_idle && !_maxi_write_req_fifo_empty && (_maxi_write_op_sel_fifo == 1)) && !_maxi_write_req_fifo_empty)? 1 : 0;
  reg _maxi_cond_2_1;

  always @(posedge CLK) begin
    _RESETN_inv_1 <= RESETN_inv;
    _RESETN_inv_2 <= _RESETN_inv_1;
  end


  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      outstanding_wcount_0 <= 0;
      _maxi_read_start <= 0;
      _maxi_write_start <= 0;
      _maxi_global_base_addr <= 0;
      _maxi_read_op_sel <= 0;
      _maxi_read_global_addr <= 0;
      _maxi_read_global_size <= 0;
      _maxi_read_local_addr <= 0;
      _maxi_read_local_stride <= 0;
      _maxi_read_local_size <= 0;
      _maxi_read_local_blocksize <= 0;
      _maxi_read_req_idle <= 1;
      _maxi_read_cur_global_size <= 0;
      maxi_araddr <= 0;
      maxi_arlen <= 0;
      maxi_arvalid <= 0;
      _maxi_cond_0_1 <= 0;
      _maxi_read_data_idle <= 1;
      _maxi_read_op_sel_buf <= 0;
      _maxi_read_local_addr_buf <= 0;
      _maxi_read_local_stride_buf <= 0;
      _maxi_read_local_size_buf <= 0;
      _maxi_read_local_blocksize_buf <= 0;
      _maxi_write_op_sel <= 0;
      _maxi_write_global_addr <= 0;
      _maxi_write_global_size <= 0;
      _maxi_write_local_addr <= 0;
      _maxi_write_local_stride <= 0;
      _maxi_write_local_size <= 0;
      _maxi_write_local_blocksize <= 0;
      _maxi_write_req_idle <= 1;
      _maxi_write_cur_global_size <= 0;
      maxi_awaddr <= 0;
      maxi_awlen <= 0;
      maxi_awvalid <= 0;
      _maxi_cond_1_1 <= 0;
      _maxi_write_data_idle <= 1;
      _maxi_write_op_sel_buf <= 0;
      _maxi_write_local_addr_buf <= 0;
      _maxi_write_local_stride_buf <= 0;
      _maxi_write_size_buf <= 0;
      _maxi_write_local_blocksize_buf <= 0;
      maxi_wdata <= 0;
      maxi_wvalid <= 0;
      maxi_wlast <= 0;
      maxi_wstrb <= 0;
      _maxi_cond_2_1 <= 0;
    end else begin
      if(_maxi_cond_0_1) begin
        maxi_arvalid <= 0;
      end 
      if(_maxi_cond_1_1) begin
        maxi_awvalid <= 0;
      end 
      if(_maxi_cond_2_1) begin
        maxi_wvalid <= 0;
        maxi_wlast <= 0;
      end 
      if(maxi_awvalid && maxi_awready && !(maxi_bvalid && maxi_bready) && (outstanding_wcount_0 < 7)) begin
        outstanding_wcount_0 <= outstanding_wcount_0 + 1;
      end 
      if(!(maxi_awvalid && maxi_awready) && (maxi_bvalid && maxi_bready) && (outstanding_wcount_0 > 0)) begin
        outstanding_wcount_0 <= outstanding_wcount_0 - 1;
      end 
      _maxi_read_start <= 0;
      _maxi_write_start <= 0;
      _maxi_global_base_addr <= _saxi_register_32;
      if((control_add_2 == 5) && _maxi_read_req_idle) begin
        _maxi_read_start <= 1;
        _maxi_read_op_sel <= 1;
        _maxi_read_global_addr <= mask_addr_masked_29;
        _maxi_read_global_size <= _dma_read_packed_local_packed_size_27;
        _maxi_read_local_addr <= add_2_arg_page_dma_offset_0;
        _maxi_read_local_stride <= 4;
        _maxi_read_local_size <= _dma_read_packed_local_packed_size_27;
        _maxi_read_local_blocksize <= 1;
      end 
      if((_maxi_read_req_fsm == 0) && _maxi_read_start) begin
        _maxi_read_req_idle <= 0;
      end 
      if(_maxi_read_start && _maxi_read_req_fifo_almost_full) begin
        _maxi_read_start <= 1;
      end 
      if((_maxi_read_req_fsm == 0) && (_maxi_read_start || _maxi_read_cont) && !_maxi_read_req_fifo_almost_full && (_maxi_read_global_size <= 256) && ((mask_addr_masked_39 & 4095) + (_maxi_read_global_size << 2) >= 4096)) begin
        _maxi_read_cur_global_size <= 4096 - (mask_addr_masked_41 & 4095) >> 2;
        _maxi_read_global_size <= _maxi_read_global_size - (4096 - (mask_addr_masked_43 & 4095) >> 2);
      end else if((_maxi_read_req_fsm == 0) && (_maxi_read_start || _maxi_read_cont) && !_maxi_read_req_fifo_almost_full && (_maxi_read_global_size <= 256)) begin
        _maxi_read_cur_global_size <= _maxi_read_global_size;
        _maxi_read_global_size <= 0;
      end else if((_maxi_read_req_fsm == 0) && (_maxi_read_start || _maxi_read_cont) && !_maxi_read_req_fifo_almost_full && ((mask_addr_masked_45 & 4095) + 1024 >= 4096)) begin
        _maxi_read_cur_global_size <= 4096 - (mask_addr_masked_47 & 4095) >> 2;
        _maxi_read_global_size <= _maxi_read_global_size - (4096 - (mask_addr_masked_49 & 4095) >> 2);
      end else if((_maxi_read_req_fsm == 0) && (_maxi_read_start || _maxi_read_cont) && !_maxi_read_req_fifo_almost_full) begin
        _maxi_read_cur_global_size <= 256;
        _maxi_read_global_size <= _maxi_read_global_size - 256;
      end 
      if((_maxi_read_req_fsm == 1) && (maxi_arready || !maxi_arvalid)) begin
        maxi_araddr <= _maxi_read_global_addr;
        maxi_arlen <= _maxi_read_cur_global_size - 1;
        maxi_arvalid <= 1;
      end 
      _maxi_cond_0_1 <= 1;
      if(maxi_arvalid && !maxi_arready) begin
        maxi_arvalid <= maxi_arvalid;
      end 
      if((_maxi_read_req_fsm == 1) && (maxi_arready || !maxi_arvalid)) begin
        _maxi_read_global_addr <= _maxi_read_global_addr + (_maxi_read_cur_global_size << 2);
      end 
      if((_maxi_read_req_fsm == 1) && (maxi_arready || !maxi_arvalid) && (_maxi_read_global_size == 0)) begin
        _maxi_read_req_idle <= 1;
      end 
      if((_maxi_read_data_fsm == 0) && (_maxi_read_data_idle && !_maxi_read_req_fifo_empty && (_maxi_read_op_sel_fifo == 1))) begin
        _maxi_read_data_idle <= 0;
        _maxi_read_op_sel_buf <= _maxi_read_op_sel_fifo;
        _maxi_read_local_addr_buf <= _maxi_read_local_addr_fifo;
        _maxi_read_local_stride_buf <= _maxi_read_local_stride_fifo;
        _maxi_read_local_size_buf <= _maxi_read_local_size_fifo;
        _maxi_read_local_blocksize_buf <= _maxi_read_local_blocksize_fifo;
      end 
      if((_maxi_read_data_fsm == 2) && maxi_rvalid) begin
        _maxi_read_local_size_buf <= _maxi_read_local_size_buf - 1;
      end 
      if((_maxi_read_data_fsm == 2) && maxi_rvalid && (_maxi_read_local_size_buf <= 1)) begin
        _maxi_read_data_idle <= 1;
      end 
      if((control_add_2 == 9) && _maxi_read_req_idle) begin
        _maxi_read_start <= 1;
        _maxi_read_op_sel <= 1;
        _maxi_read_global_addr <= mask_addr_masked_66;
        _maxi_read_global_size <= _dma_read_packed_local_packed_size_64;
        _maxi_read_local_addr <= add_2_arg_page_dma_offset_0;
        _maxi_read_local_stride <= 4;
        _maxi_read_local_size <= _dma_read_packed_local_packed_size_64;
        _maxi_read_local_blocksize <= 1;
      end 
      if((control_add_2 == 13) && _maxi_read_req_idle) begin
        _maxi_read_start <= 1;
        _maxi_read_op_sel <= 2;
        _maxi_read_global_addr <= mask_addr_masked_71;
        _maxi_read_global_size <= _dma_read_packed_local_packed_size_69;
        _maxi_read_local_addr <= add_2_arg_page_dma_offset_1;
        _maxi_read_local_stride <= 4;
        _maxi_read_local_size <= _dma_read_packed_local_packed_size_69;
        _maxi_read_local_blocksize <= 1;
      end 
      if((_maxi_read_data_fsm == 0) && (_maxi_read_data_idle && !_maxi_read_req_fifo_empty && (_maxi_read_op_sel_fifo == 2))) begin
        _maxi_read_data_idle <= 0;
        _maxi_read_op_sel_buf <= _maxi_read_op_sel_fifo;
        _maxi_read_local_addr_buf <= _maxi_read_local_addr_fifo;
        _maxi_read_local_stride_buf <= _maxi_read_local_stride_fifo;
        _maxi_read_local_size_buf <= _maxi_read_local_size_fifo;
        _maxi_read_local_blocksize_buf <= _maxi_read_local_blocksize_fifo;
      end 
      if((_maxi_read_data_fsm == 2) && maxi_rvalid) begin
        _maxi_read_local_size_buf <= _maxi_read_local_size_buf - 1;
      end 
      if((_maxi_read_data_fsm == 2) && maxi_rvalid && (_maxi_read_local_size_buf <= 1)) begin
        _maxi_read_data_idle <= 1;
      end 
      if((control_add_2 == 17) && _maxi_read_req_idle) begin
        _maxi_read_start <= 1;
        _maxi_read_op_sel <= 2;
        _maxi_read_global_addr <= mask_addr_masked_88;
        _maxi_read_global_size <= _dma_read_packed_local_packed_size_86;
        _maxi_read_local_addr <= add_2_arg_page_dma_offset_1;
        _maxi_read_local_stride <= 4;
        _maxi_read_local_size <= _dma_read_packed_local_packed_size_86;
        _maxi_read_local_blocksize <= 1;
      end 
      if((control_add_2 == 27) && _maxi_write_req_idle) begin
        _maxi_write_start <= 1;
        _maxi_write_op_sel <= 1;
        _maxi_write_global_addr <= mask_addr_masked_149;
        _maxi_write_global_size <= _dma_write_packed_local_packed_size_147;
        _maxi_write_local_addr <= add_2_out_page_dma_offset;
        _maxi_write_local_stride <= 4;
        _maxi_write_local_size <= _dma_write_packed_local_packed_size_147;
        _maxi_write_local_blocksize <= 1;
      end 
      if((_maxi_write_req_fsm == 0) && _maxi_write_start) begin
        _maxi_write_req_idle <= 0;
      end 
      if(_maxi_write_start && _maxi_write_req_fifo_almost_full) begin
        _maxi_write_start <= 1;
      end 
      if((_maxi_write_req_fsm == 0) && (_maxi_write_start || _maxi_write_cont) && !_maxi_write_req_fifo_almost_full && (_maxi_write_global_size <= 256) && ((mask_addr_masked_159 & 4095) + (_maxi_write_global_size << 2) >= 4096)) begin
        _maxi_write_cur_global_size <= 4096 - (mask_addr_masked_161 & 4095) >> 2;
        _maxi_write_global_size <= _maxi_write_global_size - (4096 - (mask_addr_masked_163 & 4095) >> 2);
      end else if((_maxi_write_req_fsm == 0) && (_maxi_write_start || _maxi_write_cont) && !_maxi_write_req_fifo_almost_full && (_maxi_write_global_size <= 256)) begin
        _maxi_write_cur_global_size <= _maxi_write_global_size;
        _maxi_write_global_size <= 0;
      end else if((_maxi_write_req_fsm == 0) && (_maxi_write_start || _maxi_write_cont) && !_maxi_write_req_fifo_almost_full && ((mask_addr_masked_165 & 4095) + 1024 >= 4096)) begin
        _maxi_write_cur_global_size <= 4096 - (mask_addr_masked_167 & 4095) >> 2;
        _maxi_write_global_size <= _maxi_write_global_size - (4096 - (mask_addr_masked_169 & 4095) >> 2);
      end else if((_maxi_write_req_fsm == 0) && (_maxi_write_start || _maxi_write_cont) && !_maxi_write_req_fifo_almost_full) begin
        _maxi_write_cur_global_size <= 256;
        _maxi_write_global_size <= _maxi_write_global_size - 256;
      end 
      if((_maxi_write_req_fsm == 1) && !_maxi_write_req_fifo_almost_full && (outstanding_wcount_0 < 6) && ((outstanding_wcount_0 < 6) && (maxi_awready || !maxi_awvalid))) begin
        maxi_awaddr <= _maxi_write_global_addr;
        maxi_awlen <= _maxi_write_cur_global_size - 1;
        maxi_awvalid <= 1;
      end 
      if((_maxi_write_req_fsm == 1) && !_maxi_write_req_fifo_almost_full && (outstanding_wcount_0 < 6) && ((outstanding_wcount_0 < 6) && (maxi_awready || !maxi_awvalid)) && (_maxi_write_cur_global_size == 0)) begin
        maxi_awvalid <= 0;
      end 
      _maxi_cond_1_1 <= 1;
      if(maxi_awvalid && !maxi_awready) begin
        maxi_awvalid <= maxi_awvalid;
      end 
      if((_maxi_write_req_fsm == 1) && ((_maxi_write_req_fsm == 1) && !_maxi_write_req_fifo_almost_full && (maxi_awready || !maxi_awvalid) && (outstanding_wcount_0 < 6))) begin
        _maxi_write_global_addr <= _maxi_write_global_addr + (_maxi_write_cur_global_size << 2);
      end 
      if((_maxi_write_req_fsm == 1) && ((_maxi_write_req_fsm == 1) && !_maxi_write_req_fifo_almost_full && (maxi_awready || !maxi_awvalid) && (outstanding_wcount_0 < 6)) && (_maxi_write_global_size == 0)) begin
        _maxi_write_req_idle <= 1;
      end 
      if((_maxi_write_data_fsm == 0) && (_maxi_write_data_idle && !_maxi_write_req_fifo_empty && (_maxi_write_op_sel_fifo == 1))) begin
        _maxi_write_data_idle <= 0;
        _maxi_write_op_sel_buf <= _maxi_write_op_sel_fifo;
        _maxi_write_local_addr_buf <= _maxi_write_local_addr_fifo;
        _maxi_write_local_stride_buf <= _maxi_write_local_stride_fifo;
        _maxi_write_size_buf <= _maxi_write_size_fifo;
        _maxi_write_local_blocksize_buf <= _maxi_write_local_blocksize_fifo;
      end 
      if(_maxi_write_data_fsm == 1) begin
        _maxi_write_size_buf <= 0;
      end 
      if((_maxi_write_data_fsm == 2) && (!_maxi_write_req_fifo_empty && (_maxi_write_size_buf == 0))) begin
        _maxi_write_size_buf <= _maxi_write_size_fifo;
      end 
      if((_maxi_write_op_sel_buf == 1) && read_burst_packed_rvalid_181 && ((maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0)) && (maxi_wready || !maxi_wvalid)) begin
        maxi_wdata <= read_burst_packed_rdata_199;
        maxi_wvalid <= 1;
        maxi_wlast <= read_burst_packed_rlast_182 || (_maxi_write_size_buf == 1);
        maxi_wstrb <= { 4{ 1'd1 } };
      end 
      _maxi_cond_2_1 <= 1;
      if(maxi_wvalid && !maxi_wready) begin
        maxi_wvalid <= maxi_wvalid;
        maxi_wlast <= maxi_wlast;
      end 
      if((_maxi_write_data_fsm == 2) && read_burst_packed_rvalid_181 && ((maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0))) begin
        _maxi_write_size_buf <= _maxi_write_size_buf - 1;
      end 
      if((_maxi_write_data_fsm == 2) && ((_maxi_write_op_sel_buf == 1) && read_burst_packed_rvalid_181 && ((maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0))) && read_burst_packed_rlast_182) begin
        _maxi_write_data_idle <= 1;
      end 
    end
  end


  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      count__maxi_read_req_fifo <= 0;
      __tmp_37_1 <= 0;
    end else begin
      if(_maxi_read_req_fifo_enq && !_maxi_read_req_fifo_full && (_maxi_read_req_fifo_deq && !_maxi_read_req_fifo_empty)) begin
        count__maxi_read_req_fifo <= count__maxi_read_req_fifo;
      end else if(_maxi_read_req_fifo_enq && !_maxi_read_req_fifo_full) begin
        count__maxi_read_req_fifo <= count__maxi_read_req_fifo + 1;
      end else if(_maxi_read_req_fifo_deq && !_maxi_read_req_fifo_empty) begin
        count__maxi_read_req_fifo <= count__maxi_read_req_fifo - 1;
      end 
      __tmp_37_1 <= _tmp_37;
    end
  end


  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      count__maxi_write_req_fifo <= 0;
      __tmp_157_1 <= 0;
      __tmp_177_1 <= 0;
    end else begin
      if(_maxi_write_req_fifo_enq && !_maxi_write_req_fifo_full && (_maxi_write_req_fifo_deq && !_maxi_write_req_fifo_empty)) begin
        count__maxi_write_req_fifo <= count__maxi_write_req_fifo;
      end else if(_maxi_write_req_fifo_enq && !_maxi_write_req_fifo_full) begin
        count__maxi_write_req_fifo <= count__maxi_write_req_fifo + 1;
      end else if(_maxi_write_req_fifo_deq && !_maxi_write_req_fifo_empty) begin
        count__maxi_write_req_fifo <= count__maxi_write_req_fifo - 1;
      end 
      __tmp_157_1 <= _tmp_157;
      __tmp_177_1 <= _tmp_177;
    end
  end


  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      saxi_bvalid <= 0;
      prev_awvalid_14 <= 0;
      prev_arvalid_15 <= 0;
      writevalid_12 <= 0;
      readvalid_13 <= 0;
      addr_11 <= 0;
      saxi_rdata <= 0;
      saxi_rvalid <= 0;
      _saxi_cond_0_1 <= 0;
      _saxi_register_0 <= 0;
      _saxi_flag_0 <= 0;
      _saxi_register_1 <= 0;
      _saxi_flag_1 <= 0;
      _saxi_register_2 <= 0;
      _saxi_flag_2 <= 0;
      _saxi_register_3 <= 0;
      _saxi_flag_3 <= 0;
      _saxi_register_4 <= 0;
      _saxi_flag_4 <= 0;
      _saxi_register_5 <= 0;
      _saxi_flag_5 <= 0;
      _saxi_register_6 <= 0;
      _saxi_flag_6 <= 0;
      _saxi_register_7 <= 0;
      _saxi_flag_7 <= 0;
      _saxi_register_8 <= 0;
      _saxi_flag_8 <= 0;
      _saxi_register_9 <= 0;
      _saxi_flag_9 <= 0;
      _saxi_register_10 <= 0;
      _saxi_flag_10 <= 0;
      _saxi_register_11 <= 0;
      _saxi_flag_11 <= 0;
      _saxi_register_12 <= 0;
      _saxi_flag_12 <= 0;
      _saxi_register_13 <= 0;
      _saxi_flag_13 <= 0;
      _saxi_register_14 <= 0;
      _saxi_flag_14 <= 0;
      _saxi_register_15 <= 0;
      _saxi_flag_15 <= 0;
      _saxi_register_16 <= 0;
      _saxi_flag_16 <= 0;
      _saxi_register_17 <= 0;
      _saxi_flag_17 <= 0;
      _saxi_register_18 <= 0;
      _saxi_flag_18 <= 0;
      _saxi_register_19 <= 0;
      _saxi_flag_19 <= 0;
      _saxi_register_20 <= 0;
      _saxi_flag_20 <= 0;
      _saxi_register_21 <= 0;
      _saxi_flag_21 <= 0;
      _saxi_register_22 <= 0;
      _saxi_flag_22 <= 0;
      _saxi_register_23 <= 0;
      _saxi_flag_23 <= 0;
      _saxi_register_24 <= 0;
      _saxi_flag_24 <= 0;
      _saxi_register_25 <= 0;
      _saxi_flag_25 <= 0;
      _saxi_register_26 <= 0;
      _saxi_flag_26 <= 0;
      _saxi_register_27 <= 0;
      _saxi_flag_27 <= 0;
      _saxi_register_28 <= 0;
      _saxi_flag_28 <= 0;
      _saxi_register_29 <= 0;
      _saxi_flag_29 <= 0;
      _saxi_register_30 <= 0;
      _saxi_flag_30 <= 0;
      _saxi_register_31 <= 192;
      _saxi_flag_31 <= 0;
      _saxi_register_32 <= 0;
      _saxi_flag_32 <= 0;
      _saxi_register_33 <= 192;
      _saxi_flag_33 <= 0;
      _saxi_register_34 <= 0;
      _saxi_flag_34 <= 0;
      _saxi_register_35 <= 64;
      _saxi_flag_35 <= 0;
      _saxi_register_36 <= 128;
      _saxi_flag_36 <= 0;
      _saxi_register_37 <= 192;
      _saxi_flag_37 <= 0;
      _saxi_register_11[0] <= (0 >> 0) & 1'd1;
      _saxi_register_9[0] <= (0 >> 0) & 1'd1;
      _saxi_register_11[1] <= (0 >> 1) & 1'd1;
      _saxi_register_9[1] <= (0 >> 1) & 1'd1;
      _saxi_register_11[2] <= (0 >> 2) & 1'd1;
      _saxi_register_9[2] <= (0 >> 2) & 1'd1;
      _saxi_register_11[3] <= (0 >> 3) & 1'd1;
      _saxi_register_9[3] <= (0 >> 3) & 1'd1;
      _saxi_register_11[4] <= (0 >> 4) & 1'd1;
      _saxi_register_9[4] <= (0 >> 4) & 1'd1;
      _saxi_register_11[5] <= (0 >> 5) & 1'd1;
      _saxi_register_9[5] <= (0 >> 5) & 1'd1;
      _saxi_register_11[6] <= (0 >> 6) & 1'd1;
      _saxi_register_9[6] <= (0 >> 6) & 1'd1;
      _saxi_register_11[7] <= (0 >> 7) & 1'd1;
      _saxi_register_9[7] <= (0 >> 7) & 1'd1;
      _saxi_register_11[8] <= (0 >> 8) & 1'd1;
      _saxi_register_9[8] <= (0 >> 8) & 1'd1;
      _saxi_register_11[9] <= (0 >> 9) & 1'd1;
      _saxi_register_9[9] <= (0 >> 9) & 1'd1;
      _saxi_register_11[10] <= (0 >> 10) & 1'd1;
      _saxi_register_9[10] <= (0 >> 10) & 1'd1;
      _saxi_register_11[11] <= (0 >> 11) & 1'd1;
      _saxi_register_9[11] <= (0 >> 11) & 1'd1;
      _saxi_register_11[12] <= (0 >> 12) & 1'd1;
      _saxi_register_9[12] <= (0 >> 12) & 1'd1;
      _saxi_register_11[13] <= (0 >> 13) & 1'd1;
      _saxi_register_9[13] <= (0 >> 13) & 1'd1;
      _saxi_register_11[14] <= (0 >> 14) & 1'd1;
      _saxi_register_9[14] <= (0 >> 14) & 1'd1;
      _saxi_register_11[15] <= (0 >> 15) & 1'd1;
      _saxi_register_9[15] <= (0 >> 15) & 1'd1;
      _saxi_register_11[16] <= (0 >> 16) & 1'd1;
      _saxi_register_9[16] <= (0 >> 16) & 1'd1;
      _saxi_register_11[17] <= (0 >> 17) & 1'd1;
      _saxi_register_9[17] <= (0 >> 17) & 1'd1;
      _saxi_register_11[18] <= (0 >> 18) & 1'd1;
      _saxi_register_9[18] <= (0 >> 18) & 1'd1;
      _saxi_register_11[19] <= (0 >> 19) & 1'd1;
      _saxi_register_9[19] <= (0 >> 19) & 1'd1;
      _saxi_register_11[20] <= (0 >> 20) & 1'd1;
      _saxi_register_9[20] <= (0 >> 20) & 1'd1;
      _saxi_register_11[21] <= (0 >> 21) & 1'd1;
      _saxi_register_9[21] <= (0 >> 21) & 1'd1;
      _saxi_register_11[22] <= (0 >> 22) & 1'd1;
      _saxi_register_9[22] <= (0 >> 22) & 1'd1;
      _saxi_register_11[23] <= (0 >> 23) & 1'd1;
      _saxi_register_9[23] <= (0 >> 23) & 1'd1;
      _saxi_register_11[24] <= (0 >> 24) & 1'd1;
      _saxi_register_9[24] <= (0 >> 24) & 1'd1;
      _saxi_register_11[25] <= (0 >> 25) & 1'd1;
      _saxi_register_9[25] <= (0 >> 25) & 1'd1;
      _saxi_register_11[26] <= (0 >> 26) & 1'd1;
      _saxi_register_9[26] <= (0 >> 26) & 1'd1;
      _saxi_register_11[27] <= (0 >> 27) & 1'd1;
      _saxi_register_9[27] <= (0 >> 27) & 1'd1;
      _saxi_register_11[28] <= (0 >> 28) & 1'd1;
      _saxi_register_9[28] <= (0 >> 28) & 1'd1;
      _saxi_register_11[29] <= (0 >> 29) & 1'd1;
      _saxi_register_9[29] <= (0 >> 29) & 1'd1;
      _saxi_register_11[30] <= (0 >> 30) & 1'd1;
      _saxi_register_9[30] <= (0 >> 30) & 1'd1;
      _saxi_register_11[31] <= (0 >> 31) & 1'd1;
      _saxi_register_9[31] <= (0 >> 31) & 1'd1;
      internal_state_counter <= 0;
    end else begin
      if(_saxi_cond_0_1) begin
        saxi_rvalid <= 0;
      end 
      if(saxi_bvalid && saxi_bready) begin
        saxi_bvalid <= 0;
      end 
      if(saxi_wvalid && saxi_wready) begin
        saxi_bvalid <= 1;
      end 
      prev_awvalid_14 <= saxi_awvalid;
      prev_arvalid_15 <= saxi_arvalid;
      writevalid_12 <= 0;
      readvalid_13 <= 0;
      if(saxi_awready && saxi_awvalid && !saxi_bvalid) begin
        addr_11 <= saxi_awaddr;
        writevalid_12 <= 1;
      end else if(saxi_arready && saxi_arvalid) begin
        addr_11 <= saxi_araddr;
        readvalid_13 <= 1;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid)) begin
        saxi_rdata <= axislite_rdata_17;
        saxi_rvalid <= 1;
      end 
      _saxi_cond_0_1 <= 1;
      if(saxi_rvalid && !saxi_rready) begin
        saxi_rvalid <= saxi_rvalid;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 0)) begin
        _saxi_register_0 <= axislite_resetval_19;
        _saxi_flag_0 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 1)) begin
        _saxi_register_1 <= axislite_resetval_19;
        _saxi_flag_1 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 2)) begin
        _saxi_register_2 <= axislite_resetval_19;
        _saxi_flag_2 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 3)) begin
        _saxi_register_3 <= axislite_resetval_19;
        _saxi_flag_3 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 4)) begin
        _saxi_register_4 <= axislite_resetval_19;
        _saxi_flag_4 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 5)) begin
        _saxi_register_5 <= axislite_resetval_19;
        _saxi_flag_5 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 6)) begin
        _saxi_register_6 <= axislite_resetval_19;
        _saxi_flag_6 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 7)) begin
        _saxi_register_7 <= axislite_resetval_19;
        _saxi_flag_7 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 8)) begin
        _saxi_register_8 <= axislite_resetval_19;
        _saxi_flag_8 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 9)) begin
        _saxi_register_9 <= axislite_resetval_19;
        _saxi_flag_9 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 10)) begin
        _saxi_register_10 <= axislite_resetval_19;
        _saxi_flag_10 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 11)) begin
        _saxi_register_11 <= axislite_resetval_19;
        _saxi_flag_11 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 12)) begin
        _saxi_register_12 <= axislite_resetval_19;
        _saxi_flag_12 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 13)) begin
        _saxi_register_13 <= axislite_resetval_19;
        _saxi_flag_13 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 14)) begin
        _saxi_register_14 <= axislite_resetval_19;
        _saxi_flag_14 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 15)) begin
        _saxi_register_15 <= axislite_resetval_19;
        _saxi_flag_15 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 16)) begin
        _saxi_register_16 <= axislite_resetval_19;
        _saxi_flag_16 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 17)) begin
        _saxi_register_17 <= axislite_resetval_19;
        _saxi_flag_17 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 18)) begin
        _saxi_register_18 <= axislite_resetval_19;
        _saxi_flag_18 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 19)) begin
        _saxi_register_19 <= axislite_resetval_19;
        _saxi_flag_19 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 20)) begin
        _saxi_register_20 <= axislite_resetval_19;
        _saxi_flag_20 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 21)) begin
        _saxi_register_21 <= axislite_resetval_19;
        _saxi_flag_21 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 22)) begin
        _saxi_register_22 <= axislite_resetval_19;
        _saxi_flag_22 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 23)) begin
        _saxi_register_23 <= axislite_resetval_19;
        _saxi_flag_23 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 24)) begin
        _saxi_register_24 <= axislite_resetval_19;
        _saxi_flag_24 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 25)) begin
        _saxi_register_25 <= axislite_resetval_19;
        _saxi_flag_25 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 26)) begin
        _saxi_register_26 <= axislite_resetval_19;
        _saxi_flag_26 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 27)) begin
        _saxi_register_27 <= axislite_resetval_19;
        _saxi_flag_27 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 28)) begin
        _saxi_register_28 <= axislite_resetval_19;
        _saxi_flag_28 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 29)) begin
        _saxi_register_29 <= axislite_resetval_19;
        _saxi_flag_29 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 30)) begin
        _saxi_register_30 <= axislite_resetval_19;
        _saxi_flag_30 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 31)) begin
        _saxi_register_31 <= axislite_resetval_19;
        _saxi_flag_31 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 32)) begin
        _saxi_register_32 <= axislite_resetval_19;
        _saxi_flag_32 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 33)) begin
        _saxi_register_33 <= axislite_resetval_19;
        _saxi_flag_33 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 34)) begin
        _saxi_register_34 <= axislite_resetval_19;
        _saxi_flag_34 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 35)) begin
        _saxi_register_35 <= axislite_resetval_19;
        _saxi_flag_35 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 36)) begin
        _saxi_register_36 <= axislite_resetval_19;
        _saxi_flag_36 <= 0;
      end 
      if((_saxi_register_fsm == 1) && (saxi_rready || !saxi_rvalid) && axislite_flag_18 && (axis_maskaddr_16 == 37)) begin
        _saxi_register_37 <= axislite_resetval_19;
        _saxi_flag_37 <= 0;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 0)) begin
        _saxi_register_0 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 1)) begin
        _saxi_register_1 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 2)) begin
        _saxi_register_2 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 3)) begin
        _saxi_register_3 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 4)) begin
        _saxi_register_4 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 5)) begin
        _saxi_register_5 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 6)) begin
        _saxi_register_6 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 7)) begin
        _saxi_register_7 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 8)) begin
        _saxi_register_8 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 9)) begin
        _saxi_register_9 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 10)) begin
        _saxi_register_10 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 11)) begin
        _saxi_register_11 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 12)) begin
        _saxi_register_12 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 13)) begin
        _saxi_register_13 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 14)) begin
        _saxi_register_14 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 15)) begin
        _saxi_register_15 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 16)) begin
        _saxi_register_16 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 17)) begin
        _saxi_register_17 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 18)) begin
        _saxi_register_18 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 19)) begin
        _saxi_register_19 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 20)) begin
        _saxi_register_20 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 21)) begin
        _saxi_register_21 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 22)) begin
        _saxi_register_22 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 23)) begin
        _saxi_register_23 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 24)) begin
        _saxi_register_24 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 25)) begin
        _saxi_register_25 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 26)) begin
        _saxi_register_26 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 27)) begin
        _saxi_register_27 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 28)) begin
        _saxi_register_28 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 29)) begin
        _saxi_register_29 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 30)) begin
        _saxi_register_30 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 31)) begin
        _saxi_register_31 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 32)) begin
        _saxi_register_32 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 33)) begin
        _saxi_register_33 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 34)) begin
        _saxi_register_34 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 35)) begin
        _saxi_register_35 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 36)) begin
        _saxi_register_36 <= saxi_wdata;
      end 
      if((_saxi_register_fsm == 2) && saxi_wvalid && (axis_maskaddr_16 == 37)) begin
        _saxi_register_37 <= saxi_wdata;
      end 
      if(_saxi_register_11[0] == 1) begin
        _saxi_register_11[0] <= 0;
        _saxi_register_9[0] <= 0;
      end 
      if(_saxi_register_11[1] == 1) begin
        _saxi_register_11[1] <= 0;
        _saxi_register_9[1] <= 0;
      end 
      if(_saxi_register_11[2] == 1) begin
        _saxi_register_11[2] <= 0;
        _saxi_register_9[2] <= 0;
      end 
      if(_saxi_register_11[3] == 1) begin
        _saxi_register_11[3] <= 0;
        _saxi_register_9[3] <= 0;
      end 
      if(_saxi_register_11[4] == 1) begin
        _saxi_register_11[4] <= 0;
        _saxi_register_9[4] <= 0;
      end 
      if(_saxi_register_11[5] == 1) begin
        _saxi_register_11[5] <= 0;
        _saxi_register_9[5] <= 0;
      end 
      if(_saxi_register_11[6] == 1) begin
        _saxi_register_11[6] <= 0;
        _saxi_register_9[6] <= 0;
      end 
      if(_saxi_register_11[7] == 1) begin
        _saxi_register_11[7] <= 0;
        _saxi_register_9[7] <= 0;
      end 
      if(_saxi_register_11[8] == 1) begin
        _saxi_register_11[8] <= 0;
        _saxi_register_9[8] <= 0;
      end 
      if(_saxi_register_11[9] == 1) begin
        _saxi_register_11[9] <= 0;
        _saxi_register_9[9] <= 0;
      end 
      if(_saxi_register_11[10] == 1) begin
        _saxi_register_11[10] <= 0;
        _saxi_register_9[10] <= 0;
      end 
      if(_saxi_register_11[11] == 1) begin
        _saxi_register_11[11] <= 0;
        _saxi_register_9[11] <= 0;
      end 
      if(_saxi_register_11[12] == 1) begin
        _saxi_register_11[12] <= 0;
        _saxi_register_9[12] <= 0;
      end 
      if(_saxi_register_11[13] == 1) begin
        _saxi_register_11[13] <= 0;
        _saxi_register_9[13] <= 0;
      end 
      if(_saxi_register_11[14] == 1) begin
        _saxi_register_11[14] <= 0;
        _saxi_register_9[14] <= 0;
      end 
      if(_saxi_register_11[15] == 1) begin
        _saxi_register_11[15] <= 0;
        _saxi_register_9[15] <= 0;
      end 
      if(_saxi_register_11[16] == 1) begin
        _saxi_register_11[16] <= 0;
        _saxi_register_9[16] <= 0;
      end 
      if(_saxi_register_11[17] == 1) begin
        _saxi_register_11[17] <= 0;
        _saxi_register_9[17] <= 0;
      end 
      if(_saxi_register_11[18] == 1) begin
        _saxi_register_11[18] <= 0;
        _saxi_register_9[18] <= 0;
      end 
      if(_saxi_register_11[19] == 1) begin
        _saxi_register_11[19] <= 0;
        _saxi_register_9[19] <= 0;
      end 
      if(_saxi_register_11[20] == 1) begin
        _saxi_register_11[20] <= 0;
        _saxi_register_9[20] <= 0;
      end 
      if(_saxi_register_11[21] == 1) begin
        _saxi_register_11[21] <= 0;
        _saxi_register_9[21] <= 0;
      end 
      if(_saxi_register_11[22] == 1) begin
        _saxi_register_11[22] <= 0;
        _saxi_register_9[22] <= 0;
      end 
      if(_saxi_register_11[23] == 1) begin
        _saxi_register_11[23] <= 0;
        _saxi_register_9[23] <= 0;
      end 
      if(_saxi_register_11[24] == 1) begin
        _saxi_register_11[24] <= 0;
        _saxi_register_9[24] <= 0;
      end 
      if(_saxi_register_11[25] == 1) begin
        _saxi_register_11[25] <= 0;
        _saxi_register_9[25] <= 0;
      end 
      if(_saxi_register_11[26] == 1) begin
        _saxi_register_11[26] <= 0;
        _saxi_register_9[26] <= 0;
      end 
      if(_saxi_register_11[27] == 1) begin
        _saxi_register_11[27] <= 0;
        _saxi_register_9[27] <= 0;
      end 
      if(_saxi_register_11[28] == 1) begin
        _saxi_register_11[28] <= 0;
        _saxi_register_9[28] <= 0;
      end 
      if(_saxi_register_11[29] == 1) begin
        _saxi_register_11[29] <= 0;
        _saxi_register_9[29] <= 0;
      end 
      if(_saxi_register_11[30] == 1) begin
        _saxi_register_11[30] <= 0;
        _saxi_register_9[30] <= 0;
      end 
      if(_saxi_register_11[31] == 1) begin
        _saxi_register_11[31] <= 0;
        _saxi_register_9[31] <= 0;
      end 
      if(irq_busy_edge_22) begin
        _saxi_register_9[0] <= irq_busy_edge_22;
      end 
      if(irq_extern_edge_24) begin
        _saxi_register_9[1] <= irq_extern_edge_24;
      end 
      if(main_fsm == 0) begin
        _saxi_register_5 <= 0;
        _saxi_register_6 <= 0;
        _saxi_register_7 <= 0;
      end 
      if(main_fsm == 1) begin
        internal_state_counter <= 0;
        _saxi_register_12 <= 0;
      end else if(main_fsm == _saxi_register_13) begin
        if(internal_state_counter == _saxi_register_14) begin
          internal_state_counter <= 0;
          _saxi_register_12 <= _saxi_register_12 + 1;
        end else begin
          internal_state_counter <= internal_state_counter + 1;
        end
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_0 <= 1;
        _saxi_flag_0 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_1 <= 1;
        _saxi_flag_1 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_2 <= 1;
        _saxi_flag_2 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_3 <= 1;
        _saxi_flag_3 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_4 <= 1;
        _saxi_flag_4 <= 0;
      end 
      if((main_fsm == 1) && 1) begin
        _saxi_register_5 <= 1;
        _saxi_flag_5 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_6 <= 1;
        _saxi_flag_6 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_7 <= 1;
        _saxi_flag_7 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_8 <= 1;
        _saxi_flag_8 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_9 <= 1;
        _saxi_flag_9 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_10 <= 1;
        _saxi_flag_10 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_11 <= 1;
        _saxi_flag_11 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_12 <= 1;
        _saxi_flag_12 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_13 <= 1;
        _saxi_flag_13 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_14 <= 1;
        _saxi_flag_14 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_15 <= 1;
        _saxi_flag_15 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_16 <= 1;
        _saxi_flag_16 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_17 <= 1;
        _saxi_flag_17 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_18 <= 1;
        _saxi_flag_18 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_19 <= 1;
        _saxi_flag_19 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_20 <= 1;
        _saxi_flag_20 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_21 <= 1;
        _saxi_flag_21 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_22 <= 1;
        _saxi_flag_22 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_23 <= 1;
        _saxi_flag_23 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_24 <= 1;
        _saxi_flag_24 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_25 <= 1;
        _saxi_flag_25 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_26 <= 1;
        _saxi_flag_26 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_27 <= 1;
        _saxi_flag_27 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_28 <= 1;
        _saxi_flag_28 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_29 <= 1;
        _saxi_flag_29 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_30 <= 1;
        _saxi_flag_30 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_31 <= 1;
        _saxi_flag_31 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_32 <= 1;
        _saxi_flag_32 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_33 <= 1;
        _saxi_flag_33 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_34 <= 1;
        _saxi_flag_34 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_35 <= 1;
        _saxi_flag_35 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_36 <= 1;
        _saxi_flag_36 <= 0;
      end 
      if((main_fsm == 1) && 0) begin
        _saxi_register_37 <= 1;
        _saxi_flag_37 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_0 <= 0;
        _saxi_flag_0 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_1 <= 0;
        _saxi_flag_1 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_2 <= 0;
        _saxi_flag_2 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_3 <= 0;
        _saxi_flag_3 <= 0;
      end 
      if((main_fsm == 2) && 1) begin
        _saxi_register_4 <= 0;
        _saxi_flag_4 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_5 <= 0;
        _saxi_flag_5 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_6 <= 0;
        _saxi_flag_6 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_7 <= 0;
        _saxi_flag_7 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_8 <= 0;
        _saxi_flag_8 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_9 <= 0;
        _saxi_flag_9 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_10 <= 0;
        _saxi_flag_10 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_11 <= 0;
        _saxi_flag_11 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_12 <= 0;
        _saxi_flag_12 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_13 <= 0;
        _saxi_flag_13 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_14 <= 0;
        _saxi_flag_14 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_15 <= 0;
        _saxi_flag_15 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_16 <= 0;
        _saxi_flag_16 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_17 <= 0;
        _saxi_flag_17 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_18 <= 0;
        _saxi_flag_18 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_19 <= 0;
        _saxi_flag_19 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_20 <= 0;
        _saxi_flag_20 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_21 <= 0;
        _saxi_flag_21 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_22 <= 0;
        _saxi_flag_22 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_23 <= 0;
        _saxi_flag_23 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_24 <= 0;
        _saxi_flag_24 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_25 <= 0;
        _saxi_flag_25 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_26 <= 0;
        _saxi_flag_26 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_27 <= 0;
        _saxi_flag_27 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_28 <= 0;
        _saxi_flag_28 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_29 <= 0;
        _saxi_flag_29 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_30 <= 0;
        _saxi_flag_30 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_31 <= 0;
        _saxi_flag_31 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_32 <= 0;
        _saxi_flag_32 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_33 <= 0;
        _saxi_flag_33 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_34 <= 0;
        _saxi_flag_34 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_35 <= 0;
        _saxi_flag_35 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_36 <= 0;
        _saxi_flag_36 <= 0;
      end 
      if((main_fsm == 2) && 0) begin
        _saxi_register_37 <= 0;
        _saxi_flag_37 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_0 <= 0;
        _saxi_flag_0 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_1 <= 0;
        _saxi_flag_1 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_2 <= 0;
        _saxi_flag_2 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_3 <= 0;
        _saxi_flag_3 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_4 <= 0;
        _saxi_flag_4 <= 0;
      end 
      if((main_fsm == 13) && 1) begin
        _saxi_register_5 <= 0;
        _saxi_flag_5 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_6 <= 0;
        _saxi_flag_6 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_7 <= 0;
        _saxi_flag_7 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_8 <= 0;
        _saxi_flag_8 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_9 <= 0;
        _saxi_flag_9 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_10 <= 0;
        _saxi_flag_10 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_11 <= 0;
        _saxi_flag_11 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_12 <= 0;
        _saxi_flag_12 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_13 <= 0;
        _saxi_flag_13 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_14 <= 0;
        _saxi_flag_14 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_15 <= 0;
        _saxi_flag_15 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_16 <= 0;
        _saxi_flag_16 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_17 <= 0;
        _saxi_flag_17 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_18 <= 0;
        _saxi_flag_18 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_19 <= 0;
        _saxi_flag_19 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_20 <= 0;
        _saxi_flag_20 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_21 <= 0;
        _saxi_flag_21 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_22 <= 0;
        _saxi_flag_22 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_23 <= 0;
        _saxi_flag_23 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_24 <= 0;
        _saxi_flag_24 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_25 <= 0;
        _saxi_flag_25 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_26 <= 0;
        _saxi_flag_26 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_27 <= 0;
        _saxi_flag_27 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_28 <= 0;
        _saxi_flag_28 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_29 <= 0;
        _saxi_flag_29 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_30 <= 0;
        _saxi_flag_30 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_31 <= 0;
        _saxi_flag_31 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_32 <= 0;
        _saxi_flag_32 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_33 <= 0;
        _saxi_flag_33 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_34 <= 0;
        _saxi_flag_34 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_35 <= 0;
        _saxi_flag_35 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_36 <= 0;
        _saxi_flag_36 <= 0;
      end 
      if((main_fsm == 13) && 0) begin
        _saxi_register_37 <= 0;
        _saxi_flag_37 <= 0;
      end 
    end
  end

  localparam _saxi_register_fsm_1 = 1;
  localparam _saxi_register_fsm_2 = 2;

  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      _saxi_register_fsm <= _saxi_register_fsm_init;
      axis_maskaddr_16 <= 0;
    end else begin
      case(_saxi_register_fsm)
        _saxi_register_fsm_init: begin
          if(readvalid_13 || writevalid_12) begin
            axis_maskaddr_16 <= (addr_11 >> _saxi_shift) & _saxi_mask;
          end 
          if(readvalid_13) begin
            _saxi_register_fsm <= _saxi_register_fsm_1;
          end 
          if(writevalid_12) begin
            _saxi_register_fsm <= _saxi_register_fsm_2;
          end 
        end
        _saxi_register_fsm_1: begin
          if(saxi_rready || !saxi_rvalid) begin
            _saxi_register_fsm <= _saxi_register_fsm_init;
          end 
        end
        _saxi_register_fsm_2: begin
          if(saxi_wvalid) begin
            _saxi_register_fsm <= _saxi_register_fsm_init;
          end 
        end
      endcase
    end
  end


  always @(posedge CLK) begin
    _rst_logic_1 <= rst_logic;
    _rst_logic_2 <= _rst_logic_1;
    RST <= rst_logic | _rst_logic_1 | _rst_logic_2;
  end


  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      irq <= 0;
    end else begin
      irq <= |irq_20;
    end
  end


  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      irq_busy_edge_21 <= 0;
    end else begin
      irq_busy_edge_21 <= irq_busy;
    end
  end


  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      irq_extern_edge_23 <= 0;
    end else begin
      irq_extern_edge_23 <= irq_extern;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_94_1 <= 0;
    end else begin
      __tmp_94_1 <= _tmp_94;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_96_1 <= 0;
    end else begin
      __tmp_96_1 <= _tmp_96;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_98_1 <= 0;
    end else begin
      __tmp_98_1 <= _tmp_98;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_100_1 <= 0;
    end else begin
      __tmp_100_1 <= _tmp_100;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_108_1 <= 0;
    end else begin
      __tmp_108_1 <= _tmp_108;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_110_1 <= 0;
    end else begin
      __tmp_110_1 <= _tmp_110;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_112_1 <= 0;
    end else begin
      __tmp_112_1 <= _tmp_112;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_114_1 <= 0;
    end else begin
      __tmp_114_1 <= _tmp_114;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_185_1 <= 0;
    end else begin
      __tmp_185_1 <= _tmp_185;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_189_1 <= 0;
    end else begin
      __tmp_189_1 <= _tmp_189;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_193_1 <= 0;
    end else begin
      __tmp_193_1 <= _tmp_193;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      __tmp_197_1 <= 0;
    end else begin
      __tmp_197_1 <= _tmp_197;
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      _stream_add_2_source_1_source_ram_renable <= 0;
      _stream_add_2_source_1_source_fifo_deq <= 0;
      _stream_add_2_source_1_idle <= 1;
      _stream_add_2_source_3_source_ram_renable <= 0;
      _stream_add_2_source_3_source_fifo_deq <= 0;
      _stream_add_2_source_3_idle <= 1;
      _stream_add_2_sink_4_sink_wenable <= 0;
      _stream_add_2_sink_4_sink_fifo_enq <= 0;
      __stream_add_2_stream_ivalid_1 <= 0;
      _plus_data_6 <= 0;
      _stream_add_2_parameter_0_next_parameter_data <= 0;
      __variable_wdata_0 <= 0;
      _stream_add_2_source_1_source_mode <= 5'b0;
      _stream_add_2_source_1_source_offset <= 0;
      _stream_add_2_source_1_source_size <= 0;
      _stream_add_2_source_1_source_stride <= 0;
      _stream_add_2_source_1_source_sel <= 0;
      _stream_add_2_source_1_source_offset_buf <= 0;
      _stream_add_2_source_1_source_size_buf <= 0;
      _stream_add_2_source_1_source_stride_buf <= 0;
      __variable_wdata_1 <= 0;
      _stream_add_2_source_1_source_ram_raddr <= 0;
      _stream_add_2_source_1_source_count <= 0;
      _stream_add_2_parameter_2_next_parameter_data <= 0;
      __variable_wdata_3 <= 0;
      _stream_add_2_source_3_source_mode <= 5'b0;
      _stream_add_2_source_3_source_offset <= 0;
      _stream_add_2_source_3_source_size <= 0;
      _stream_add_2_source_3_source_stride <= 0;
      _stream_add_2_source_3_source_sel <= 0;
      _stream_add_2_source_3_source_offset_buf <= 0;
      _stream_add_2_source_3_source_size_buf <= 0;
      _stream_add_2_source_3_source_stride_buf <= 0;
      __variable_wdata_4 <= 0;
      _stream_add_2_source_3_source_ram_raddr <= 0;
      _stream_add_2_source_3_source_count <= 0;
      _tmp_118 <= 0;
      _tmp_119 <= 0;
      _tmp_120 <= 0;
      _tmp_121 <= 0;
      _tmp_122 <= 0;
      _tmp_123 <= 0;
      _tmp_124 <= 0;
      _tmp_125 <= 0;
      _tmp_126 <= 0;
      _stream_add_2_sink_4_sink_mode <= 5'b0;
      _stream_add_2_sink_4_sink_offset <= 0;
      _stream_add_2_sink_4_sink_size <= 0;
      _stream_add_2_sink_4_sink_stride <= 0;
      _stream_add_2_sink_4_sink_sel <= 0;
      _stream_add_2_sink_4_sink_offset_buf <= 0;
      _stream_add_2_sink_4_sink_size_buf <= 0;
      _stream_add_2_sink_4_sink_stride_buf <= 0;
      _stream_add_2_sink_4_sink_waddr <= 0;
      _stream_add_2_sink_4_sink_count <= 0;
      _stream_add_2_sink_4_sink_wdata <= 0;
      _tmp_129 <= 0;
      _tmp_130 <= 0;
      _tmp_131 <= 0;
      _tmp_134 <= 0;
      _tmp_135 <= 0;
      _tmp_136 <= 0;
      _tmp_137 <= 0;
      _tmp_138 <= 0;
      _tmp_139 <= 0;
      _tmp_140 <= 0;
      _tmp_141 <= 0;
      _tmp_142 <= 0;
      _tmp_143 <= 0;
      _tmp_144 <= 0;
      _stream_add_2_busy_reg <= 0;
    end else begin
      if(_stream_add_2_stream_oready) begin
        _stream_add_2_source_1_source_ram_renable <= 0;
        _stream_add_2_source_1_source_fifo_deq <= 0;
      end 
      _stream_add_2_source_1_idle <= _stream_add_2_source_1_idle;
      if(_stream_add_2_stream_oready) begin
        _stream_add_2_source_3_source_ram_renable <= 0;
        _stream_add_2_source_3_source_fifo_deq <= 0;
      end 
      _stream_add_2_source_3_idle <= _stream_add_2_source_3_idle;
      if(_stream_add_2_stream_oready) begin
        _stream_add_2_sink_4_sink_wenable <= 0;
        _stream_add_2_sink_4_sink_fifo_enq <= 0;
      end 
      if(_stream_add_2_stream_oready) begin
        __stream_add_2_stream_ivalid_1 <= _stream_add_2_stream_ivalid;
      end 
      if(_stream_add_2_stream_oready) begin
        _plus_data_6 <= _reinterpretcast_data_2 + _reinterpretcast_data_5;
      end 
      if(_set_flag_89) begin
        _stream_add_2_parameter_0_next_parameter_data <= (cparam_add_2_arg_stride_zeros_0)? 1 : 0;
      end 
      if(_stream_add_2_source_start) begin
        __variable_wdata_0 <= _stream_add_2_parameter_0_next_parameter_data;
      end 
      if(_set_flag_90) begin
        _stream_add_2_source_1_source_mode <= 5'b1;
        _stream_add_2_source_1_source_offset <= add_2_arg_page_comp_offset_0;
        _stream_add_2_source_1_source_size <= cparam_add_2_dma_size;
        _stream_add_2_source_1_source_stride <= (cparam_add_2_arg_stride_zeros_0)? 0 : 1;
      end 
      if(_set_flag_90) begin
        _stream_add_2_source_1_source_sel <= 1;
      end 
      if(_stream_add_2_source_start && _stream_add_2_source_1_source_mode & 5'b1 && _stream_add_2_stream_oready) begin
        _stream_add_2_source_1_source_offset_buf <= _stream_add_2_source_1_source_offset;
        _stream_add_2_source_1_source_size_buf <= _stream_add_2_source_1_source_size;
        _stream_add_2_source_1_source_stride_buf <= _stream_add_2_source_1_source_stride;
      end 
      if(_stream_add_2_stream_oready && _stream_add_2_source_busy && _stream_add_2_is_root) begin
        __variable_wdata_1 <= _stream_add_2_source_1_source_ram_rdata;
      end 
      if((_stream_add_2_source_1_source_fsm_0 == 1) && _stream_add_2_stream_oready) begin
        _stream_add_2_source_1_idle <= 0;
        _stream_add_2_source_1_source_ram_raddr <= _stream_add_2_source_1_source_offset_buf;
        _stream_add_2_source_1_source_ram_renable <= 1;
        _stream_add_2_source_1_source_count <= _stream_add_2_source_1_source_size_buf;
      end 
      if((_stream_add_2_source_1_source_fsm_0 == 2) && _stream_add_2_stream_oready) begin
        _stream_add_2_source_1_source_ram_raddr <= _stream_add_2_source_1_source_ram_raddr + _stream_add_2_source_1_source_stride_buf;
        _stream_add_2_source_1_source_ram_renable <= 1;
        _stream_add_2_source_1_source_count <= _stream_add_2_source_1_source_count - 1;
      end 
      if((_stream_add_2_source_1_source_fsm_0 == 2) && (_stream_add_2_source_1_source_count == 1) && _stream_add_2_stream_oready) begin
        _stream_add_2_source_1_source_ram_renable <= 0;
        _stream_add_2_source_1_idle <= 1;
      end 
      if((_stream_add_2_source_1_source_fsm_0 == 2) && _stream_add_2_source_stop && _stream_add_2_stream_oready) begin
        _stream_add_2_source_1_source_ram_renable <= 0;
        _stream_add_2_source_1_idle <= 1;
      end 
      if(_set_flag_103) begin
        _stream_add_2_parameter_2_next_parameter_data <= (cparam_add_2_arg_stride_zeros_1)? 1 : 0;
      end 
      if(_stream_add_2_source_start) begin
        __variable_wdata_3 <= _stream_add_2_parameter_2_next_parameter_data;
      end 
      if(_set_flag_104) begin
        _stream_add_2_source_3_source_mode <= 5'b1;
        _stream_add_2_source_3_source_offset <= add_2_arg_page_comp_offset_1;
        _stream_add_2_source_3_source_size <= cparam_add_2_dma_size;
        _stream_add_2_source_3_source_stride <= (cparam_add_2_arg_stride_zeros_1)? 0 : 1;
      end 
      if(_set_flag_104) begin
        _stream_add_2_source_3_source_sel <= 2;
      end 
      if(_stream_add_2_source_start && _stream_add_2_source_3_source_mode & 5'b1 && _stream_add_2_stream_oready) begin
        _stream_add_2_source_3_source_offset_buf <= _stream_add_2_source_3_source_offset;
        _stream_add_2_source_3_source_size_buf <= _stream_add_2_source_3_source_size;
        _stream_add_2_source_3_source_stride_buf <= _stream_add_2_source_3_source_stride;
      end 
      if(_stream_add_2_stream_oready && _stream_add_2_source_busy && _stream_add_2_is_root) begin
        __variable_wdata_4 <= _stream_add_2_source_3_source_ram_rdata;
      end 
      if((_stream_add_2_source_3_source_fsm_1 == 1) && _stream_add_2_stream_oready) begin
        _stream_add_2_source_3_idle <= 0;
        _stream_add_2_source_3_source_ram_raddr <= _stream_add_2_source_3_source_offset_buf;
        _stream_add_2_source_3_source_ram_renable <= 1;
        _stream_add_2_source_3_source_count <= _stream_add_2_source_3_source_size_buf;
      end 
      if((_stream_add_2_source_3_source_fsm_1 == 2) && _stream_add_2_stream_oready) begin
        _stream_add_2_source_3_source_ram_raddr <= _stream_add_2_source_3_source_ram_raddr + _stream_add_2_source_3_source_stride_buf;
        _stream_add_2_source_3_source_ram_renable <= 1;
        _stream_add_2_source_3_source_count <= _stream_add_2_source_3_source_count - 1;
      end 
      if((_stream_add_2_source_3_source_fsm_1 == 2) && (_stream_add_2_source_3_source_count == 1) && _stream_add_2_stream_oready) begin
        _stream_add_2_source_3_source_ram_renable <= 0;
        _stream_add_2_source_3_idle <= 1;
      end 
      if((_stream_add_2_source_3_source_fsm_1 == 2) && _stream_add_2_source_stop && _stream_add_2_stream_oready) begin
        _stream_add_2_source_3_source_ram_renable <= 0;
        _stream_add_2_source_3_idle <= 1;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_118 <= _set_flag_117;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_119 <= _tmp_118;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_120 <= _tmp_119;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_121 <= add_2_out_page_comp_offset;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_122 <= _tmp_121;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_123 <= _tmp_122;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_124 <= cparam_add_2_dma_size;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_125 <= _tmp_124;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_126 <= _tmp_125;
      end 
      if(_tmp_120) begin
        _stream_add_2_sink_4_sink_mode <= 5'b1;
        _stream_add_2_sink_4_sink_offset <= _tmp_123;
        _stream_add_2_sink_4_sink_size <= _tmp_126;
        _stream_add_2_sink_4_sink_stride <= 1;
      end 
      if(_tmp_120) begin
        _stream_add_2_sink_4_sink_sel <= 3;
      end 
      if(_stream_add_2_sink_start && _stream_add_2_sink_4_sink_mode & 5'b1 && _stream_add_2_stream_oready) begin
        _stream_add_2_sink_4_sink_offset_buf <= _stream_add_2_sink_4_sink_offset;
        _stream_add_2_sink_4_sink_size_buf <= _stream_add_2_sink_4_sink_size;
        _stream_add_2_sink_4_sink_stride_buf <= _stream_add_2_sink_4_sink_stride;
      end 
      if((_stream_add_2_sink_4_sink_fsm_2 == 1) && _stream_add_2_stream_oready) begin
        _stream_add_2_sink_4_sink_waddr <= _stream_add_2_sink_4_sink_offset_buf - _stream_add_2_sink_4_sink_stride_buf;
        _stream_add_2_sink_4_sink_count <= _stream_add_2_sink_4_sink_size_buf;
      end 
      if((_stream_add_2_sink_4_sink_fsm_2 == 2) && _stream_add_2_stream_oready) begin
        _stream_add_2_sink_4_sink_waddr <= _stream_add_2_sink_4_sink_waddr + _stream_add_2_sink_4_sink_stride_buf;
        _stream_add_2_sink_4_sink_wdata <= stream_add_2_sink_4_data;
        _stream_add_2_sink_4_sink_wenable <= 1;
        _stream_add_2_sink_4_sink_count <= _stream_add_2_sink_4_sink_count - 1;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_129 <= _stream_add_2_source_start;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_130 <= _tmp_129;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_131 <= _tmp_130;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_134 <= _tmp_133;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_135 <= _stream_add_2_source_start;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_136 <= _tmp_135;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_137 <= _tmp_136;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_138 <= _stream_add_2_source_stop;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_139 <= _tmp_138;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_140 <= _tmp_139;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_141 <= _stream_add_2_source_busy;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_142 <= _tmp_141;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_143 <= _tmp_142;
      end 
      if(_stream_add_2_stream_oready) begin
        _tmp_144 <= _stream_add_2_sink_busy;
      end 
      if(!_stream_add_2_sink_busy && _tmp_144) begin
        _stream_add_2_busy_reg <= 0;
      end 
      if(_stream_add_2_source_busy) begin
        _stream_add_2_busy_reg <= 1;
      end 
    end
  end

  localparam _stream_add_2_fsm_1 = 1;
  localparam _stream_add_2_fsm_2 = 2;
  localparam _stream_add_2_fsm_3 = 3;

  always @(posedge CLK) begin
    if(RST) begin
      _stream_add_2_fsm <= _stream_add_2_fsm_init;
      _stream_add_2_source_start <= 0;
      _stream_add_2_source_busy <= 0;
      _stream_add_2_stream_ivalid <= 0;
    end else begin
      if(_stream_add_2_stream_oready && _tmp_131) begin
        _stream_add_2_stream_ivalid <= 1;
      end 
      if(_stream_add_2_stream_oready && _tmp_134) begin
        _stream_add_2_stream_ivalid <= 0;
      end 
      case(_stream_add_2_fsm)
        _stream_add_2_fsm_init: begin
          if(_stream_add_2_run_flag) begin
            _stream_add_2_source_start <= 1;
          end 
          if(_stream_add_2_run_flag) begin
            _stream_add_2_fsm <= _stream_add_2_fsm_1;
          end 
        end
        _stream_add_2_fsm_1: begin
          if(_stream_add_2_source_start && _stream_add_2_stream_oready) begin
            _stream_add_2_source_start <= 0;
            _stream_add_2_source_busy <= 1;
          end 
          if(_stream_add_2_source_start && _stream_add_2_stream_oready) begin
            _stream_add_2_fsm <= _stream_add_2_fsm_2;
          end 
        end
        _stream_add_2_fsm_2: begin
          if(_stream_add_2_stream_oready) begin
            _stream_add_2_fsm <= _stream_add_2_fsm_3;
          end 
        end
        _stream_add_2_fsm_3: begin
          if(_stream_add_2_stream_oready && (_stream_add_2_source_1_idle && _stream_add_2_source_3_idle && (_stream_add_2_fsm == 3))) begin
            _stream_add_2_source_busy <= 0;
          end 
          if(_stream_add_2_stream_oready && (_stream_add_2_source_1_idle && _stream_add_2_source_3_idle && (_stream_add_2_fsm == 3)) && _stream_add_2_run_flag) begin
            _stream_add_2_source_start <= 1;
          end 
          if(_stream_add_2_stream_oready && (_stream_add_2_source_1_idle && _stream_add_2_source_3_idle && (_stream_add_2_fsm == 3))) begin
            _stream_add_2_fsm <= _stream_add_2_fsm_init;
          end 
          if(_stream_add_2_stream_oready && (_stream_add_2_source_1_idle && _stream_add_2_source_3_idle && (_stream_add_2_fsm == 3)) && _stream_add_2_run_flag) begin
            _stream_add_2_fsm <= _stream_add_2_fsm_1;
          end 
        end
      endcase
    end
  end

  localparam main_fsm_1 = 1;
  localparam main_fsm_2 = 2;
  localparam main_fsm_3 = 3;
  localparam main_fsm_4 = 4;
  localparam main_fsm_5 = 5;
  localparam main_fsm_6 = 6;
  localparam main_fsm_7 = 7;
  localparam main_fsm_8 = 8;
  localparam main_fsm_9 = 9;
  localparam main_fsm_10 = 10;
  localparam main_fsm_11 = 11;
  localparam main_fsm_12 = 12;
  localparam main_fsm_13 = 13;
  localparam main_fsm_14 = 14;
  localparam main_fsm_15 = 15;
  localparam main_fsm_16 = 16;

  always @(posedge CLK) begin
    if(RST) begin
      main_fsm <= main_fsm_init;
      add_2_objaddr <= 0;
      add_2_arg_objaddr_0 <= 0;
      add_2_arg_objaddr_1 <= 0;
    end else begin
      case(main_fsm)
        main_fsm_init: begin
          if(_saxi_register_4 != 0) begin
            main_fsm <= main_fsm_1;
          end 
        end
        main_fsm_1: begin
          main_fsm <= main_fsm_2;
        end
        main_fsm_2: begin
          main_fsm <= main_fsm_3;
        end
        main_fsm_3: begin
          main_fsm <= main_fsm_4;
        end
        main_fsm_4: begin
          main_fsm <= main_fsm_5;
        end
        main_fsm_5: begin
          add_2_objaddr <= _saxi_register_34;
          main_fsm <= main_fsm_6;
        end
        main_fsm_6: begin
          add_2_arg_objaddr_0 <= _saxi_register_35;
          main_fsm <= main_fsm_7;
        end
        main_fsm_7: begin
          add_2_arg_objaddr_1 <= _saxi_register_36;
          main_fsm <= main_fsm_8;
        end
        main_fsm_8: begin
          main_fsm <= main_fsm_9;
        end
        main_fsm_9: begin
          main_fsm <= main_fsm_10;
        end
        main_fsm_10: begin
          if(control_add_2 == 31) begin
            main_fsm <= main_fsm_11;
          end 
        end
        main_fsm_11: begin
          main_fsm <= main_fsm_12;
        end
        main_fsm_12: begin
          main_fsm <= main_fsm_13;
        end
        main_fsm_13: begin
          main_fsm <= main_fsm_14;
        end
        main_fsm_14: begin
          main_fsm <= main_fsm_15;
        end
        main_fsm_15: begin
          main_fsm <= main_fsm_16;
        end
        main_fsm_16: begin
          main_fsm <= main_fsm_init;
        end
      endcase
    end
  end

  localparam control_add_2_1 = 1;
  localparam control_add_2_2 = 2;
  localparam control_add_2_3 = 3;
  localparam control_add_2_4 = 4;
  localparam control_add_2_5 = 5;
  localparam control_add_2_6 = 6;
  localparam control_add_2_7 = 7;
  localparam control_add_2_8 = 8;
  localparam control_add_2_9 = 9;
  localparam control_add_2_10 = 10;
  localparam control_add_2_11 = 11;
  localparam control_add_2_12 = 12;
  localparam control_add_2_13 = 13;
  localparam control_add_2_14 = 14;
  localparam control_add_2_15 = 15;
  localparam control_add_2_16 = 16;
  localparam control_add_2_17 = 17;
  localparam control_add_2_18 = 18;
  localparam control_add_2_19 = 19;
  localparam control_add_2_20 = 20;
  localparam control_add_2_21 = 21;
  localparam control_add_2_22 = 22;
  localparam control_add_2_23 = 23;
  localparam control_add_2_24 = 24;
  localparam control_add_2_25 = 25;
  localparam control_add_2_26 = 26;
  localparam control_add_2_27 = 27;
  localparam control_add_2_28 = 28;
  localparam control_add_2_29 = 29;
  localparam control_add_2_30 = 30;
  localparam control_add_2_31 = 31;

  always @(posedge CLK) begin
    if(RST) begin
      control_add_2 <= control_add_2_init;
      _control_add_2_called <= 0;
      add_2_out_gaddr <= 0;
      add_2_comp_count <= 0;
      add_2_arg_gaddr_offset_0_0 <= 0;
      add_2_arg_gaddr_offset_1_0 <= 0;
      add_2_arg_trip_count_0_0 <= 0;
      add_2_arg_trip_count_1_0 <= 0;
      add_2_arg_repeat_count_0_0 <= 0;
      add_2_arg_repeat_count_1_0 <= 0;
      add_2_out_page <= 0;
      add_2_out_page_comp_offset <= 0;
      add_2_out_page_dma_offset <= 0;
      add_2_arg_page_0 <= 0;
      add_2_arg_page_1 <= 0;
      add_2_arg_page_comp_offset_0 <= 0;
      add_2_arg_page_comp_offset_1 <= 0;
      add_2_arg_page_dma_offset_0 <= 0;
      add_2_arg_page_dma_offset_1 <= 0;
      add_2_skip_read <= 0;
      add_2_skip_comp <= 0;
      add_2_skip_write <= 0;
    end else begin
      case(control_add_2)
        control_add_2_init: begin
          if(main_fsm == 8) begin
            _control_add_2_called <= 1;
          end 
          if(main_fsm == 8) begin
            control_add_2 <= control_add_2_1;
          end 
        end
        control_add_2_1: begin
          control_add_2 <= control_add_2_2;
        end
        control_add_2_2: begin
          add_2_out_gaddr <= 0;
          add_2_comp_count <= 0;
          add_2_arg_gaddr_offset_0_0 <= 0;
          add_2_arg_gaddr_offset_1_0 <= 0;
          add_2_arg_trip_count_0_0 <= 0;
          add_2_arg_trip_count_1_0 <= 0;
          add_2_arg_repeat_count_0_0 <= 0;
          add_2_arg_repeat_count_1_0 <= 0;
          add_2_out_page <= 0;
          add_2_out_page_comp_offset <= 0;
          add_2_out_page_dma_offset <= 1024;
          add_2_arg_page_0 <= 0;
          add_2_arg_page_1 <= 0;
          add_2_arg_page_comp_offset_0 <= 0;
          add_2_arg_page_comp_offset_1 <= 0;
          add_2_arg_page_dma_offset_0 <= 0;
          add_2_arg_page_dma_offset_1 <= 0;
          add_2_skip_read <= 0;
          add_2_skip_comp <= 0;
          add_2_skip_write <= 1;
          control_add_2 <= control_add_2_3;
        end
        control_add_2_3: begin
          control_add_2 <= control_add_2_4;
          if(add_2_skip_read) begin
            control_add_2 <= control_add_2_20;
          end 
        end
        control_add_2_4: begin
          control_add_2 <= control_add_2_5;
          if(cparam_add_2_arg_omit_dmas_0 && !add_2_skip_write) begin
            control_add_2 <= control_add_2_12;
          end 
          if(cparam_add_2_arg_omit_dmas_0 && cparam_add_2_arg_stride_zeros_0 && add_2_skip_write) begin
            control_add_2 <= control_add_2_8;
          end 
        end
        control_add_2_5: begin
          if(_maxi_read_req_idle) begin
            control_add_2 <= control_add_2_6;
          end 
        end
        control_add_2_6: begin
          if(_maxi_read_idle) begin
            control_add_2 <= control_add_2_7;
          end 
        end
        control_add_2_7: begin
          control_add_2 <= control_add_2_8;
        end
        control_add_2_8: begin
          control_add_2 <= control_add_2_9;
          if(!cparam_add_2_arg_stride_zeros_0) begin
            control_add_2 <= control_add_2_12;
          end 
        end
        control_add_2_9: begin
          if(_maxi_read_req_idle) begin
            control_add_2 <= control_add_2_10;
          end 
        end
        control_add_2_10: begin
          if(_maxi_read_idle) begin
            control_add_2 <= control_add_2_11;
          end 
        end
        control_add_2_11: begin
          control_add_2 <= control_add_2_12;
        end
        control_add_2_12: begin
          control_add_2 <= control_add_2_13;
          if(cparam_add_2_arg_omit_dmas_1 && !add_2_skip_write) begin
            control_add_2 <= control_add_2_20;
          end 
          if(cparam_add_2_arg_omit_dmas_1 && cparam_add_2_arg_stride_zeros_1 && add_2_skip_write) begin
            control_add_2 <= control_add_2_16;
          end 
        end
        control_add_2_13: begin
          if(_maxi_read_req_idle) begin
            control_add_2 <= control_add_2_14;
          end 
        end
        control_add_2_14: begin
          if(_maxi_read_idle) begin
            control_add_2 <= control_add_2_15;
          end 
        end
        control_add_2_15: begin
          control_add_2 <= control_add_2_16;
        end
        control_add_2_16: begin
          control_add_2 <= control_add_2_17;
          if(!cparam_add_2_arg_stride_zeros_1) begin
            control_add_2 <= control_add_2_20;
          end 
        end
        control_add_2_17: begin
          if(_maxi_read_req_idle) begin
            control_add_2 <= control_add_2_18;
          end 
        end
        control_add_2_18: begin
          if(_maxi_read_idle) begin
            control_add_2 <= control_add_2_19;
          end 
        end
        control_add_2_19: begin
          control_add_2 <= control_add_2_20;
        end
        control_add_2_20: begin
          if(!_stream_add_2_source_busy) begin
            control_add_2 <= control_add_2_21;
          end 
          if(add_2_skip_comp) begin
            control_add_2 <= control_add_2_25;
          end 
        end
        control_add_2_21: begin
          control_add_2 <= control_add_2_22;
          control_add_2 <= control_add_2_22;
          control_add_2 <= control_add_2_22;
          control_add_2 <= control_add_2_22;
          if(_stream_add_2_stream_oready) begin
            control_add_2 <= control_add_2_22;
          end 
          control_add_2 <= control_add_2_22;
        end
        control_add_2_22: begin
          if(_maxi_write_idle) begin
            control_add_2 <= control_add_2_23;
          end 
        end
        control_add_2_23: begin
          control_add_2 <= control_add_2_24;
        end
        control_add_2_24: begin
          if(_stream_add_2_busy) begin
            control_add_2 <= control_add_2_25;
          end 
        end
        control_add_2_25: begin
          if(!_stream_add_2_busy) begin
            control_add_2 <= control_add_2_26;
          end 
          if(!add_2_skip_comp) begin
            control_add_2 <= control_add_2_26;
          end 
        end
        control_add_2_26: begin
          control_add_2 <= control_add_2_27;
          if(add_2_skip_write) begin
            control_add_2 <= control_add_2_29;
          end 
        end
        control_add_2_27: begin
          if(_maxi_write_req_idle) begin
            control_add_2 <= control_add_2_28;
          end 
        end
        control_add_2_28: begin
          control_add_2 <= control_add_2_29;
        end
        control_add_2_29: begin
          add_2_comp_count <= add_2_comp_count + 1;
          if(!add_2_skip_write) begin
            add_2_out_gaddr <= add_2_out_gaddr + cparam_add_2_addr_inc;
          end 
          if(!add_2_arg_page_0 && !cparam_add_2_arg_omit_dmas_0) begin
            add_2_arg_page_comp_offset_0 <= 1024;
            add_2_arg_page_dma_offset_0 <= 1024;
            add_2_arg_page_0 <= 1;
          end 
          if(add_2_arg_page_0 && !cparam_add_2_arg_omit_dmas_0) begin
            add_2_arg_page_comp_offset_0 <= 0;
            add_2_arg_page_dma_offset_0 <= 0;
            add_2_arg_page_0 <= 0;
          end 
          if(!add_2_arg_page_1 && !cparam_add_2_arg_omit_dmas_1) begin
            add_2_arg_page_comp_offset_1 <= 1024;
            add_2_arg_page_dma_offset_1 <= 1024;
            add_2_arg_page_1 <= 1;
          end 
          if(add_2_arg_page_1 && !cparam_add_2_arg_omit_dmas_1) begin
            add_2_arg_page_comp_offset_1 <= 0;
            add_2_arg_page_dma_offset_1 <= 0;
            add_2_arg_page_1 <= 0;
          end 
          if(!add_2_out_page) begin
            add_2_out_page_comp_offset <= 1024;
            add_2_out_page_dma_offset <= 0;
            add_2_out_page <= 1;
          end 
          if(add_2_out_page) begin
            add_2_out_page_comp_offset <= 0;
            add_2_out_page_dma_offset <= 1024;
            add_2_out_page <= 0;
          end 
          add_2_skip_write <= 0;
          if(add_2_comp_count == cparam_add_2_num_comp - 1) begin
            add_2_skip_read <= 1;
            add_2_skip_comp <= 1;
          end 
          if(add_2_comp_count < cparam_add_2_num_comp) begin
            control_add_2 <= control_add_2_3;
          end 
          if(add_2_comp_count == cparam_add_2_num_comp) begin
            control_add_2 <= control_add_2_30;
          end 
        end
        control_add_2_30: begin
          if(_maxi_write_idle && (outstanding_wcount_0 == 0)) begin
            control_add_2 <= control_add_2_31;
          end 
        end
        control_add_2_31: begin
          if(main_fsm == 11) begin
            _control_add_2_called <= 0;
          end 
          if(main_fsm == 11) begin
            control_add_2 <= control_add_2_init;
          end 
        end
      endcase
    end
  end

  localparam _maxi_read_req_fsm_1 = 1;

  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      _maxi_read_req_fsm <= _maxi_read_req_fsm_init;
      _maxi_read_cont <= 0;
    end else begin
      case(_maxi_read_req_fsm)
        _maxi_read_req_fsm_init: begin
          if((_maxi_read_req_fsm == 0) && (_maxi_read_start || _maxi_read_cont) && !_maxi_read_req_fifo_almost_full) begin
            _maxi_read_req_fsm <= _maxi_read_req_fsm_1;
          end 
        end
        _maxi_read_req_fsm_1: begin
          if(maxi_arready || !maxi_arvalid) begin
            _maxi_read_cont <= 1;
          end 
          if((maxi_arready || !maxi_arvalid) && (_maxi_read_global_size == 0)) begin
            _maxi_read_cont <= 0;
          end 
          if(maxi_arready || !maxi_arvalid) begin
            _maxi_read_req_fsm <= _maxi_read_req_fsm_init;
          end 
        end
      endcase
    end
  end

  localparam _maxi_read_data_fsm_1 = 1;
  localparam _maxi_read_data_fsm_2 = 2;

  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      _maxi_read_data_fsm <= _maxi_read_data_fsm_init;
    end else begin
      case(_maxi_read_data_fsm)
        _maxi_read_data_fsm_init: begin
          if(_maxi_read_data_idle && !_maxi_read_req_fifo_empty && (_maxi_read_op_sel_fifo == 1)) begin
            _maxi_read_data_fsm <= _maxi_read_data_fsm_1;
          end 
          if(_maxi_read_data_idle && !_maxi_read_req_fifo_empty && (_maxi_read_op_sel_fifo == 2)) begin
            _maxi_read_data_fsm <= _maxi_read_data_fsm_1;
          end 
        end
        _maxi_read_data_fsm_1: begin
          _maxi_read_data_fsm <= _maxi_read_data_fsm_2;
          _maxi_read_data_fsm <= _maxi_read_data_fsm_2;
        end
        _maxi_read_data_fsm_2: begin
          if(maxi_rvalid && (_maxi_read_local_size_buf <= 1)) begin
            _maxi_read_data_fsm <= _maxi_read_data_fsm_init;
          end 
          if(maxi_rvalid && (_maxi_read_local_size_buf <= 1)) begin
            _maxi_read_data_fsm <= _maxi_read_data_fsm_init;
          end 
        end
      endcase
    end
  end

  localparam write_burst_packed_fsm_0_1 = 1;

  always @(posedge CLK) begin
    if(RST) begin
      write_burst_packed_fsm_0 <= write_burst_packed_fsm_0_init;
      write_burst_packed_addr_50 <= 0;
      write_burst_packed_stride_51 <= 0;
      write_burst_packed_length_52 <= 0;
      write_burst_packed_done_53 <= 0;
    end else begin
      case(write_burst_packed_fsm_0)
        write_burst_packed_fsm_0_init: begin
          write_burst_packed_addr_50 <= _maxi_read_local_addr_buf;
          write_burst_packed_stride_51 <= _maxi_read_local_stride_buf;
          write_burst_packed_length_52 <= _maxi_read_local_size_buf;
          write_burst_packed_done_53 <= 0;
          if((_maxi_read_data_fsm == 1) && (_maxi_read_op_sel_buf == 1) && (_maxi_read_local_size_buf > 0)) begin
            write_burst_packed_fsm_0 <= write_burst_packed_fsm_0_1;
          end 
        end
        write_burst_packed_fsm_0_1: begin
          if(maxi_rvalid) begin
            write_burst_packed_addr_50 <= write_burst_packed_addr_50 + write_burst_packed_stride_51;
            write_burst_packed_length_52 <= write_burst_packed_length_52 - 1;
            write_burst_packed_done_53 <= 0;
          end 
          if(maxi_rvalid && (write_burst_packed_length_52 <= 1)) begin
            write_burst_packed_done_53 <= 1;
          end 
          if(maxi_rvalid && 0) begin
            write_burst_packed_done_53 <= 1;
          end 
          if(maxi_rvalid && (write_burst_packed_length_52 <= 1)) begin
            write_burst_packed_fsm_0 <= write_burst_packed_fsm_0_init;
          end 
          if(maxi_rvalid && 0) begin
            write_burst_packed_fsm_0 <= write_burst_packed_fsm_0_init;
          end 
          if(0) begin
            write_burst_packed_fsm_0 <= write_burst_packed_fsm_0_init;
          end 
        end
      endcase
    end
  end

  localparam write_burst_packed_fsm_1_1 = 1;

  always @(posedge CLK) begin
    if(RST) begin
      write_burst_packed_fsm_1 <= write_burst_packed_fsm_1_init;
      write_burst_packed_addr_72 <= 0;
      write_burst_packed_stride_73 <= 0;
      write_burst_packed_length_74 <= 0;
      write_burst_packed_done_75 <= 0;
    end else begin
      case(write_burst_packed_fsm_1)
        write_burst_packed_fsm_1_init: begin
          write_burst_packed_addr_72 <= _maxi_read_local_addr_buf;
          write_burst_packed_stride_73 <= _maxi_read_local_stride_buf;
          write_burst_packed_length_74 <= _maxi_read_local_size_buf;
          write_burst_packed_done_75 <= 0;
          if((_maxi_read_data_fsm == 1) && (_maxi_read_op_sel_buf == 2) && (_maxi_read_local_size_buf > 0)) begin
            write_burst_packed_fsm_1 <= write_burst_packed_fsm_1_1;
          end 
        end
        write_burst_packed_fsm_1_1: begin
          if(maxi_rvalid) begin
            write_burst_packed_addr_72 <= write_burst_packed_addr_72 + write_burst_packed_stride_73;
            write_burst_packed_length_74 <= write_burst_packed_length_74 - 1;
            write_burst_packed_done_75 <= 0;
          end 
          if(maxi_rvalid && (write_burst_packed_length_74 <= 1)) begin
            write_burst_packed_done_75 <= 1;
          end 
          if(maxi_rvalid && 0) begin
            write_burst_packed_done_75 <= 1;
          end 
          if(maxi_rvalid && (write_burst_packed_length_74 <= 1)) begin
            write_burst_packed_fsm_1 <= write_burst_packed_fsm_1_init;
          end 
          if(maxi_rvalid && 0) begin
            write_burst_packed_fsm_1 <= write_burst_packed_fsm_1_init;
          end 
          if(0) begin
            write_burst_packed_fsm_1 <= write_burst_packed_fsm_1_init;
          end 
        end
      endcase
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      _tmp_92 <= 0;
    end else begin
      if(_stream_add_2_stream_oready && _stream_add_2_source_1_source_ram_renable && (_stream_add_2_source_1_source_sel == 1)) begin
        _tmp_92 <= read_rtl_bank_91;
      end 
    end
  end

  localparam _stream_add_2_source_1_source_fsm_0_1 = 1;
  localparam _stream_add_2_source_1_source_fsm_0_2 = 2;

  always @(posedge CLK) begin
    if(RST) begin
      _stream_add_2_source_1_source_fsm_0 <= _stream_add_2_source_1_source_fsm_0_init;
    end else begin
      case(_stream_add_2_source_1_source_fsm_0)
        _stream_add_2_source_1_source_fsm_0_init: begin
          if(_stream_add_2_source_start && _stream_add_2_source_1_source_mode & 5'b1 && _stream_add_2_stream_oready) begin
            _stream_add_2_source_1_source_fsm_0 <= _stream_add_2_source_1_source_fsm_0_1;
          end 
        end
        _stream_add_2_source_1_source_fsm_0_1: begin
          if(_stream_add_2_stream_oready) begin
            _stream_add_2_source_1_source_fsm_0 <= _stream_add_2_source_1_source_fsm_0_2;
          end 
        end
        _stream_add_2_source_1_source_fsm_0_2: begin
          if((_stream_add_2_source_1_source_count == 1) && _stream_add_2_stream_oready) begin
            _stream_add_2_source_1_source_fsm_0 <= _stream_add_2_source_1_source_fsm_0_init;
          end 
          if(_stream_add_2_source_stop && _stream_add_2_stream_oready) begin
            _stream_add_2_source_1_source_fsm_0 <= _stream_add_2_source_1_source_fsm_0_init;
          end 
        end
      endcase
    end
  end


  always @(posedge CLK) begin
    if(RST) begin
      _tmp_106 <= 0;
    end else begin
      if(_stream_add_2_stream_oready && _stream_add_2_source_3_source_ram_renable && (_stream_add_2_source_3_source_sel == 2)) begin
        _tmp_106 <= read_rtl_bank_105;
      end 
    end
  end

  localparam _stream_add_2_source_3_source_fsm_1_1 = 1;
  localparam _stream_add_2_source_3_source_fsm_1_2 = 2;

  always @(posedge CLK) begin
    if(RST) begin
      _stream_add_2_source_3_source_fsm_1 <= _stream_add_2_source_3_source_fsm_1_init;
    end else begin
      case(_stream_add_2_source_3_source_fsm_1)
        _stream_add_2_source_3_source_fsm_1_init: begin
          if(_stream_add_2_source_start && _stream_add_2_source_3_source_mode & 5'b1 && _stream_add_2_stream_oready) begin
            _stream_add_2_source_3_source_fsm_1 <= _stream_add_2_source_3_source_fsm_1_1;
          end 
        end
        _stream_add_2_source_3_source_fsm_1_1: begin
          if(_stream_add_2_stream_oready) begin
            _stream_add_2_source_3_source_fsm_1 <= _stream_add_2_source_3_source_fsm_1_2;
          end 
        end
        _stream_add_2_source_3_source_fsm_1_2: begin
          if((_stream_add_2_source_3_source_count == 1) && _stream_add_2_stream_oready) begin
            _stream_add_2_source_3_source_fsm_1 <= _stream_add_2_source_3_source_fsm_1_init;
          end 
          if(_stream_add_2_source_stop && _stream_add_2_stream_oready) begin
            _stream_add_2_source_3_source_fsm_1 <= _stream_add_2_source_3_source_fsm_1_init;
          end 
        end
      endcase
    end
  end

  localparam _stream_add_2_sink_4_sink_fsm_2_1 = 1;
  localparam _stream_add_2_sink_4_sink_fsm_2_2 = 2;

  always @(posedge CLK) begin
    if(RST) begin
      _stream_add_2_sink_4_sink_fsm_2 <= _stream_add_2_sink_4_sink_fsm_2_init;
    end else begin
      case(_stream_add_2_sink_4_sink_fsm_2)
        _stream_add_2_sink_4_sink_fsm_2_init: begin
          if(_stream_add_2_sink_start && _stream_add_2_sink_4_sink_mode & 5'b1 && _stream_add_2_stream_oready) begin
            _stream_add_2_sink_4_sink_fsm_2 <= _stream_add_2_sink_4_sink_fsm_2_1;
          end 
        end
        _stream_add_2_sink_4_sink_fsm_2_1: begin
          if(_stream_add_2_stream_oready) begin
            _stream_add_2_sink_4_sink_fsm_2 <= _stream_add_2_sink_4_sink_fsm_2_2;
          end 
        end
        _stream_add_2_sink_4_sink_fsm_2_2: begin
          if((_stream_add_2_sink_4_sink_count == 1) && _stream_add_2_stream_oready) begin
            _stream_add_2_sink_4_sink_fsm_2 <= _stream_add_2_sink_4_sink_fsm_2_init;
          end 
          if(_stream_add_2_sink_stop && _stream_add_2_stream_oready) begin
            _stream_add_2_sink_4_sink_fsm_2 <= _stream_add_2_sink_4_sink_fsm_2_init;
          end 
        end
      endcase
    end
  end

  localparam _maxi_write_req_fsm_1 = 1;

  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      _maxi_write_req_fsm <= _maxi_write_req_fsm_init;
      _maxi_write_cont <= 0;
    end else begin
      case(_maxi_write_req_fsm)
        _maxi_write_req_fsm_init: begin
          if((_maxi_write_req_fsm == 0) && (_maxi_write_start || _maxi_write_cont) && !_maxi_write_req_fifo_almost_full) begin
            _maxi_write_req_fsm <= _maxi_write_req_fsm_1;
          end 
        end
        _maxi_write_req_fsm_1: begin
          if((_maxi_write_req_fsm == 1) && !_maxi_write_req_fifo_almost_full && (maxi_awready || !maxi_awvalid) && (outstanding_wcount_0 < 6)) begin
            _maxi_write_cont <= 1;
          end 
          if((_maxi_write_req_fsm == 1) && !_maxi_write_req_fifo_almost_full && (maxi_awready || !maxi_awvalid) && (outstanding_wcount_0 < 6) && (_maxi_write_global_size == 0)) begin
            _maxi_write_cont <= 0;
          end 
          if((_maxi_write_req_fsm == 1) && !_maxi_write_req_fifo_almost_full && (maxi_awready || !maxi_awvalid) && (outstanding_wcount_0 < 6)) begin
            _maxi_write_req_fsm <= _maxi_write_req_fsm_init;
          end 
        end
      endcase
    end
  end

  localparam _maxi_write_data_fsm_1 = 1;
  localparam _maxi_write_data_fsm_2 = 2;

  always @(posedge CLK) begin
    if(RESETN_inv_buf) begin
      _maxi_write_data_fsm <= _maxi_write_data_fsm_init;
    end else begin
      case(_maxi_write_data_fsm)
        _maxi_write_data_fsm_init: begin
          if(_maxi_write_data_idle && !_maxi_write_req_fifo_empty && (_maxi_write_op_sel_fifo == 1)) begin
            _maxi_write_data_fsm <= _maxi_write_data_fsm_1;
          end 
        end
        _maxi_write_data_fsm_1: begin
          _maxi_write_data_fsm <= _maxi_write_data_fsm_2;
        end
        _maxi_write_data_fsm_2: begin
          if((_maxi_write_op_sel_buf == 1) && read_burst_packed_rvalid_181 && ((maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0)) && read_burst_packed_rlast_182) begin
            _maxi_write_data_fsm <= _maxi_write_data_fsm_init;
          end 
        end
      endcase
    end
  end

  localparam read_burst_packed_fsm_2_1 = 1;

  always @(posedge CLK) begin
    if(RST) begin
      read_burst_packed_fsm_2 <= read_burst_packed_fsm_2_init;
      read_burst_packed_addr_178 <= 0;
      read_burst_packed_stride_179 <= 0;
      read_burst_packed_length_180 <= 0;
      read_burst_packed_rvalid_181 <= 0;
      read_burst_packed_rlast_182 <= 0;
    end else begin
      case(read_burst_packed_fsm_2)
        read_burst_packed_fsm_2_init: begin
          read_burst_packed_addr_178 <= _maxi_write_local_addr_buf;
          read_burst_packed_stride_179 <= _maxi_write_local_stride_buf;
          read_burst_packed_length_180 <= _maxi_write_size_buf;
          read_burst_packed_rvalid_181 <= 0;
          read_burst_packed_rlast_182 <= 0;
          if((_maxi_write_data_fsm == 1) && (_maxi_write_op_sel_buf == 1) && (_maxi_write_size_buf > 0)) begin
            read_burst_packed_fsm_2 <= read_burst_packed_fsm_2_1;
          end 
        end
        read_burst_packed_fsm_2_1: begin
          if((maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0) && (read_burst_packed_length_180 > 0)) begin
            read_burst_packed_addr_178 <= read_burst_packed_addr_178 + read_burst_packed_stride_179;
            read_burst_packed_length_180 <= read_burst_packed_length_180 - 1;
            read_burst_packed_rvalid_181 <= 1;
          end 
          if((maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0) && (read_burst_packed_length_180 <= 1)) begin
            read_burst_packed_rlast_182 <= 1;
          end 
          if(read_burst_packed_rlast_182 && read_burst_packed_rvalid_181 && ((maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0))) begin
            read_burst_packed_rvalid_181 <= 0;
            read_burst_packed_rlast_182 <= 0;
          end 
          if(0) begin
            read_burst_packed_rvalid_181 <= 0;
            read_burst_packed_rlast_182 <= 0;
          end 
          if(read_burst_packed_rlast_182 && read_burst_packed_rvalid_181 && ((maxi_wready || !maxi_wvalid) && (_maxi_write_size_buf > 0))) begin
            read_burst_packed_fsm_2 <= read_burst_packed_fsm_2_init;
          end 
          if(0) begin
            read_burst_packed_fsm_2 <= read_burst_packed_fsm_2_init;
          end 
        end
      endcase
    end
  end


endmodule



module _maxi_read_req_fifo
(
  input CLK,
  input RST,
  input _maxi_read_req_fifo_enq,
  input [137-1:0] _maxi_read_req_fifo_wdata,
  output _maxi_read_req_fifo_full,
  output _maxi_read_req_fifo_almost_full,
  input _maxi_read_req_fifo_deq,
  output [137-1:0] _maxi_read_req_fifo_rdata,
  output _maxi_read_req_fifo_empty,
  output _maxi_read_req_fifo_almost_empty
);

  reg [137-1:0] mem [0:8-1];
  reg [3-1:0] head;
  reg [3-1:0] tail;
  wire is_empty;
  wire is_almost_empty;
  wire is_full;
  wire is_almost_full;
  assign is_empty = head == tail;
  assign is_almost_empty = head == (tail + 1 & 7);
  assign is_full = (head + 1 & 7) == tail;
  assign is_almost_full = (head + 2 & 7) == tail;
  wire [137-1:0] rdata;
  assign _maxi_read_req_fifo_full = is_full;
  assign _maxi_read_req_fifo_almost_full = is_almost_full || is_full;
  assign _maxi_read_req_fifo_empty = is_empty;
  assign _maxi_read_req_fifo_almost_empty = is_almost_empty || is_empty;
  assign rdata = mem[tail];
  assign _maxi_read_req_fifo_rdata = rdata;

  always @(posedge CLK) begin
    if(RST) begin
      head <= 0;
      tail <= 0;
    end else begin
      if(_maxi_read_req_fifo_enq && !is_full) begin
        mem[head] <= _maxi_read_req_fifo_wdata;
        head <= head + 1;
      end 
      if(_maxi_read_req_fifo_deq && !is_empty) begin
        tail <= tail + 1;
      end 
    end
  end


endmodule



module _maxi_write_req_fifo
(
  input CLK,
  input RST,
  input _maxi_write_req_fifo_enq,
  input [137-1:0] _maxi_write_req_fifo_wdata,
  output _maxi_write_req_fifo_full,
  output _maxi_write_req_fifo_almost_full,
  input _maxi_write_req_fifo_deq,
  output [137-1:0] _maxi_write_req_fifo_rdata,
  output _maxi_write_req_fifo_empty,
  output _maxi_write_req_fifo_almost_empty
);

  reg [137-1:0] mem [0:8-1];
  reg [3-1:0] head;
  reg [3-1:0] tail;
  wire is_empty;
  wire is_almost_empty;
  wire is_full;
  wire is_almost_full;
  assign is_empty = head == tail;
  assign is_almost_empty = head == (tail + 1 & 7);
  assign is_full = (head + 1 & 7) == tail;
  assign is_almost_full = (head + 2 & 7) == tail;
  wire [137-1:0] rdata;
  assign _maxi_write_req_fifo_full = is_full;
  assign _maxi_write_req_fifo_almost_full = is_almost_full || is_full;
  assign _maxi_write_req_fifo_empty = is_empty;
  assign _maxi_write_req_fifo_almost_empty = is_almost_empty || is_empty;
  assign rdata = mem[tail];
  assign _maxi_write_req_fifo_rdata = rdata;

  always @(posedge CLK) begin
    if(RST) begin
      head <= 0;
      tail <= 0;
    end else begin
      if(_maxi_write_req_fifo_enq && !is_full) begin
        mem[head] <= _maxi_write_req_fifo_wdata;
        head <= head + 1;
      end 
      if(_maxi_write_req_fifo_deq && !is_empty) begin
        tail <= tail + 1;
      end 
    end
  end


endmodule



module ram_w8_l2048_id0_0
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id0_0_0_addr,
  output [8-1:0] ram_w8_l2048_id0_0_0_rdata,
  input [8-1:0] ram_w8_l2048_id0_0_0_wdata,
  input ram_w8_l2048_id0_0_0_wenable,
  input ram_w8_l2048_id0_0_0_enable,
  input [9-1:0] ram_w8_l2048_id0_0_1_addr,
  output [8-1:0] ram_w8_l2048_id0_0_1_rdata,
  input [8-1:0] ram_w8_l2048_id0_0_1_wdata,
  input ram_w8_l2048_id0_0_1_wenable,
  input ram_w8_l2048_id0_0_1_enable
);

  reg [8-1:0] ram_w8_l2048_id0_0_0_rdata_out;
  assign ram_w8_l2048_id0_0_0_rdata = ram_w8_l2048_id0_0_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id0_0_1_rdata_out;
  assign ram_w8_l2048_id0_0_1_rdata = ram_w8_l2048_id0_0_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id0_0_0_enable) begin
      if(ram_w8_l2048_id0_0_0_wenable) begin
        mem[ram_w8_l2048_id0_0_0_addr] <= ram_w8_l2048_id0_0_0_wdata;
        ram_w8_l2048_id0_0_0_rdata_out <= ram_w8_l2048_id0_0_0_wdata;
      end else begin
        ram_w8_l2048_id0_0_0_rdata_out <= mem[ram_w8_l2048_id0_0_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id0_0_1_enable) begin
      if(ram_w8_l2048_id0_0_1_wenable) begin
        mem[ram_w8_l2048_id0_0_1_addr] <= ram_w8_l2048_id0_0_1_wdata;
        ram_w8_l2048_id0_0_1_rdata_out <= ram_w8_l2048_id0_0_1_wdata;
      end else begin
        ram_w8_l2048_id0_0_1_rdata_out <= mem[ram_w8_l2048_id0_0_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id0_1
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id0_1_0_addr,
  output [8-1:0] ram_w8_l2048_id0_1_0_rdata,
  input [8-1:0] ram_w8_l2048_id0_1_0_wdata,
  input ram_w8_l2048_id0_1_0_wenable,
  input ram_w8_l2048_id0_1_0_enable,
  input [9-1:0] ram_w8_l2048_id0_1_1_addr,
  output [8-1:0] ram_w8_l2048_id0_1_1_rdata,
  input [8-1:0] ram_w8_l2048_id0_1_1_wdata,
  input ram_w8_l2048_id0_1_1_wenable,
  input ram_w8_l2048_id0_1_1_enable
);

  reg [8-1:0] ram_w8_l2048_id0_1_0_rdata_out;
  assign ram_w8_l2048_id0_1_0_rdata = ram_w8_l2048_id0_1_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id0_1_1_rdata_out;
  assign ram_w8_l2048_id0_1_1_rdata = ram_w8_l2048_id0_1_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id0_1_0_enable) begin
      if(ram_w8_l2048_id0_1_0_wenable) begin
        mem[ram_w8_l2048_id0_1_0_addr] <= ram_w8_l2048_id0_1_0_wdata;
        ram_w8_l2048_id0_1_0_rdata_out <= ram_w8_l2048_id0_1_0_wdata;
      end else begin
        ram_w8_l2048_id0_1_0_rdata_out <= mem[ram_w8_l2048_id0_1_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id0_1_1_enable) begin
      if(ram_w8_l2048_id0_1_1_wenable) begin
        mem[ram_w8_l2048_id0_1_1_addr] <= ram_w8_l2048_id0_1_1_wdata;
        ram_w8_l2048_id0_1_1_rdata_out <= ram_w8_l2048_id0_1_1_wdata;
      end else begin
        ram_w8_l2048_id0_1_1_rdata_out <= mem[ram_w8_l2048_id0_1_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id0_2
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id0_2_0_addr,
  output [8-1:0] ram_w8_l2048_id0_2_0_rdata,
  input [8-1:0] ram_w8_l2048_id0_2_0_wdata,
  input ram_w8_l2048_id0_2_0_wenable,
  input ram_w8_l2048_id0_2_0_enable,
  input [9-1:0] ram_w8_l2048_id0_2_1_addr,
  output [8-1:0] ram_w8_l2048_id0_2_1_rdata,
  input [8-1:0] ram_w8_l2048_id0_2_1_wdata,
  input ram_w8_l2048_id0_2_1_wenable,
  input ram_w8_l2048_id0_2_1_enable
);

  reg [8-1:0] ram_w8_l2048_id0_2_0_rdata_out;
  assign ram_w8_l2048_id0_2_0_rdata = ram_w8_l2048_id0_2_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id0_2_1_rdata_out;
  assign ram_w8_l2048_id0_2_1_rdata = ram_w8_l2048_id0_2_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id0_2_0_enable) begin
      if(ram_w8_l2048_id0_2_0_wenable) begin
        mem[ram_w8_l2048_id0_2_0_addr] <= ram_w8_l2048_id0_2_0_wdata;
        ram_w8_l2048_id0_2_0_rdata_out <= ram_w8_l2048_id0_2_0_wdata;
      end else begin
        ram_w8_l2048_id0_2_0_rdata_out <= mem[ram_w8_l2048_id0_2_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id0_2_1_enable) begin
      if(ram_w8_l2048_id0_2_1_wenable) begin
        mem[ram_w8_l2048_id0_2_1_addr] <= ram_w8_l2048_id0_2_1_wdata;
        ram_w8_l2048_id0_2_1_rdata_out <= ram_w8_l2048_id0_2_1_wdata;
      end else begin
        ram_w8_l2048_id0_2_1_rdata_out <= mem[ram_w8_l2048_id0_2_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id0_3
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id0_3_0_addr,
  output [8-1:0] ram_w8_l2048_id0_3_0_rdata,
  input [8-1:0] ram_w8_l2048_id0_3_0_wdata,
  input ram_w8_l2048_id0_3_0_wenable,
  input ram_w8_l2048_id0_3_0_enable,
  input [9-1:0] ram_w8_l2048_id0_3_1_addr,
  output [8-1:0] ram_w8_l2048_id0_3_1_rdata,
  input [8-1:0] ram_w8_l2048_id0_3_1_wdata,
  input ram_w8_l2048_id0_3_1_wenable,
  input ram_w8_l2048_id0_3_1_enable
);

  reg [8-1:0] ram_w8_l2048_id0_3_0_rdata_out;
  assign ram_w8_l2048_id0_3_0_rdata = ram_w8_l2048_id0_3_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id0_3_1_rdata_out;
  assign ram_w8_l2048_id0_3_1_rdata = ram_w8_l2048_id0_3_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id0_3_0_enable) begin
      if(ram_w8_l2048_id0_3_0_wenable) begin
        mem[ram_w8_l2048_id0_3_0_addr] <= ram_w8_l2048_id0_3_0_wdata;
        ram_w8_l2048_id0_3_0_rdata_out <= ram_w8_l2048_id0_3_0_wdata;
      end else begin
        ram_w8_l2048_id0_3_0_rdata_out <= mem[ram_w8_l2048_id0_3_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id0_3_1_enable) begin
      if(ram_w8_l2048_id0_3_1_wenable) begin
        mem[ram_w8_l2048_id0_3_1_addr] <= ram_w8_l2048_id0_3_1_wdata;
        ram_w8_l2048_id0_3_1_rdata_out <= ram_w8_l2048_id0_3_1_wdata;
      end else begin
        ram_w8_l2048_id0_3_1_rdata_out <= mem[ram_w8_l2048_id0_3_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id1_0
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id1_0_0_addr,
  output [8-1:0] ram_w8_l2048_id1_0_0_rdata,
  input [8-1:0] ram_w8_l2048_id1_0_0_wdata,
  input ram_w8_l2048_id1_0_0_wenable,
  input ram_w8_l2048_id1_0_0_enable,
  input [9-1:0] ram_w8_l2048_id1_0_1_addr,
  output [8-1:0] ram_w8_l2048_id1_0_1_rdata,
  input [8-1:0] ram_w8_l2048_id1_0_1_wdata,
  input ram_w8_l2048_id1_0_1_wenable,
  input ram_w8_l2048_id1_0_1_enable
);

  reg [8-1:0] ram_w8_l2048_id1_0_0_rdata_out;
  assign ram_w8_l2048_id1_0_0_rdata = ram_w8_l2048_id1_0_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id1_0_1_rdata_out;
  assign ram_w8_l2048_id1_0_1_rdata = ram_w8_l2048_id1_0_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id1_0_0_enable) begin
      if(ram_w8_l2048_id1_0_0_wenable) begin
        mem[ram_w8_l2048_id1_0_0_addr] <= ram_w8_l2048_id1_0_0_wdata;
        ram_w8_l2048_id1_0_0_rdata_out <= ram_w8_l2048_id1_0_0_wdata;
      end else begin
        ram_w8_l2048_id1_0_0_rdata_out <= mem[ram_w8_l2048_id1_0_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id1_0_1_enable) begin
      if(ram_w8_l2048_id1_0_1_wenable) begin
        mem[ram_w8_l2048_id1_0_1_addr] <= ram_w8_l2048_id1_0_1_wdata;
        ram_w8_l2048_id1_0_1_rdata_out <= ram_w8_l2048_id1_0_1_wdata;
      end else begin
        ram_w8_l2048_id1_0_1_rdata_out <= mem[ram_w8_l2048_id1_0_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id1_1
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id1_1_0_addr,
  output [8-1:0] ram_w8_l2048_id1_1_0_rdata,
  input [8-1:0] ram_w8_l2048_id1_1_0_wdata,
  input ram_w8_l2048_id1_1_0_wenable,
  input ram_w8_l2048_id1_1_0_enable,
  input [9-1:0] ram_w8_l2048_id1_1_1_addr,
  output [8-1:0] ram_w8_l2048_id1_1_1_rdata,
  input [8-1:0] ram_w8_l2048_id1_1_1_wdata,
  input ram_w8_l2048_id1_1_1_wenable,
  input ram_w8_l2048_id1_1_1_enable
);

  reg [8-1:0] ram_w8_l2048_id1_1_0_rdata_out;
  assign ram_w8_l2048_id1_1_0_rdata = ram_w8_l2048_id1_1_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id1_1_1_rdata_out;
  assign ram_w8_l2048_id1_1_1_rdata = ram_w8_l2048_id1_1_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id1_1_0_enable) begin
      if(ram_w8_l2048_id1_1_0_wenable) begin
        mem[ram_w8_l2048_id1_1_0_addr] <= ram_w8_l2048_id1_1_0_wdata;
        ram_w8_l2048_id1_1_0_rdata_out <= ram_w8_l2048_id1_1_0_wdata;
      end else begin
        ram_w8_l2048_id1_1_0_rdata_out <= mem[ram_w8_l2048_id1_1_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id1_1_1_enable) begin
      if(ram_w8_l2048_id1_1_1_wenable) begin
        mem[ram_w8_l2048_id1_1_1_addr] <= ram_w8_l2048_id1_1_1_wdata;
        ram_w8_l2048_id1_1_1_rdata_out <= ram_w8_l2048_id1_1_1_wdata;
      end else begin
        ram_w8_l2048_id1_1_1_rdata_out <= mem[ram_w8_l2048_id1_1_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id1_2
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id1_2_0_addr,
  output [8-1:0] ram_w8_l2048_id1_2_0_rdata,
  input [8-1:0] ram_w8_l2048_id1_2_0_wdata,
  input ram_w8_l2048_id1_2_0_wenable,
  input ram_w8_l2048_id1_2_0_enable,
  input [9-1:0] ram_w8_l2048_id1_2_1_addr,
  output [8-1:0] ram_w8_l2048_id1_2_1_rdata,
  input [8-1:0] ram_w8_l2048_id1_2_1_wdata,
  input ram_w8_l2048_id1_2_1_wenable,
  input ram_w8_l2048_id1_2_1_enable
);

  reg [8-1:0] ram_w8_l2048_id1_2_0_rdata_out;
  assign ram_w8_l2048_id1_2_0_rdata = ram_w8_l2048_id1_2_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id1_2_1_rdata_out;
  assign ram_w8_l2048_id1_2_1_rdata = ram_w8_l2048_id1_2_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id1_2_0_enable) begin
      if(ram_w8_l2048_id1_2_0_wenable) begin
        mem[ram_w8_l2048_id1_2_0_addr] <= ram_w8_l2048_id1_2_0_wdata;
        ram_w8_l2048_id1_2_0_rdata_out <= ram_w8_l2048_id1_2_0_wdata;
      end else begin
        ram_w8_l2048_id1_2_0_rdata_out <= mem[ram_w8_l2048_id1_2_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id1_2_1_enable) begin
      if(ram_w8_l2048_id1_2_1_wenable) begin
        mem[ram_w8_l2048_id1_2_1_addr] <= ram_w8_l2048_id1_2_1_wdata;
        ram_w8_l2048_id1_2_1_rdata_out <= ram_w8_l2048_id1_2_1_wdata;
      end else begin
        ram_w8_l2048_id1_2_1_rdata_out <= mem[ram_w8_l2048_id1_2_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id1_3
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id1_3_0_addr,
  output [8-1:0] ram_w8_l2048_id1_3_0_rdata,
  input [8-1:0] ram_w8_l2048_id1_3_0_wdata,
  input ram_w8_l2048_id1_3_0_wenable,
  input ram_w8_l2048_id1_3_0_enable,
  input [9-1:0] ram_w8_l2048_id1_3_1_addr,
  output [8-1:0] ram_w8_l2048_id1_3_1_rdata,
  input [8-1:0] ram_w8_l2048_id1_3_1_wdata,
  input ram_w8_l2048_id1_3_1_wenable,
  input ram_w8_l2048_id1_3_1_enable
);

  reg [8-1:0] ram_w8_l2048_id1_3_0_rdata_out;
  assign ram_w8_l2048_id1_3_0_rdata = ram_w8_l2048_id1_3_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id1_3_1_rdata_out;
  assign ram_w8_l2048_id1_3_1_rdata = ram_w8_l2048_id1_3_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id1_3_0_enable) begin
      if(ram_w8_l2048_id1_3_0_wenable) begin
        mem[ram_w8_l2048_id1_3_0_addr] <= ram_w8_l2048_id1_3_0_wdata;
        ram_w8_l2048_id1_3_0_rdata_out <= ram_w8_l2048_id1_3_0_wdata;
      end else begin
        ram_w8_l2048_id1_3_0_rdata_out <= mem[ram_w8_l2048_id1_3_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id1_3_1_enable) begin
      if(ram_w8_l2048_id1_3_1_wenable) begin
        mem[ram_w8_l2048_id1_3_1_addr] <= ram_w8_l2048_id1_3_1_wdata;
        ram_w8_l2048_id1_3_1_rdata_out <= ram_w8_l2048_id1_3_1_wdata;
      end else begin
        ram_w8_l2048_id1_3_1_rdata_out <= mem[ram_w8_l2048_id1_3_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id2_0
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id2_0_0_addr,
  output [8-1:0] ram_w8_l2048_id2_0_0_rdata,
  input [8-1:0] ram_w8_l2048_id2_0_0_wdata,
  input ram_w8_l2048_id2_0_0_wenable,
  input ram_w8_l2048_id2_0_0_enable,
  input [9-1:0] ram_w8_l2048_id2_0_1_addr,
  output [8-1:0] ram_w8_l2048_id2_0_1_rdata,
  input [8-1:0] ram_w8_l2048_id2_0_1_wdata,
  input ram_w8_l2048_id2_0_1_wenable,
  input ram_w8_l2048_id2_0_1_enable
);

  reg [8-1:0] ram_w8_l2048_id2_0_0_rdata_out;
  assign ram_w8_l2048_id2_0_0_rdata = ram_w8_l2048_id2_0_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id2_0_1_rdata_out;
  assign ram_w8_l2048_id2_0_1_rdata = ram_w8_l2048_id2_0_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id2_0_0_enable) begin
      if(ram_w8_l2048_id2_0_0_wenable) begin
        mem[ram_w8_l2048_id2_0_0_addr] <= ram_w8_l2048_id2_0_0_wdata;
        ram_w8_l2048_id2_0_0_rdata_out <= ram_w8_l2048_id2_0_0_wdata;
      end else begin
        ram_w8_l2048_id2_0_0_rdata_out <= mem[ram_w8_l2048_id2_0_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id2_0_1_enable) begin
      if(ram_w8_l2048_id2_0_1_wenable) begin
        mem[ram_w8_l2048_id2_0_1_addr] <= ram_w8_l2048_id2_0_1_wdata;
        ram_w8_l2048_id2_0_1_rdata_out <= ram_w8_l2048_id2_0_1_wdata;
      end else begin
        ram_w8_l2048_id2_0_1_rdata_out <= mem[ram_w8_l2048_id2_0_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id2_1
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id2_1_0_addr,
  output [8-1:0] ram_w8_l2048_id2_1_0_rdata,
  input [8-1:0] ram_w8_l2048_id2_1_0_wdata,
  input ram_w8_l2048_id2_1_0_wenable,
  input ram_w8_l2048_id2_1_0_enable,
  input [9-1:0] ram_w8_l2048_id2_1_1_addr,
  output [8-1:0] ram_w8_l2048_id2_1_1_rdata,
  input [8-1:0] ram_w8_l2048_id2_1_1_wdata,
  input ram_w8_l2048_id2_1_1_wenable,
  input ram_w8_l2048_id2_1_1_enable
);

  reg [8-1:0] ram_w8_l2048_id2_1_0_rdata_out;
  assign ram_w8_l2048_id2_1_0_rdata = ram_w8_l2048_id2_1_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id2_1_1_rdata_out;
  assign ram_w8_l2048_id2_1_1_rdata = ram_w8_l2048_id2_1_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id2_1_0_enable) begin
      if(ram_w8_l2048_id2_1_0_wenable) begin
        mem[ram_w8_l2048_id2_1_0_addr] <= ram_w8_l2048_id2_1_0_wdata;
        ram_w8_l2048_id2_1_0_rdata_out <= ram_w8_l2048_id2_1_0_wdata;
      end else begin
        ram_w8_l2048_id2_1_0_rdata_out <= mem[ram_w8_l2048_id2_1_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id2_1_1_enable) begin
      if(ram_w8_l2048_id2_1_1_wenable) begin
        mem[ram_w8_l2048_id2_1_1_addr] <= ram_w8_l2048_id2_1_1_wdata;
        ram_w8_l2048_id2_1_1_rdata_out <= ram_w8_l2048_id2_1_1_wdata;
      end else begin
        ram_w8_l2048_id2_1_1_rdata_out <= mem[ram_w8_l2048_id2_1_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id2_2
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id2_2_0_addr,
  output [8-1:0] ram_w8_l2048_id2_2_0_rdata,
  input [8-1:0] ram_w8_l2048_id2_2_0_wdata,
  input ram_w8_l2048_id2_2_0_wenable,
  input ram_w8_l2048_id2_2_0_enable,
  input [9-1:0] ram_w8_l2048_id2_2_1_addr,
  output [8-1:0] ram_w8_l2048_id2_2_1_rdata,
  input [8-1:0] ram_w8_l2048_id2_2_1_wdata,
  input ram_w8_l2048_id2_2_1_wenable,
  input ram_w8_l2048_id2_2_1_enable
);

  reg [8-1:0] ram_w8_l2048_id2_2_0_rdata_out;
  assign ram_w8_l2048_id2_2_0_rdata = ram_w8_l2048_id2_2_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id2_2_1_rdata_out;
  assign ram_w8_l2048_id2_2_1_rdata = ram_w8_l2048_id2_2_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id2_2_0_enable) begin
      if(ram_w8_l2048_id2_2_0_wenable) begin
        mem[ram_w8_l2048_id2_2_0_addr] <= ram_w8_l2048_id2_2_0_wdata;
        ram_w8_l2048_id2_2_0_rdata_out <= ram_w8_l2048_id2_2_0_wdata;
      end else begin
        ram_w8_l2048_id2_2_0_rdata_out <= mem[ram_w8_l2048_id2_2_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id2_2_1_enable) begin
      if(ram_w8_l2048_id2_2_1_wenable) begin
        mem[ram_w8_l2048_id2_2_1_addr] <= ram_w8_l2048_id2_2_1_wdata;
        ram_w8_l2048_id2_2_1_rdata_out <= ram_w8_l2048_id2_2_1_wdata;
      end else begin
        ram_w8_l2048_id2_2_1_rdata_out <= mem[ram_w8_l2048_id2_2_1_addr];
      end
    end 
  end


endmodule



module ram_w8_l2048_id2_3
(
  input CLK,
  input [9-1:0] ram_w8_l2048_id2_3_0_addr,
  output [8-1:0] ram_w8_l2048_id2_3_0_rdata,
  input [8-1:0] ram_w8_l2048_id2_3_0_wdata,
  input ram_w8_l2048_id2_3_0_wenable,
  input ram_w8_l2048_id2_3_0_enable,
  input [9-1:0] ram_w8_l2048_id2_3_1_addr,
  output [8-1:0] ram_w8_l2048_id2_3_1_rdata,
  input [8-1:0] ram_w8_l2048_id2_3_1_wdata,
  input ram_w8_l2048_id2_3_1_wenable,
  input ram_w8_l2048_id2_3_1_enable
);

  reg [8-1:0] ram_w8_l2048_id2_3_0_rdata_out;
  assign ram_w8_l2048_id2_3_0_rdata = ram_w8_l2048_id2_3_0_rdata_out;
  reg [8-1:0] ram_w8_l2048_id2_3_1_rdata_out;
  assign ram_w8_l2048_id2_3_1_rdata = ram_w8_l2048_id2_3_1_rdata_out;
  reg [8-1:0] mem [0:512-1];

  always @(posedge CLK) begin
    if(ram_w8_l2048_id2_3_0_enable) begin
      if(ram_w8_l2048_id2_3_0_wenable) begin
        mem[ram_w8_l2048_id2_3_0_addr] <= ram_w8_l2048_id2_3_0_wdata;
        ram_w8_l2048_id2_3_0_rdata_out <= ram_w8_l2048_id2_3_0_wdata;
      end else begin
        ram_w8_l2048_id2_3_0_rdata_out <= mem[ram_w8_l2048_id2_3_0_addr];
      end
    end 
  end


  always @(posedge CLK) begin
    if(ram_w8_l2048_id2_3_1_enable) begin
      if(ram_w8_l2048_id2_3_1_wenable) begin
        mem[ram_w8_l2048_id2_3_1_addr] <= ram_w8_l2048_id2_3_1_wdata;
        ram_w8_l2048_id2_3_1_rdata_out <= ram_w8_l2048_id2_3_1_wdata;
      end else begin
        ram_w8_l2048_id2_3_1_rdata_out <= mem[ram_w8_l2048_id2_3_1_addr];
      end
    end 
  end


endmodule
