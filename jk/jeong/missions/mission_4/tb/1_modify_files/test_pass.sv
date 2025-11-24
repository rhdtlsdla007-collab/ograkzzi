class test;

virtual apb_interface apb_if;
environment env;

function new(virtual apb_interface apb_if);
    env = new(apb_if);
endfunction

task run();
    $display("[TEST] run() is started...");
    env.run();
endtask



endclass
