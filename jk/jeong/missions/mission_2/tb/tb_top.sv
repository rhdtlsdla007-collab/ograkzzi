module tb_top;
    parameter clk_period = 10;

    logic pclk, presetn;
    
    apb_completer u0(
    .pclk(pclk),
    .presetn(presetn),
            .paddr(apb_if.paddr),
            .pwdata(apb_if.pwdata),
            .pselx(apb_if.pselx),
            .prdata(apb_if.prdata),
            .pslverr(apb_if.pslverr),
            .pready(apb_if.pready),
            .penable(apb_if.penable),
        .pwrite(apb_if.pwrite)  
    );

    apb_interface apb_if(
        .pclk(pclk),
        .presetn(presetn)
    );


    test_prog prog(
        .pclk(pclk),
        .presetn(presetn),
        .apb_if(apb_if)
    );

    always #(clk_period/2) pclk = ~pclk;

    parameter pre_reset = 5;

    initial begin
    pclk = 1;
    presetn = 1;

    #(pre_reset) presetn = 0;
    #(2*clk_period) presetn = 1;
    end

endmodule