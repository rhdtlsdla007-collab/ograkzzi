interface jk_ubus_slave_if ();
    logic reset;
    logic [15:0] addr;
    logic [1:0] size;
    logic read;
    logic write;
    logic bip;
    logic [7:0] data;
    logic wait_state;
    logic error;
    logic clk;
    
    clocking cb @(posedge clk);
        default input #1ns output #1ns;
        input read, write, bip, addr, size;
        output error, wait_state;
        inout data;
    endclocking 
    

endinterface: jk_ubus_slave_if
