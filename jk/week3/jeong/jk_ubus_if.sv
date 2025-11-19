interface jk_ubus_if ();
    logic ubus_clock;
    logic ubus_reset;
    logic [15:0] ubus_addr;
    logic [1:0] ubus_size;
    logic ubus_read;
    logic ubus_write;
    logic ubus_bip;
    logic [7:0] ubus_data;
    logic ubus_wait;
    logic ubus_error;

    modport slave (
        input ubus_addr, ubus_size, ubus_read, ubus_write, ubus_bip,
        inout ubus_data,
        output ubus_wait, ubus_error
    );

    modport master (
        input ubus_wait, ubus_error,
        output ubus_addr, ubus_size, ubus_read, ubus_write, ubus_bip,
        inout ubus_data
    );

endinterface: jk_ubus_if
