module tb_verilog;

parameter RW_REGION = 8;
parameter DATA_WIDTH = 32;
parameter clk_period = 10;
parameter pre_reset = 5;
reg                         pclk;
reg                         presetn;
reg [RW_REGION - 1:0]       paddr;
reg [DATA_WIDTH - 1:0]      pwdata;
reg                         pselx;
reg                         penable;
reg                         pwrite;

wire                        pready;
wire [DATA_WIDTH - 1:0]     prdata;
wire                        pslverr;



reg [DATA_WIDTH - 1:0] data_list [15:0];

reg [RW_REGION - 1:0] addr_list [15:0];

reg [DATA_WIDTH - 1:0] temp_data;
integer                 repeat_val;
integer                num;
integer                err_cnt;

apb_completer u0(
    .pclk(pclk),
    .presetn(presetn),
    .paddr(paddr),
    .pwdata(pwdata),
    .pselx(pselx),
    .prdata(prdata),
    .pslverr(pslverr),
    .pready(pready),
    .penable(penable),
    .pwrite(pwrite)
);

always #(clk_period/2) pclk = ~pclk;


task init();
    begin
        pclk = 1; presetn =1;
        pselx = 0; err_cnt = 0;
        #(pre_reset) presetn = 0;
        @(posedge pclk);
        presetn = 1;
    end
endtask

task prepare_data();
    begin
        for (int i = 0; i < repeat_val; i = i + 1)
        begin
            data_list[i] = $random;
            addr_list[i] = $random;
        end
    end
endtask

task apb_wr(input [RW_REGION - 1:0] addr, input [DATA_WIDTH - 1:0] data);
    begin
        @(posedge pclk); pselx = 1; penable = 0;
        @(posedge pclk); penable = 1; pwrite = 1; 
        paddr = addr; pwdata = data;

        wait (pready == 1);

        @(posedge pclk); pselx = 0;

    end
endtask

task apb_rd(input [RW_REGION - 1:0] addr, output [DATA_WIDTH - 1:0] data);
    begin
        @(posedge pclk); pselx = 1; penable = 0;
        @(posedge pclk); penable = 1; pwrite = 0; 
        paddr = addr;

        wait (pready == 1);

        @(posedge pclk); 
        data = prdata;
        pselx = 0;
    end
endtask

initial begin
    if ($value$plusargs("num=%d", num)) begin
    repeat_val = num;
    end else begin
    repeat_val = 15;
    end

    init();
    prepare_data();

    for (int i = 0; i < repeat_val; i = i + 1) begin
        apb_wr(addr_list[i], data_list[i]);
        apb_rd(addr_list[i], temp_data);

        if (pslverr) begin
        $display("pslverr detected!");
        err_cnt = err_cnt + 1;
    end else begin
        
        if (temp_data == data_list[i]) begin

            $display("pass! addr:%h,  data:%h", addr_list[i], data_list[i]);


        end else begin
            $display("fail! addr:%h, expected:%h, real:%h", addr_list[i], data_list[i], temp_data);
            err_cnt = err_cnt + 1;

        end
    end

if (err_cnt != 0) $display("[RESULT] TEST FAILED, err_cnt : %d", err_cnt);
else $display("[RESULT] TEST PASSED");

end
$finish;
end

initial begin  
    $fsdbDumpfile("verilog_sim.fsdb");
    $fsdbDumpvars();
    $fsdbDumpvars(1, tb_verilog.u0, "+mda");
    $fsdbDumpvars(1, tb_verilog, "+mda");
end





endmodule
