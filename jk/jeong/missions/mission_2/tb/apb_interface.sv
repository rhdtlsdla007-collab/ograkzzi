interface apb_interface (input logic pclk, presetn);

    parameter DATA_WIDTH = 32;
    parameter RW_REGION = 8;
    logic [RW_REGION-1:0]   paddr;
    logic                   pselx;
    logic                   penable;
    logic                   pwrite;
    logic [DATA_WIDTH-1:0]  pwdata;
    logic [DATA_WIDTH-1:0]  prdata;
    logic                   pready;
    logic                   pslverr;


endinterface