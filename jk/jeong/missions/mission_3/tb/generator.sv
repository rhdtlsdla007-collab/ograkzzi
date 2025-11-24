class generator;
    parameter RW_REGION = 8;
    logic [RW_REGION-1:0] apb_addr_list[$];

    transaction         gen_trx;


    task wr_gen();

        gen_trx = new();
        if (!gen_trx.randomize() with {is_write == 1; addr inside {['h00:'h7F]};})
        $display("[GEN] ERROR, randomization failed");

        gen_trx.print("[GEN]");
        apb_addr_list.push_back(gen_trx.addr);
    endtask

    task rd_gen();
        gen_trx = new();
        if(!gen_trx.randomize() with {is_write == 0; addr == apb_addr_list[0];})
        $display("[ERROR] ERROR, randomization failed");

        gen_trx.print("[GEN]");
    endtask

    task run();
        $display("[GEN] run() is started...");


        wr_gen();
        rd_gen();

    endtask
endclass
