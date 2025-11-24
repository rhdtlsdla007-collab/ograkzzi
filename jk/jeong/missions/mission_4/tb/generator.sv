class generator;
    parameter RW_REGION = 8;

    mailbox #(transaction) tr_mbox;
    logic [RW_REGION-1:0] apb_addr_list[$];
    event gen_done;
    mailbox #(transaction) rd_mbox;
    mailbox #(transaction) random_trx;
    transaction rd_trx;
    transaction         gen_trx;
    
    int num, repeat_val;

    task run();
        $display("[GEN] run() is started...");

        if ($value$plusargs("num=%d", num)) begin
            repeat_val = num;
        end else begin
            repeat_val = 16;
        end
        wr_gen();
        rd_gen();

        -> gen_done;

    endtask


    task wr_gen();
        random_trx = new();
        for (int i =0; i < repeat_val; i = i + 1) begin
            gen_trx = new();
            `ifdef VCS
                if(!gen_trx.randomize() with {is_write == 1; addr inside {['h00:'h7F]};})
                    $display ("ERROR, randomization failed");
                `else
                    random_trx.is_write = 1;
                    random_trx.addr = $urandom_range(32'h00, 32'h7F);
                    random_trx.data = $urandom;
                `endif 
                
                
                tr_mbox.put(gen_trx);
                apb_addr_list.push_back(gen_trx.addr);

            end
    endtask

    task rd_gen();
        foreach(apb_addr_list[i]) begin

            gen_trx = new();
            rd_trx = new();

            `ifdef VCS
            if (!gen_trx.randomize() with {is_write == 0; addr == apb_addr_list[i];})
                $display("[GEN] ERROR, randomization failed");
            `else
                gen_trx.is_write = 0;
                gen_trx.addr = apb_addr_list[i];
            `endif

            gen_trx.print("[GEN]");
            tr_mbox.put(gen_trx);
            rd_mbox.get(rd_trx);
            $display("[GEN] wr/rd transfer of addr %h generation is done...", rd_trx.addr);
        end

    endtask

endclass