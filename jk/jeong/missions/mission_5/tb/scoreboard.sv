class scoreboard;

    
    transaction scb_trx;
    transaction temp_tr;
    transaction tr_array[$] = {};

    mailbox #(transaction) scb_mbox, cov_mbox;
   

    event gen_done, scb_done, cov_done;

    int err_cnt = 0;
    int wr_cnt;

    task run();
        wr_cnt = 0;
        $display("[SCB] run() is started...");
        wait (gen_done.triggered);

        forever begin
            scb_trx = new();
            scb_mbox.get(scb_trx);
            scb_trx.print("[SCB]");
            if (scb_trx.is_write) begin
                tr_array.push_back(scb_trx);
                wr_cnt++;
            end else begin
                temp_tr = new();
                temp_tr = tr_array.pop_front();
                if (temp_tr.data == scb_trx.data) begin
                     
                    $display("[SCB] time = %0t, wr/rd transfer of addr %h mismatch data checked\n\ pwdata : %h, prdata : %h", $time, scb_trx.addr, temp_tr.data, scb_trx.data);
                    err_cnt++;
                end
            end
            if ((tr_array.size() == 0) && (wr_cnt != 0) && (!scb_mbox.try_peek(scb_trx))) break;
        end

        check();
        endtask


    function void check();
       $display ("\n=================SIMULATION RESULT=====================\n");
        if (err_cnt == 0)
           $display("[SCB] Simulation PASSED\n");
        else
            $display("[SCB] Simulation FAILED, err_cnt : %d\n", err_cnt);
            -> scb_done;
    endfunction










endclass
