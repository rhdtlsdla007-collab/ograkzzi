
class environment;
    driver drv;
    monitor mon;
    generator gen;

    function new(virtual apb_interface apb_if);
        mon = new(apb_if);
        drv = new(apb_if);
        gen = new();
    endfunction   

    
    task run();
        gen.run();
        drv.run();
        mon.run();
    endtask

endclass


