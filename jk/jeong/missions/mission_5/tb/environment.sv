class environment;
    driver drv;
    monitor mon;
    generator gen;
    scoreboard scb;
    fcoverage fcov;

    mailbox #(transaction) tr_mbox, rd_mbox, cov_mbox, scb_mbox;


    event gen_done, scb_done, cov_done;


    function new(virtual apb_interface apb_if);
        mon = new(apb_if);
        drv = new(apb_if);
        gen = new();
        scb = new();
	fcov = new();


        tr_mbox = new();
        rd_mbox = new();
        scb_mbox = new();
	cov_mbox = new();

        gen.tr_mbox = tr_mbox;
        drv.tr_mbox = tr_mbox;

        gen.rd_mbox = rd_mbox;
        drv.rd_mbox = rd_mbox;

        mon.scb_mbox = scb_mbox;
        scb.scb_mbox = scb_mbox;
        mon.cov_mbox = cov_mbox;
	fcov.cov_mbox = cov_mbox;

        gen.gen_done = gen_done;
        scb.gen_done = gen_done;
	fcov.gen_done = gen_done;

        scb.scb_done = scb_done;
        scb.cov_done = cov_done;
        fcov.cov_done = cov_done;

    endfunction   

    
    task run();
        $display("[ENV] run() is started...");

        fork
            gen.run();
            drv.run();
            mon.run();
            scb.run();
	    fcov.run();

        join_any

        wait (scb_done.triggered);
            disable fork;

	    $display("\n================== COVERAGE CHECK =============\n");
	    $display("[%10t] [COV] Coverage - %0.2f%%\n", $time, $get_coverage());
	    $display("=======================================\n");

            $finish;

    endtask

endclass


