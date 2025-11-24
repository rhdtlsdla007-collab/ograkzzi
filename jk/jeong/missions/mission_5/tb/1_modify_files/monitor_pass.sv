class monitor;


    virtual apb_interface vif;
    transaction mon_trx;
    mailbox #(transaction) scb_mbox;


    function new(virtual apb_interface apb_if);
        this.vif = apb_if;
    endfunction

    task run();
        $display("[MON] run() is started...");
         
        forever begin
 	    mon_trx = new();
            @(vif.cb);
            wait (vif.pready && vif.pselx && vif.penable);

            mon_trx.addr = vif.paddr;
            mon_trx.is_write = vif.pwrite ? 1 : 0;
            mon_trx.data = vif.pwrite ? vif.pwdata : vif.prdata;
            mon_trx.pslverr = vif.pslverr;

            mon_trx.print("MON");
            scb_mbox.put(mon_trx);
            @(negedge vif.pready);
        end
    endtask







endclass
